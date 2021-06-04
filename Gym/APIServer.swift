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
    static let url = "http://100be844791f.ngrok.io"
    
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
    
    static func register(withLogin login: String, withPassword password: String, withName name: String, withSurname surname: String, withLastname lastname: String, withPhoneNumber number: String, requestHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
            guard let url = URL(string: url + "/registration") else { return }
            var request = URLRequest(url: url)
            
        let body = ["login": login, "password": password, "name": name, "surname": surname, "lastname": lastname, "phone_number": number]
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
    
    static func previousStages(withUserName name: String, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_previous_stages") else { return }
        var request = URLRequest(url: url)
        
    let body = ["login": name]
    guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    static func getWeeks(withStageID stageID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_weeks") else { return }
        var request = URLRequest(url: url)
        
    let body = ["stage_id": stageID]
    guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    static func getDays(withWeekID weekID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_days") else { return }
        var request = URLRequest(url: url)
        
    let body = ["week_id": weekID]
    guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    static func getExercises(withDayID dayID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_exercises") else { return }
        var request = URLRequest(url: url)
        
    let body = ["day_id": dayID]
    guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
