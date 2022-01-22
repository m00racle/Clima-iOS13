//
//  WeatherManager.swift
//  Clima
//
//  Created by Yanuar Heru on 16/01/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{
//    put the URL address minus the q parameter for the city to search
//    use variable name weatherURL =
    let apiKey = "f8715d89da920a6b7b9890773d5b8a58"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
//    NOTE: I need to make var urlString variable here as higher scope to enbale this variable as test variable later on.
    var urlString = ""
    
//    add new function to get city weather data
//    func name fetchWeather(cityName:String)
    mutating func fetchWeather(cityName:String) {
        urlString = "\(weatherURL)?appid=\(apiKey)&q=\(cityName)"
//        print(urlString) not needed since I already use Unit Testto verify this function
    }
//    the main objective is to put the city name entry from UI and put it into the full URL address
//    TODO use the variable name cityURL = 
}
