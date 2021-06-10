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

class AddingExercisesData: Codable {
    var login: String
    var exersises: [Int: exerciseData]
    
    init(exersises: [Int: exerciseData]) {
        self.login = UserDefaults.standard.string(forKey: "userLogin")!
        self.exersises = exersises
    }
}

class AddingStageData: Codable {
    var login: String
    var name: String
    var weeks: [Int: days]
    
    init(name: String, weeks: [Int: days]) {
        self.login = UserDefaults.standard.string(forKey: "userLogin")!
        self.name = name
        self.weeks = weeks
    }
}

struct days: Codable {
    var days: [Int: exersises]
}

struct exersises: Codable {
    var exercises: [Int: exerciseData]
}

struct exerciseData: Codable {
    var name: String
    var weight: Int
    var reps: Int
    var sets: Int
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
