//
//  WeatherData.swift
//  Clima
//
//  Created by Yanuar Heru on 24/01/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    
    let main: Main
    
    let weather: [WeatherArray]
}

struct Main: Decodable {
    let temp: Double
    
}

struct WeatherArray: Decodable {
    let description: String
}
