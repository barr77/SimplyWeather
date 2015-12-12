//
//  CurrWeather.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 02/11/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//

import Foundation
import Alamofire


class CurrWeather_old {
    
    private var _location: String!
    private var _forecast: String!
    private var _minTemp: String!
    private var _maxTemp: String!
    private var _wind: String!
    private var _humidity: String!
    private var _weatherIcon: String!
    private var _sunrise: String!
    private var _sunset: String!
    private var _latitude: Double!
    private var _longitude: Double!
    private var _weatherApiUrl: String!
    private var _weatherDailyApiUrl: String!
    private var _pressure: String!
    private var _temperature: String!
    private var _units: String!

    //GETTERS
    var location: String {
        if _location == nil {
            _location = ""
        }
        return _location
    }
    
    var forecast: String {
        if _forecast == nil {
            _forecast = ""
        }
        return _forecast
    }
    
    var minTemp: String {
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = ""
        }
        return _maxTemp
    }

    var wind: String {
        if _wind == nil {
            _wind = ""
        }
        return _wind
    }

    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }

    var weatherIcon: String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }

    var sunrise: String {
        if _sunrise == nil {
            _sunrise = ""
        }
        return _sunrise
    }

    var sunset: String {
        if _sunset == nil {
            _sunset = ""
        }
        return _sunset
    }


    var temperature: String {
        if _temperature == nil {
            _temperature = ""
        }
        return _temperature
    }
    
    var pressure: String {
        if _pressure == nil {
            _pressure = ""
        }
        return _pressure
    }
    
    var weatherApiUrl: String {
        if _weatherApiUrl == nil {
            _weatherApiUrl = ""
        }
        return _weatherApiUrl
    }

    var weatherDailyApiUrl: String {
        if _weatherDailyApiUrl == nil {
            _weatherDailyApiUrl = ""
        }
        return _weatherDailyApiUrl
    }
    
    
    //Initiate weather object by acquiring location & measurement units
    init(longitude: Double, latitude: Double, units: String) {
        self._longitude = longitude
        self._latitude = latitude
        self._units = units
        
        _weatherApiUrl = "\(URL_BASE)lat=\(_latitude)&lon=\(_longitude)&APPID=\(APIKey)&units=\(_units)"
//        print(_weatherApiUrl)
        
        _weatherDailyApiUrl = "\(URL_FORECASTBASE)lat=\(_latitude)&lon=\(_longitude)&cnt=8&mode=json&&APPID=\(APIKey)&units=\(_units)"
       print(_weatherDailyApiUrl)
        
//http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&mode=json&appid=2de143494c0b295cca9337e1e96b00e0        
        
        
    }
    
    
    //Function to download weatherInfo
    func getWeatherDetails(completed: DownloadComplete) {
        
//      get current info
        let url = NSURL(string: _weatherApiUrl)!
        Alamofire.request(.GET, url).responseJSON { (request: NSURLRequest?, response: NSHTTPURLResponse?, result: Result<AnyObject>) -> Void in

//            print(result.value.debugDescription)
            
            switch result {
            case .Success (let JSON):
            
                if let dict = result.value as? Dictionary<String, AnyObject> {

                    if let location = dict["name"] as? String {
                        self._location = location
                    } else   {
                        self._location = ""
                    }


                    
                    //"weather" node
                    if let weatherInfo = dict["weather"] as? [Dictionary<String, AnyObject>] where weatherInfo.count > 0 {
                        
                        if let main = weatherInfo[0]["description"] {
                            self._forecast = main.capitalizedString
                        } else {
                            self._forecast = ""
                        }

                        if let icon = weatherInfo[0]["icon"] {
                            self._weatherIcon = "\(icon)"
                        } else {
                            self._weatherIcon = ""
                        }
                        
                    }

                    //"wind" node
                    if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                        
                        if let speed = wind["speed"] as? Double {
                            self._wind = "\(speed)"
                        } else {
                            self._wind = ""
                        }
                        
                    }
                    
                    //"main" node
                    if let main = dict["main"] as? Dictionary<String, AnyObject> {
                        
                        if let humidity = main["humidity"] as? Double {
                            self._humidity = "\(humidity)"
                        } else {
                            self._humidity = ""
                        }

                        if let temp = main["temp"] as? Int {
                            self._temperature = "\(temp)"
                        } else {
                            self._temperature = ""
                        }

                        
                        if let pressure = main["pressure"] as? Double {
                            self._pressure = "\(pressure)"
                        } else {
                            self._pressure = ""
                        }

                        if let minTemp = main["temp_min"] as? Int {
                            self._minTemp = "\(minTemp)"
                        } else {
                            self._minTemp = ""
                        }

                        if let maxTemp = main["temp_max"] as? Int {
                            self._maxTemp = "\(maxTemp)"
                        } else {
                            self._maxTemp = ""
                        }
                        
                    }
                    
                    let formatter = NSDateFormatter();
                    formatter.dateFormat = "hh:mm a";
                    
                    //"sys" node
                    if let sys = dict["sys"] as? Dictionary<String, AnyObject> {
                        
                        if let sunrise = sys["sunrise"] as? NSTimeInterval {
                            self._sunrise = "\(formatter.stringFromDate(NSDate(timeIntervalSince1970: sunrise)))"
                            
                        } else {
                            self._sunrise = ""
                        }

                        if let sunset = sys["sunset"] as? NSTimeInterval {
                            self._sunset = "\(formatter.stringFromDate(NSDate(timeIntervalSince1970: sunset)))"
                            
                        } else {
                            self._sunset = ""
                        }
                    
                    
                    
                    }

                    
                    
                }
            
                
                completed()
                
            case .Failure(let error):
            
                print("\(error)")
            }
            
//            private var _location: String! X
//            private var _forecast: String! X
//            private var _minTemp: String! X
//            private var _maxTemp: String! X
//            private var _wind: String! X
//            private var _humidity: String! X
//            private var _weatherIcon: String!
//            private var _sunrise: String! X
//            private var _sunset: String! X
//            private var _latitude: Double! X
//            private var _longitude: Double! X
//            private var _weatherApiUrl: String! X
//            private var _units: String! X
            
            
        }
        
        
    }
    
    
    
    
    
    
    
    
}
