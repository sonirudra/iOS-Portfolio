//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var weatherManager: WeatherManager = WeatherManager()
    private var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    @IBAction func searchBtnPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        weatherManager.fetchWeather(ofCity: searchTextField.text!)
    }
    
    
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(weatherData: WeatherModel) {
        DispatchQueue.main.sync {
            temperatureLabel.text = weatherData.tempuratureString
            cityLabel.text = weatherData.cityName
            conditionImageView.image = UIImage(systemName: weatherData.getWeatherCondionNames)
        }
    }
    
    func didFailedWithError(err: Error) {
        print(err)
    }
}

//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        weatherManager.fetchWeather(ofCity: textField.text!)
        textField.text = ""
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got the location")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error while getting the location")
        print(error)
    }
}
