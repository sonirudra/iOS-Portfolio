//
//  WeatherManager.swift
//  Clima
//
//  Created by DREAMWORLD on 12/07/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    private let baseUrl: String = "https://api.openweathermap.org/data/2.5/weather?appid=8a222435c559cee31f88f883baf5d568&units=metric"
    
    public func fetchWeather(ofCity cityName: String) {
        let urlString = "\(baseUrl)&q=\(cityName)"
//        print(urlString)
        performApiRequest(with: urlString)
    }
    
    private func performApiRequest(with urlString: String) {
        
        // 1. Create a URL
        if let URL = URL(string: urlString) {
            // 2. Create a URL session
            
            let session = URLSession(configuration: .default)
            
            // 3. Give session a task
            let task = session.dataTask(with: URL) { data, response, err in
                if err != nil {
                    print("error : \(err!)")
                    return
                }
                
                if let safeData = data {
                    self.parseResponse(weatherData: safeData)
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    private func parseResponse(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataModal.self, from: weatherData)
            let weatherImage = getImageFromId(id: decodedData.weather[0].id)
            print(weatherImage)
        } catch {
            print(error)
        }
        
    }
    
    private func getImageFromId(id: Int) -> String {
        switch id {
            case (200...232):
                return "cloud.bolt.fill"
            case (300...321):
                return "cloud.rainbow.half.fill"
            case (500...531):
                return "cloud.rain.fill"
            case (600...622):
                return "snowflake.circle.fill"
            case (700...781):
                return "wind.snow.circle.fill"
            case (800):
                return "cloud.sun.rain.fill"
            case (801...804):
                return "cloud.fill"
            default:
                return "cloud.fill"
        }
    }

}
