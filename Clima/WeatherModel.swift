//
//  WeatherModel.swift
//  Clima
//
//  Created by Rudra on 17/07/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let tempurature: Double
    
    var tempuratureString: String {
        return String(format: "%.1f", tempurature)
    }
    
    var getWeatherCondionNames: String {
        switch conditionId {
            case (200...232):
                return "cloud.bolt"
            case (300...321):
                return "cloud.rainbow.half"
            case (500...531):
                return "cloud.rain"
            case (600...622):
                return "snowflake.circle"
            case (700...781):
                return "wind.snow.circle"
            case (800):
                return "cloud.sun.rain"
            case (801...804):
                return "cloud"
            default:
                return "cloud"
        }
    }
}
