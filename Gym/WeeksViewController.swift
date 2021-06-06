//
//  WeeksViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class WeeksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var stageID: Int?
    var weeks = Weeks()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let stageID = stageID else { return }
        APIServer.getWeeks(withStageID: stageID) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                self.weeks = try JSONDecoder().decode(Weeks.self, from: data)
                if self.weeks.answer != "fail" {
                    let weeksArray = try JSONDecoder().decode([Int: weeksAndDaysData].self, from: data)
                    self.weeks.data = weeksArray
                } else if self.weeks.answer == "fail" {
                    //Do smth
                    return
                }
            } catch {
                self.weeks = {
                    let weeks = Weeks()
                    weeks.data = [0: weeksAndDaysData.init(id: 0, number: 123) , 1: weeksAndDaysData.init(id: 1, number: 321)]
                    return weeks
                }()
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell  else { return }
        let weeksVC = segue.destination as! DaysViewController
        weeksVC.weekID = cell.tag
    }
    
    @IBAction func deleteStageButtonClicked(_ sender: UIButton) {
        guard let stageID = stageID else { return }
        APIServer.deleteStage(withStageID: stageID) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let answer = try JSONDecoder().decode(DataFromServer.self, from: data)
                if answer.answer == "fail" {
                    //Do smth
                } else if answer.answer == "success" {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

extension WeeksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "week-cell", for: indexPath)
        guard let weekNumber = weeks.data?[indexPath.row]?.number, let id = weeks.data?[indexPath.row]?.id else {
            return UITableViewCell(style: .default, reuseIdentifier: "week-cell")
        }
        cell.textLabel?.text = "Неделя " + String(weekNumber)
        cell.tag = id
        return cell
    }
    
    
}
