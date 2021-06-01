//
//  ExerciseViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    var dayID: Int?
    var exercises: [Int: [String: Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let dayID = dayID else { return }
        APIServer.getExercises(withDayID: dayID) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                print(dictionary)
                self.exercises = dictionary as? [Int : [String : Any]]
            } catch {
                print(error)
            }
        }
    }
}

extension ExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercise-cell", for: indexPath)
        return cell
    }
    
    
}
