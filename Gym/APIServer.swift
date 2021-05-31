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
    static let url = "http://64127da0eddf.ngrok.io"
    
    static func login(withUserName name: String, withPassword password: String, requestHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = URL(string: url + "") else { return } //Don't forget to change url
        var request = URLRequest(url: url)
        
//        request.httpMethod = "POST"
//        request.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)
        
        URLSession.shared.dataTask(with: request, completionHandler: requestHandler).resume()
    }
    
    static func register(withUserName name: String, withPassword password: String, requestHandler: @escaping (Data?, URLResponse?, Error?)-> Void) {
            guard let url = URL(string: url + "") else { return } //Don't forget to change url
            var request = URLRequest(url: url)
            
    //        request.httpMethod = "POST"
    //        request.addValue(<#T##value: String##String#>, forHTTPHeaderField: <#T##String#>)
            
            URLSession.shared.dataTask(with: request, completionHandler: requestHandler).resume()
        }
    
}
