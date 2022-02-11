//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
//    instantiate the WeatherManager struct to instance weatherManager
    var weatherManger = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.search textfield
//        delegate keybard interaction to
        searchTextField.delegate = self
        
        // remember to add this delegate function in viewDidLoad so that the delegate will not seen as empty when calling or implementing the didUpdateWeather later on
        weatherManger.delegate = self
    }

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
//         I don't need this test anymore just delete it:
//        print(searchTextField.text!)
        
//        TODO let city = searchTextField text
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
//        if text == "" then end editing
//        else text = "type something"
        if (textField.text != "") {
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
    
    // we prepare didUpdateWeather function to receive the weathermodel data
    func didUpdateWeather(_ weatherManager: WeatherManager, weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherModel.temperatureString
            // DispatchQueue.main.async is the closure to make sure that this code is run after the completion of the background (async) process in this case fetching weather data.
            // self keyword is needed since we run the code inside a closure.
            
            self.conditionImageView.image = UIImage(systemName: weatherModel.conditionName)
            // same note to the condition icon in this case uses the conditionName from the weatherModel
            // NOTE: we use UIImage(systemName:) because we use in hous SFIcon to represent the condition, thus calling the icon requires the system name NOT just a NAME.
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

