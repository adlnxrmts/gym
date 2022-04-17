//
//  WeekAddViewController.swift
//  Gym
//
//  Created by Adelina on 10.06.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class WeekAddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var stageNameTextField: UITextField!
    var newWeeks = AddingStageData(name: "", weeks: [:])
    var visibleWeeks = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let weekNumber = Int(textField.text!) else { return }
        if newWeeks.weeks[weekNumber] == nil {
            newWeeks.weeks[weekNumber] = days(days: [:])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "week-to-day" {
            guard let destination = segue.destination as? DayAddViewController, let cell = sender as? WeekTableViewCell else { return }
            destination.weekNumber = Int(cell.weekNumberTextField.text!)
        }
    }
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard let stageName = stageNameTextField.text else {
            //Show alert
            return
        }
        newWeeks.name = stageName
        APIServer.saveStage(data: newWeeks) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let answer = try JSONDecoder().decode(DataFromServer.self, from: data)
                if answer.answer == "success" {
                    
                } else if answer.answer == "fail" {
                    //Do smth
                    return
                }
            } catch {
                
            }
        }
    }
}

extension WeekAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleWeeks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > visibleWeeks.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "week-add", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "week-editor", for: indexPath) as! WeekTableViewCell
            cell.weekNumberTextField.tag = indexPath.row
            cell.weekNumberTextField.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > visibleWeeks.count - 1 {
            self.visibleWeeks.append(visibleWeeks.count)
            tableView.reloadData()
        }
    }
}

class WeekTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weekNumberTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

