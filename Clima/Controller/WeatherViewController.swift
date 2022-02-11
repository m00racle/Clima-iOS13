//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
// I need to import Core Location to access the phone GPS data

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
//    instantiate the WeatherManager struct to instance weatherManager
    var weatherManger = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.search textfield
        
        // ask user permission for location data
        locationManager.requestWhenInUseAuthorization()
        // NOTE: I choose to use when in use so that user can only share his/her location when app is in use
        
        // set the delegate for CLLocationManager:
        locationManager.delegate = self
        
        // then I need one time location data (remember I don't want to track the location whole time):
        locationManager.requestLocation()
        
        
//        delegate keyboard interaction to
        searchTextField.delegate = self
        
        // remember to add this delegate function in viewDidLoad so that the delegate will not seen as empty when calling or implementing the didUpdateWeather later on
        weatherManger.delegate = self
    }
    
}

// MARK: - CLLocationManager
// Handles the Core location manager delegates (declared on viewDidLoad func above
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locations parameter above consist of array of information about the current location
        // we use the locations.last to find the last and hopefully most accurate location
        // since locations.last? is an optional thus I need to bind it to location and test if it is not nil:
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            // NOTE: I need to stop updateing to ensure the next time locationManager is called it will give me the current or last location not stored previous location.
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            // but having coordinate will not help a lot but we can use this to call API USING THE COORDINATE
            // we use fetchWeather that uses lat and lon data
            weatherManger.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        // calling locationManager.requeestLocation will not sufficient if we don't move coordinate location
        // I need to stop the previous locationManager first: in func location manager
        locationManager.requestLocation()
    }
}

// MARK: - UITextfiedlDelegate
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchButtonPressed(_ sender: UIButton) {
//        hide the keyboard
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        this is what happen if the return key in the keyboard is pressed
//        note that in the button settings we change the return to go
        
        searchTextField.endEditing(true)
//        This will call the textFieldDidEndEditing func
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        Be careful this must be wrapped up to ensure city is a String
//        this is why I use if let city to make sure only pass String parameter to the WeatherManager
        
        if let city = searchTextField.text {
            weatherManger.fetchWeather(cityName: city)
        }
//        then call the weatherManager.fetchWeather method and pass city as parameter.
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        this is to validate if text field should end editing if user press outside the text field or keyboard
        if (textField.text != "") {
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }

}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    // we prepare didUpdateWeather function to receive the weathermodel data
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherModel.temperatureString
            // DispatchQueue.main.async is the closure to make sure that this code is run after the completion of the background (async) process in this case fetching weather data.
            // self keyword is needed since we run the code inside a closure.
            
            self.conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
            // same note to the condition icon in this case uses the conditionName from the weatherModel
            // NOTE: we use UIImage(systemName:) because we use in hous SFIcon to represent the condition, thus calling the icon requires the system name NOT just a NAME.
            
            // update the city name:
            self.cityLabel.text = weatherModel.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
