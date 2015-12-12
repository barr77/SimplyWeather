//
//  CurrWeather.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 02/11/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//

import Foundation
import Alamofire


class CurrWeather: Weather {
    
    private var _sunrise: String!
    private var _sunset: String!
    private var _weatherApiUrl: String!
    
    //GETTERS
    
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
    
    
    var weatherApiUrl: String {
        if _weatherApiUrl == nil {
            _weatherApiUrl = ""
        }
        return _weatherApiUrl
    }
    
    
    
    //Initiate weather object by acquiring location & measurement units
    override init(longitude: Double, latitude: Double, units: String) {


        super.init(longitude: longitude, latitude: latitude, units: units)
        
        
        _weatherApiUrl = "\(URL_BASE)lat=\(latitude)&lon=\(longitude)&APPID=\(APIKey)&units=\(units)"
//                print(_weatherApiUrl)
        
//        _weatherDailyApiUrl = "\(URL_FORECASTBASE)lat=\(_latitude)&lon=\(_longitude)&cnt=8&mode=json&&APPID=\(APIKey)&units=\(_units)"
//        print(_weatherDailyApiUrl)
        
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
                        self.location = location
                    } else   {
                        self.location = ""
                    }
                    
                    
                    
                    //"weather" node
                    if let weatherInfo = dict["weather"] as? [Dictionary<String, AnyObject>] where weatherInfo.count > 0 {
                        
                        if let main = weatherInfo[0]["description"] {
                            self.forecast = main.capitalizedString
                        } else {
                            self.forecast = ""
                        }
                        
                        if let icon = weatherInfo[0]["icon"] {
                            self.weatherIcon = "\(icon)"
                        } else {
                            self.weatherIcon = ""
                        }
                        
                    }
                    
                    //"wind" node
                    if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                        
                        if let speed = wind["speed"] as? Double {
                            self.wind = "\(speed)"
                        } else {
                            self.wind = ""
                        }
                        
                    }
                    
                    //"main" node
                    if let main = dict["main"] as? Dictionary<String, AnyObject> {
                        
                        if let humidity = main["humidity"] as? Double {
                            self.humidity = "\(humidity)"
                        } else {
                            self.humidity = ""
                        }
                        
                        if let temp = main["temp"] as? Int {
                            self.temperature = "\(temp)"
                        } else {
                            self.temperature = ""
                        }
                        
                        
                        if let pressure = main["pressure"] as? Double {
                            self.pressure = "\(pressure)"
                        } else {
                            self.pressure = ""
                        }
                        
                        if let minTemp = main["temp_min"] as? Int {
                            self.minTemp = "\(minTemp)"
                        } else {
                            self.minTemp = ""
                        }
                        
                        if let maxTemp = main["temp_max"] as? Int {
                            self.maxTemp = "\(maxTemp)"
                        } else {
                            self.maxTemp = ""
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
                        
            
        }
        
        
    }
    
    
    
    
    
    
    
    
}
