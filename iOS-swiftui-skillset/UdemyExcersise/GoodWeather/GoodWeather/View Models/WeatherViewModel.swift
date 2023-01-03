//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Monil Gandhi on 26/09/20.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    private let weatherService: WeatherService!
    @Published var weather = Weather()
    
    init() {
        self.weatherService = WeatherService()
    }
    
    var temperature: String {
        if let temp = self.weather.temp {
            return String(format: "%.0f", temp)
        } else {
            return ""
        }
    }
    
    var humidity: String {
        if let humidity = self.weather.humidity {
            return String(format: "%.0f", humidity)
        } else {
            return ""
        }
    }
    
    var cityName: String = ""
    
    func search() {
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) {
            featchWeather(by: city)
        }
    }
    
    private func featchWeather(by city: String) {
        self.weatherService.getWeather(city: city) { weather in
            if let weather = weather {
                DispatchQueue.main.async {
                    self.weather = weather
                }
            }
        }
    }
}
