//
//  DataFromServer.swift
//  Gym
//
//  Created by Adelina on 04.06.2021.
//  Copyright © 2021 AdelineHramtz. All rights reserved.
//

import Foundation

class Stages: DataFromServer {
    var data: [Int: stageData]?
}

class Weeks: DataFromServer {
    var data: [Int : weeksAndDaysData]?
}

class Days: DataFromServer {
    var data: [Int: weeksAndDaysData]?
}

class Exercises: DataFromServer {
    var data: [Int: exerciseData]?
}

struct exerciseData: Codable {
    var id: Int
    var number: Int
    var description: String?                    //Here must be smth else don't forget to change
}

struct weeksAndDaysData: Codable {
    var id: Int
    var number: Int
}

struct stageData: Codable {
    var id: Int
    var status: String
    var name: String?
}

class DataFromServer: Codable {
    var answer: String?
}
