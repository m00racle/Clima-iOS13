//
//  WeatherData.swift
//  Clima
//
//  https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16253688#content
//  Create Weather Model and Understand Computed Properties
//  Created by Yanuar Heru on 24/01/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

// I change the Decodable into Codable as type alias that combine two protocols Decodable and Encodable
// Note: Encodable is the inverse of decodable which intended to convert to JSON format.

struct WeatherData: Codable {
    
    let name: String
    
    let main: Main
    
    let weather: [WeatherArray]
}

struct Main: Codable {
    let temp: Double
    
}

struct WeatherArray: Codable {
    let id: Int
//    I change this to Int to match the documentation on https://openweathermap.org/weather-conditions
//    this is how the API sent response on the type of weather which is more detailed rather than just the String on what the weather is
    let description: String
}
