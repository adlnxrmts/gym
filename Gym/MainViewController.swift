//
//  MainViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previous-stages" || segue.identifier == "upcoming-stages" {
            let stageVC = segue.destination as! StageViewController
            if segue.identifier == "upcoming-stages" {
                stageVC.stageType = StageViewController.StageType.upcoming
            } else if segue.identifier == "previous-stages" {
                stageVC.stageType = StageViewController.StageType.previous
            }
        } else if segue.identifier == "add-exercise" {
            let exerciseVC = segue.destination as! ExerciseAddViewController
//            exerciseVC.saveButton.isEnabled = true
        }
    }
}
