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
            self.showAlert(withTitle: "Пустые поля", andMessage: "Все поля должны быть заполнены.")
            return
        }
        
        //Place for URL request
        //TODO: Errors
        guard let login = userLogin, let password = userPassword else { return }
        APIServer.login(withUserName: login, withPassword: password) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 500 && response.statusCode < 600 {
                    self.showAlert(withTitle: "Сервер временно недоступен", andMessage: "Произошла ошибка на сервере, поробуйте позже.")
                    return
                }
            }
            guard let data = data else { return }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary as? [String: String]
                //Proccess the server response
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
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

