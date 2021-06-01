//
//  DaysViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class DaysViewController: UIViewController {

    var weekID: Int?
    var days: [Int: [String: Int]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let weekID = weekID else { return }
        APIServer.getDays(withWeekID: weekID) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                print(dictionary)
                self.days = dictionary as? [Int : [String : Int]]
            } catch {
                print(error)
            }
        }
        days = [0: ["id": 0, "number": 1], 1: ["id": 1, "number": 2]]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell  else { return }
        let weeksVC = segue.destination as! ExerciseViewController
        weeksVC.dayID = cell.tag
    }
}

extension DaysViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "day-cell", for: indexPath)
        guard let dayNumber = days?[indexPath.row]?["number"], let id = days?[indexPath.row]?["id"] else {
            return UITableViewCell(style: .default, reuseIdentifier: "day-cell")
        }
        cell.textLabel?.text = "День " + String(dayNumber)
        cell.tag = id
        return cell
    }
}
