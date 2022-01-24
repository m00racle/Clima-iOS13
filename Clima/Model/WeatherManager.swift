//
//  WeatherManager.swift
//  Clima
//
//  Created by Yanuar Heru on 24/01/22.
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
        urlString = "\(weatherURL)?appid=\(apiKey)&q=\(cityName)&units=metric"
        //        print(urlString) not needed since I already use Unit Testto verify this function
        performRequest(rawUrlString: urlString)
    }
    
    func performRequest(rawUrlString:String){
        //        create URL:
        if let url = URL(string: rawUrlString) {
            //            create URL session
            let session = URLSession(configuration: .default)
            // set the config to default since this is only focusing on giving session the ability to networking.
            
            //            Give the session a task
            //            let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                    //            RETURN without anything after it means break and stop out of this function
                }
                //        no error then proceed to parse the data (remember it comes in format looks like JSON):
                if let safeData = data {
                    // parse the JSON data here:
                    self.parseJSON(weatherData: safeData)
                    
                }
            }
            
            task.resume()
            
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        // make new JSONDecoder instance here:
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            print(decodedData.main.temp)
        } catch {
            print(error)
        }
        
    }
    
}
