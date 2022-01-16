//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.search textfield
//        delegate keybard interaction to
        searchTextField.delegate = self
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
        print(searchTextField.text!)
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
}

