//
//  WeekAddViewController.swift
//  Gym
//
//  Created by Adelina on 10.06.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class WeekAddViewController: UIViewController, UITextFieldDelegate {

    var newWeeks = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newWeeks[textField.tag] = textField.text ?? ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "week-to-day" {
            guard let destination = segue.destination as? DayAddViewController, let cell = sender as? WeekTableViewCell else { return }
            destination.weekNumber = Int(cell.weekNumberTextField.text!)
        }
    }
}

extension WeekAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newWeeks.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > newWeeks.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "week-add", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "week-editor", for: indexPath) as! WeekTableViewCell
            cell.weekNumberTextField.tag = indexPath.row
            cell.weekNumberTextField.delegate = self
            cell.weekNumberTextField.text = newWeeks[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > newWeeks.count - 1 {
            self.newWeeks.append("")
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

