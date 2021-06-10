//
//  StageAddViewController.swift
//  Gym
//
//  Created by Adelina on 10.06.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class StageAddViewController: UIViewController, UITextFieldDelegate {
    
    var newStages = [""]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension StageAddViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newStages.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row > newStages.count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "stage-add", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "stage-editor", for: indexPath) as! StageTableViewCell
            cell.stageNameTextField.tag = indexPath.row
            cell.stageNameTextField.delegate = self
            cell.stageNameTextField.text = newStages[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > newStages.count - 1 {
            self.newStages.append("")
            tableView.reloadData()
        }
    }
}

class StageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stageNameTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
