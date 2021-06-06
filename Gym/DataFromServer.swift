//
//  DataFromServer.swift
//  Gym
//
//  Created by Adelina on 04.06.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import Foundation

class Stages: Codable {
    var answer: String?
    var data: [Int: stageData]?
}

class Weeks: Codable {
    var answer: String?
    var data: [Int : weeksAndDaysData]?
}

class Days: Codable {
    var answer: String?
    var data: [Int: weeksAndDaysData]?
}

class Exercises: Codable {
    var answer: String?
    var data: [Int: exerciseData]?
}

class LoginData: Codable {
    var answer: String?
    var name: String?
    var surname: String?
    var lastname: String?
}

struct exerciseData: Codable {
    var id: Int
    var number: Int
    var description: String?                    //Here must be smth else don't forget to change
}

struct weeksAndDaysData: Codable {
    var answer: String?
    var id: Int
    var number: Int
}

struct stageData: Codable {
    var answer: String?
    var id: Int
    var status: String
    var name: String?
}

class DataFromServer: Codable {
    var answer: String?
}
