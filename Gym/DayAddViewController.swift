//
//  DayAddViewController.swift
//  Gym
//
//  Created by Adelina on 11.06.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class DayAddViewController: UIViewController, UITextFieldDelegate {
    
    var newDays: [Int: exersises?] = [:]
    var visibleDays = [0]
    var weekNumber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let dayNumber = Int(textField.text!) else { return }
        newDays[dayNumber] = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "day-to-exercise" {
            guard let destination = segue.destination as? ExerciseAddViewController, let cell = sender as? DayTableViewCell else { return }
            destination.dayNumber = Int(cell.dayNumberTextField.text!)
        }
    }
    
}

extension DayAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleDays.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > visibleDays.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "day-add", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "day-editor", for: indexPath) as! DayTableViewCell
            cell.dayNumberTextField.tag = indexPath.row
            cell.dayNumberTextField.delegate = self
//            cell.dayNumberTextField.text = newDays[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > visibleDays.count - 1 {
            self.visibleDays.append(visibleDays.count)
            tableView.reloadData()
        }
    }
}

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayNumberTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
