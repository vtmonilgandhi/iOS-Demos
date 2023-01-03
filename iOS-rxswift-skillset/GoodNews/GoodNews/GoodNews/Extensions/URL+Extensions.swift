//
//  URL+Extension.swift
//  GoodWeather
//
//  Created by Monil Gandhi on 16/01/21.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=2ba2879858196684c75ac246d417313b&units=imperial")
    }
}
