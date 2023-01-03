//
//  Weather.swift
//  GoodWeather
//
//  Created by Monil Gandhi on 26/09/20.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    var temp: Double?
    var humidity: Double?
}
