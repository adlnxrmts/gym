//
//  WeeksViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class WeeksViewController: UIViewController {
    
    var stageID: Int?
    var weeks: [Int: [String: Int]]?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let stageID = stageID else { return }
        APIServer.getWeeks(withStageID: stageID) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                self.weeks = dictionary as? [Int : [String : Int]]
            } catch {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell  else { return }
        let weeksVC = segue.destination as! DaysViewController
        weeksVC.weekID = cell.tag
    }
    
}

extension WeeksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "week-cell", for: indexPath)
        guard let weekNumber = weeks?[indexPath.row]?["number"], let id = weeks?[indexPath.row]?["id"] else {
            return UITableViewCell(style: .default, reuseIdentifier: "week-cell")
        }
        cell.textLabel?.text = "Неделя " + String(weekNumber)
        cell.tag = id
        return cell
    }
    
    
}
