//
//  StageViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class StageViewController: UIViewController {

    var stageType = StageType.notSpecified
    var stages: [Int: [String: Any]]?
    
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
            APIServer.upcomingStages(withUserName: userName) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                guard let data = data else { return }
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                    self.stages = (dictionary as! [Int : [String : Any]])
                } catch {
                    print(error)
                }
            }
            break
        case .previous:
            APIServer.previousStages(withUserName: userName) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                guard let data = data else { return }
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                    self.stages = (dictionary as! [Int : [String : Any]])
                } catch {
                    print(error)
                }
            }
            break
        default:
            break
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
        return stages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stages-cell", for: indexPath)
        guard let text = stages?[indexPath.row]?["name"] as? String, let id = stages?[indexPath.row]?["id"] as? Int else {
            return UITableViewCell(style: .default, reuseIdentifier: "stages-cell")
        }
        cell.tag = id
        cell.textLabel?.text = text
        return cell
    }
    
}
