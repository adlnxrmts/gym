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
    static let url = "http://d39054639185.ngrok.io"
    
    static func performPostRequest(withURL url: URL, body: Data, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
    static func login(withUserName name: String, withPassword password: String, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/authentication") else { return }
        
        let body = ["login": name, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func register(withLogin login: String, withPassword password: String, withName name: String, withSurname surname: String, withLastname lastname: String, withPhoneNumber number: String, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/registration") else { return }
        
        let body = ["login": login, "password": password, "name": name, "surname": surname, "lastname": lastname, "phone_number": number]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)

    }
    
    static func upcomingStages(withUserName name: String, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_upcoming_stages") else { return }
            
        let body = ["login": name]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)

    }
    
    static func previousStages(withUserName name: String, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_previous_stages") else { return }
        
        let body = ["login": name]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func getWeeks(withStageID stageID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_weeks") else { return }
        
        let body = ["stage_id": stageID]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func getDays(withWeekID weekID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_days") else { return }
        
        let body = ["week_id": weekID]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func getExercises(withDayID dayID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/all_exercises") else { return }
        
        let body = ["day_id": dayID]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
    
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func deleteStage(withStageID stageID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/delete_stage") else { return }
        
        let body = ["stage_id": stageID]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func deleteWeek(withWeekID weekID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/delete_week") else { return }
        
        let body = ["week_id": weekID]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func deleteDay(withDayID dayID: Int, completionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/delete_day") else { return }
        
        let body = ["day_id": dayID]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return }
        
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: completionHandler)
    }
    
    static func saveStage(data: AddingStageData, complitionHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "/create_stage") else { return }
        
        guard let httpBody = try? JSONEncoder().encode(data) else { return }
        
        APIServer.performPostRequest(withURL: url, body: httpBody, completionHandler: complitionHandler)
    }
}
