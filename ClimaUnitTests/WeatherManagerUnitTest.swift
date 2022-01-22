//
//  WeatherManagerUnitTest.swift
//  ClimaUnitTests
//  Unit Tesr for the WeatherManager struct (Clima/Model/WeatherManager.swift)
//
//  Created by Yanuar Heru on 22/01/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import XCTest
// import the testable project: Clima
@testable import Clima

class WeatherManagerUnitTest: XCTestCase {
//    instantiate the WaetherManager to be tested later:
    var manager = Clima.WeatherManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testUrlStringMustProvidesCorrectAddressParams() throws {
//        action
        manager.fetchWeather(cityName: "london")
//        assert
        XCTAssertEqual(manager.urlString, "https://api.openweathermap.org/data/2.5/weather?appid=f8715d89da920a6b7b9890773d5b8a58&q=london")
    }


}
