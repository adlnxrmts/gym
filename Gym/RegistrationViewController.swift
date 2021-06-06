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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrationButtonClicked(_ sender: UIButton) {
        
        let userLogin = loginTextField.text
        let userPassword = passwordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        let userName = nameTextField.text
        let userSurname = surnameTextField.text
        let userLastname = lastnameTextField.text
        let userPhoneNumber = phoneNumberTextField.text
        
        //Check for empty slots
        if (userLogin == "" || userPassword == "" || userRepeatPassword == "" || userName == "" || userSurname == "" || userLastname == "" || userPhoneNumber == "") {
            self.showAlert(withTitle: "Пустые поля", andMessage: "Все поля должны быть заполнены.")
            return
        }
        
        //Check if passwords match
        if (userPassword != userRepeatPassword) {
            self.showAlert(withTitle: "Пароли не совпадают", andMessage: "Повторите ваш пароль.")
            return
        }
        
        //Place for URL request
        guard let login = userLogin, let password = userPassword, let name = userName, let surname = userSurname, let lastname = userLastname, let phoneNumber = userPhoneNumber else { return }
        APIServer.register(withLogin: login, withPassword: password, withName: name, withSurname: surname, withLastname: lastname, withPhoneNumber: phoneNumber) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode >= 500 && response.statusCode < 600 {
                    self.showAlert(withTitle: "Сервер временно недоступен", andMessage: "Произошла ошибка на сервере, поробуйте позже.")
                    return
                }
            }
            guard let data = data else { return }
            do {
                let answer = try JSONDecoder().decode(DataFromServer.self, from: data)
                if answer.answer == "fail" {
                    self.showAlert(withTitle: "Сервер временно недоступен", andMessage: "Произошла ошибка на сервере, поробуйте позже.")
                    return
                } else if answer.answer == "success" {
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
