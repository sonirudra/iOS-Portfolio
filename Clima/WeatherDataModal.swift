//
//  WeatherDataModal.swift
//  Clima
//
//  Created by DREAMWORLD on 16/07/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherDataModal: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let pressure: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
