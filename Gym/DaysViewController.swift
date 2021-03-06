//
//  DaysViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class DaysViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var weekID: Int?
    var days = Days()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let weekID = weekID else { return }
        APIServer.getDays(withWeekID: weekID) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                self.days = try JSONDecoder().decode(Days.self, from: data)
                if self.days.answer != "fail" {
                    let daysArray = try JSONDecoder().decode([Int: weeksAndDaysData].self, from: data)
                    self.days.data = daysArray
                } else if self.days.answer == "fail" {
                    //Do smth
                    return
                }
            } catch {
                self.days = {
                    let days = Days()
                    days.data = [0: weeksAndDaysData.init(id: 0, number: 123), 1: weeksAndDaysData.init(id: 1, number: 321)]
                    return days
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
        let weeksVC = segue.destination as! ExerciseViewController
        weeksVC.dayID = cell.tag
    }
    @IBAction func deleteWeekButtonClicked(_ sender: UIButton) {
        guard let weekID = weekID else { return }
        APIServer.deleteWeek(withWeekID: weekID) { (data, response, error) in
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

extension DaysViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "day-cell", for: indexPath)
        guard let dayNumber = days.data?[indexPath.row]?.number, let id = days.data?[indexPath.row]?.id else {
            return UITableViewCell(style: .default, reuseIdentifier: "day-cell")
        }
        cell.textLabel?.text = "День " + String(dayNumber)
        cell.tag = id
        return cell
    }
}
