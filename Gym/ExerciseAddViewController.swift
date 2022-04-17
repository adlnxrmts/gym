//
//  ExerciseAddViewController.swift
//  Gym
//
//  Created by Adelina on 11.06.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class ExerciseAddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    var newExercises = AddingExercisesData(exersises: [0: exerciseData(name: "", weight: 0, reps: 0, sets: 0)])
    var dayNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.accessibilityIdentifier {
        case "name":
            newExercises.exersises[textField.tag]?.name = textField.text!
        case "weight":
            newExercises.exersises[textField.tag]?.weight = Int(textField.text!) ?? 0
        case "sets":
            newExercises.exersises[textField.tag]?.sets = Int(textField.text!) ?? 0
        case "reps":
            newExercises.exersises[textField.tag]?.reps = Int(textField.text!) ?? 0
        default:
            break
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
    }
}

extension ExerciseAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newExercises.exersises.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > newExercises.exersises.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "exercise-add", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "exercise-editor", for: indexPath) as! ExerciseTableViewCell
            cell.exerciseNameTextField.accessibilityIdentifier = "name"
            cell.weightTextField.accessibilityIdentifier = "weight"
            cell.setsTextField.accessibilityIdentifier = "sets"
            cell.repsTextField.accessibilityIdentifier = "reps"
            let textFields = [cell.exerciseNameTextField, cell.weightTextField, cell.setsTextField, cell.repsTextField]
            for textField in textFields {
                textField?.tag = indexPath.row
                textField?.delegate = self
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > newExercises.exersises.count - 1 {
            self.newExercises.exersises[indexPath.row] = exerciseData(name: "", weight: 0, reps: 0, sets: 0)
            tableView.reloadData()
        }
    }
}

extension ExerciseAddViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let vc = viewController as? DayAddViewController, let dayNum = dayNumber {
            vc.newDays[dayNum]?.exercises = newExercises.exersises
            self.navigationController?.delegate = vc
        }
    }
}

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var setsTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
