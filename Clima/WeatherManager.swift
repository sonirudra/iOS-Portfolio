//
//  WeatherManager.swift
//  Clima
//
//  Created by Rudra on 12/07/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherData: WeatherModel)
    func didFailedWithError(err: Error)
}

struct WeatherManager {
    private let baseUrl: String = "https://api.openweathermap.org/data/2.5/weather?appid=8a222435c559cee31f88f883baf5d568&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    public func fetchWeather(ofCity cityName: String) {
        let urlString = "\(baseUrl)&q=\(cityName)"
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
                    delegate?.didFailedWithError(err: err!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseResponse(weatherData: safeData) {
                        delegate?.didUpdateWeather(weatherData: weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    private func parseResponse(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataModal.self, from: weatherData)
            let id: Int = decodedData.weather[0].id
            let cityName: String = decodedData.name
            let temp: Double = decodedData.main.temp
            
            let currentWeather: WeatherModel = WeatherModel(conditionId: id, cityName: cityName, tempurature: temp)
            
            return currentWeather
        } catch {
            print(error)
            delegate?.didFailedWithError(err: error)
            return nil
        }
        
    }
}
