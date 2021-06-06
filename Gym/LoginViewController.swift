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
                let answer = try JSONDecoder().decode(LoginData.self, from: data)
                if answer.answer == "incorrect login" {
                    self.showAlert(withTitle: "Такого пользователя не существует", andMessage: "Попробуйте ввести логин заново или зарегестрироваться.")
                    return
                } else if answer.answer == "incorrect password" {
                    self.showAlert(withTitle: "Неверный пароль", andMessage: "")
                    return
                } else if answer.answer == "success" {
                    guard let name = answer.name, let lastname = answer.lastname else {  print("Oh, decodable... Again...")
                        return }
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Добро пожаловать, \(lastname) \(name)!", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: { (_) in
                            self.saveAndChangeRootVC(withUserLogin: login, andPassword: password)
                        }))
                        self.present(alert, animated: true)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func saveAndChangeRootVC(withUserLogin login: String, andPassword password: String) {
        //Save data
        UserDefaults.standard.set(login, forKey: "userLogin")
        UserDefaults.standard.set(password, forKey: "userPassword")
        UserDefaults.standard.set(true, forKey: "isUserLockedIn")
        
        //Show protected screens
        let navVC = UIStoryboard.navigationViewController()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.window?.rootViewController = navVC
    }
    
    func showAlert(withTitle title: String, andMessage message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

