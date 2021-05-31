//
//  StageViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class StageViewController: UIViewController {

    var stageType = StageType.notSpecified
    
    enum StageType {
        case previous
        case upcoming
        case notSpecified
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = UserDefaults.standard.string(forKey: "userLogin")!
        
        //Place for a url request
        switch stageType {
        case .upcoming:
            APIServer.upcomingStages(withUserName: userName) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                guard let data = data else { return }
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: [])
                    print(dictionary)
                } catch {
                    print(error)
                }
            }
            break
        default:
            break
        }
        
    }
}
