
![App Brewery Banner](Documentation/AppBreweryBanner.png)

#  Clima

## Our Goal

It’s time to take our app development skills to the next level. We’re going to introduce you to the wonderful world of Application Programming Interfaces (APIs) to grab live data from the internet. If you’re dreaming of making that Twitter-powered stock trading app then you’re about add some serious tools to your toolbelt!


## What you will create

By the end of the module, you will have made a beautiful, dark-mode enabled weather app. You'll be able to check the weather for the current location based on the GPS data from the iPhone as well as by searching for a city manually. 

## What you will learn

* How to create a dark-mode enabled app.
* How to use vector images as image assets.
* Learn to use the UITextField to get user input. 
* Learn about the delegate pattern.
* Swift protocols and extensions. 
* Swift guard keyword. 
* Swift computed properties.
* Swift closures and completion handlers.
* Learn to use URLSession to network and make HTTP requests.
* Parse JSON with the native Encodable and Decodable protocols. 
* Learn to use Grand Central Dispatch to fetch the main thread.
* Learn to use Core Location to get the current location from the phone GPS. 

### Condition Codes
```
switch conditionID {
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
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
```

>This is a companion project to The App Brewery's Complete App Development Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)

![End Banner](Documentation/readme-end-banner.png)

## NOTES TextField:
1. The Test on whether keyboard is hidden or not after tapping the "GO" key uses different Assertion.
2. This is because the process to hide the keybaord requires some waiting time. Thusn in the assertion I uses : XCTAssertFalse(app.keyboards.buttons["a".waitForExistance] (timeout: 5) method.
3.This will allow me to safely test whether keyboard is really hidden or not.

## NOTES API:
1. The API uses the openweathermap.org API.
2. Tested the usage from the browser which has JSON pattern as response.
3. In this part we will model the API manager to fetch the JSON data and the process it.

