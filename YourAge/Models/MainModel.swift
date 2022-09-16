//
//  MainModel.swift
//  YourAge
//
//  Created by peter wi on 9/14/22.
//

import Foundation

struct MainModel: Codable {
    let name: String
    let age: Int
    let count: Int
}

struct MainModelLocal: Codable {
    let name: String
    let age: Int
    let count: Int
    let country_id: String
}
