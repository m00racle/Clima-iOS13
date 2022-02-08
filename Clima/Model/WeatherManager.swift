//
//  WeatherManager.swift
//  Clima
//
//  https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/16253688
//  Created by Yanuar Heru on 24/01/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

// in order to use delgate in the WeatherViewController we need to build delegate protocol here

protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherModel: WeatherModel)
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
        // print(urlString) not needed since I already use Unit Testto verify this function
        performRequest(rawUrlString: urlString)
    }
    
    func performRequest(rawUrlString:String){
        //        create URL:
        if let url = URL(string: rawUrlString) {
            // create URL session
            let session = URLSession(configuration: .default)
            // set the config to default since this is only focusing on giving session the ability to networking.
            
            // Give the session a task
            // let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                    // RETURN without anything after it means break and stop out of this function
                }
                // no error then proceed to parse the data (remember it comes in format looks like JSON):
                if let safeData = data {
                    // parse the JSON data here:
                    // Now I want to make the weather data to be returned onto the WeatherViewController
                    // This means I need to make parseJSON to return to me weatherModel type
                    if let weather = self.parseJSON(weatherData: safeData) {
                        // this will only executed if the weather is WatherModel type and NOT nil
                        
                        // we make delegate weather manager to be able to pass the weatherModelType
                        self.delegate?.didUpdateWeather(weatherModel: weather)
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
            // I just return weather
            return weather
        } catch {
            print(error)
            // but what if this function failed to decode all the JSON message?
            // it will only return error which is not WeatherModel type
            // ANSWER: we can make this func to return optional WeatherModel which WeatherModel?
            // and we can return nil
            return nil
        }
        
    }
    
    
    
}
