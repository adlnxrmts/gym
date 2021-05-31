//
//  StoryboardExtention.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import UIKit


extension UIStoryboard {
    
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func loginViewController() -> LoginViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
    }
    
    static func registrationViewController() -> RegistrationViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "RegistrationViewController") as? RegistrationViewController
    }
    
    static func navigationViewController() -> UIViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "NavigationViewController")
    }
    
}
