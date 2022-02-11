//
//  WeatherManager.swift
//  Clima
//
//  https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16253688
//  Created by Yanuar Heru on 24/01/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

// in order to use delgate in the WeatherViewController we need to build delegate protocol here

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    // I add weatherManager using the internal naming thus later on to refer to this you only need to use self
    
    // add error handler to delegate
    func didFailWithError(error: Error)
}

struct WeatherManager{
    // put the URL address minus the q parameter for the city to search
    // use variable name weatherURL =
    let apiKey = "f8715d89da920a6b7b9890773d5b8a58"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    // NOTE: I need to make var urlString variable here as higher scope to enbale this variable as test variable later on.
    var urlString = ""
    
    // Now I need to declare the delegate
    var delegate: WeatherManagerDelegate?
    
    // add new function to get city weather data
    // func name fetchWeather(cityName:String)
    mutating func fetchWeather(cityName:String) {
        urlString = "\(weatherURL)?appid=\(apiKey)&q=\(cityName)&units=metric"
        //I use with since the func performRequest uses with rawUrlString
        //this will make code more readable:
        performRequest(with: urlString)
    }
    
    // using method overloading to use coordinates instead a City name to fetch weather info:
    mutating func fetchWeather(latitude:CLLocationDegrees, longitude:CLLocationDegrees) {
        // note the coordinates numbers are not a Double but special type of objects called CLLocationDegree!
        urlString = "\(weatherURL)?appid=\(apiKey)&lat=\(latitude)&lon=\(longitude)&units=metric"
        //I use with since the func performRequest uses with rawUrlString
        performRequest(with: urlString)
    }
    
    func performRequest(with rawUrlString:String){
        //here I use with to make the fucntion call and parameter passing above easier to read
        
        if let url = URL(string: rawUrlString) {
            // create URL session
            let session = URLSession(configuration: .default)
            
            // Give the session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    // pass the error using the delegate
                    // NOTE: we use self since we call delegate inside a closure!
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                // no error then proceed to parse the data (remember it comes in format looks like JSON):
                if let safeData = data {
                    // parse the JSON data here:
                    
                    if let weather = self.parseJSON(weatherData: safeData) {
                        // this will only executed if the weather is WatherModel type and NOT nil
                        
                        // The delegate requires the Weather Manager to be passed as self as param
                        self.delegate?.didUpdateWeather(self, weatherModel: weather)
                    }
                    
                }
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        // make new JSONDecoder instance here:
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            // now I need to return WeatherModel type object to the performRequest func
            
            return weather
        } catch {
            // same here I need to send this error handling using delegate
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
}
