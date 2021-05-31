//
//  RegistrationViewController.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrationButtonClicked(_ sender: UIButton) {
        
        let userLogin = loginTextField.text
        let userPassword = passwordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        //Check for empty slots
        if (userLogin == "" || userPassword == "" || userRepeatPassword == "") {
            //Show alert
            return
        }
        
        //Check if passwords match
        if (userPassword != userRepeatPassword) {
            //Show alert
            return
        }
        
        //Place for URL request
        guard let login = userLogin, let password = userPassword else { return }
        APIServer.register(withUserName: login, withPassword: password) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary as? [String: String]
                //Don't forget to change dictionary type
                print(dictionary ?? "Troubles with serializatoin json in login")
            } catch {
                print(error)
            }
        }
        
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
