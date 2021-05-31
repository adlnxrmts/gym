//
//  APIServer.swift
//  Gym
//
//  Created by Adelina on 31.05.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import Foundation

class APIServer {
    
    //DON'T FORGET TO PUT WORKING NGROK LINK
    static let url = "http://bfd6e80f1b86.ngrok.io"
    
    static func login(withUserName name: String, withPassword password: String, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/authentication") else { return }
        var request = URLRequest(url: url)
        
        let body = ["login": name, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    static func register(withUserName name: String, withPassword password: String, requestHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
            guard let url = URL(string: url + "/registration") else { return }
            var request = URLRequest(url: url)
            
        let body = ["login": name, "password": password, "name": "galya", "surname": "petrova", "lastname": "igorevna", "phone_number": "84568273456"]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
            request.httpMethod = "POST"
            request.httpBody = httpBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request, completionHandler: requestHandler).resume()
        }
    
    static func upcomingStages(withUserName name: String, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
            guard let url = URL(string: url + "/all_upcoming_stages") else { return }
            var request = URLRequest(url: url)
            
        let body = ["login": name]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
            request.httpMethod = "POST"
            request.httpBody = httpBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
        }
    
}
