//
//  WeatherModel.swift
//  Clima
//
//  Created by Yanuar Heru on 08/02/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
//    computed property in struct:
    // NOTE: we use var since the value of conditionName (computed prop here) is always changing
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    //TODO make temperature into String format using computed prop:
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
}
