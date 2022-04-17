//
//  StageViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class StageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var stageType = StageType.notSpecified
    var stages = Stages()
    
    enum StageType {
        case previous
        case upcoming
        case notSpecified
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = UserDefaults.standard.string(forKey: "userLogin")!
        
        //Place for a url request
        switch stageType {
        case .upcoming:
            APIServer.upcomingStages(withUserName: userName, completionHandler: getData(data:response:error:))
            break
        case .previous:
            APIServer.previousStages(withUserName: userName, completionHandler: getData(data:response:error:))
            break
        default:
            print("im here")
            break
        }
    }
    
    func getData(data: Data?, response: URLResponse?, error: Error?) {
        if let response = response {
            print(response)
        }
        guard let data = data else { return }
        do {
            self.stages = try JSONDecoder().decode(Stages.self, from: data)
            if self.stages.answer != "fail" {
                let stagesArray = try JSONDecoder().decode([Int: stageData].self, from: data)
                self.stages.data = stagesArray
            } else if self.stages.answer == "fail" {
                //TODO: Do sOmEtHiNg
                return
            }
        } catch {
            self.stages = {
                let stages = Stages()
                stages.data = [0: stageData.init(id: 0, status: "", name: "Это тестовые данные"), 1: stageData.init(id: 1, status: "", name: "Значит все плохо")]
                return stages
            }()
            print(error)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell  else { return }
        let weeksVC = segue.destination as! WeeksViewController
        weeksVC.stageID = cell.tag
    }
    
}

extension StageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stages.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stages-cell", for: indexPath)
        guard let text = stages.data?[indexPath.row]?.name, let id = stages.data?[indexPath.row]?.id else {
            return UITableViewCell(style: .default, reuseIdentifier: "stages-cell")
        }
        cell.tag = id
        cell.textLabel?.text = text
        return cell
    }
    
}
