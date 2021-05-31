//
//  ViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func enterButtonClicked(_ sender: UIButton) {
        
        //Check for empty slots
        let userLogin = loginTextField.text
        let userPassword = passwordTextField.text
        
        if (userLogin == "" || userPassword == "") {
            //Show alert
            return
        }
        
        //Place for URL request
        
        //Save data
        UserDefaults.standard.set(userLogin, forKey: "userLogin")
        UserDefaults.standard.set(userPassword, forKey: "userPassword")
        UserDefaults.standard.set(true, forKey: "isUserLockedIn")
        
        //Show protected screens
        let navVC = UIStoryboard.navigationViewController()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = navVC
    }
    
}

