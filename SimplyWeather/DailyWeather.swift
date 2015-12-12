//
//  DailyWeather.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 06/12/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//

import Foundation

import Alamofire


class DailyWeather {

    private var _weatherDailyApiUrl: String!
    var weatherDetails = [Weather]()
    private var _latitude: Double! //Curr n Daily
    private var _longitude: Double! //Curr n Daily
    private var _units: String! //Curr n Daily
    

    
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
        
        _weatherDailyApiUrl = "\(URL_FORECASTBASE)lat=\(latitude)&lon=\(longitude)&cnt=8&mode=json&&APPID=\(APIKey)&units=\(units)"
        print(_weatherDailyApiUrl)
        
        //http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&mode=json&appid=2de143494c0b295cca9337e1e96b00e0
        
        
    }
 
    
    //Function to download weatherInfo
    func getDailyDetails(completed: DownloadComplete) {
        
        //      get current info
        let url = NSURL(string: _weatherDailyApiUrl)!
        Alamofire.request(.GET, url).responseJSON { (request: NSURLRequest?, response: NSHTTPURLResponse?, result: Result<AnyObject>) -> Void in
            
            //            print(result.value.debugDescription)
            
            switch result {
            case .Success (let JSON):
                
//                print("\(response)")
                
                
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    
//                    if let location = dict["name"] as? String {
//                        self.weatherDetails[0].location = location
//                    } else   {
//                        self.weatherDetails[0].location = ""
//                    }
                    
                    
                    
                    for var i = 0; i <= DAILY_COUNT - 1; i++ {
                    
                        var tempWeatherInfo: Weather!
                        tempWeatherInfo = Weather(longitude: self._longitude, latitude: self._latitude, units: self._units)
                        
                        
                        //"weather" node
                        if let weatherInfo = dict["list"] as? [Dictionary<String, AnyObject>] where weatherInfo.count > 0 {
                            

                            if let pressure = weatherInfo[i]["pressure"] as? Double {
                                tempWeatherInfo.pressure = "\(pressure)"
                            } else {
                                tempWeatherInfo.pressure = ""
                            }
                            
                            if let humidity = weatherInfo[i]["humidity"] as? Double {
                                tempWeatherInfo.humidity = "\(humidity)"
                            } else {
                                tempWeatherInfo.humidity = ""
                            }
                            
                            //"temp" node
                            if let tempNode = weatherInfo[i]["temp"] as? Dictionary<String, AnyObject> {
        
                                if let temperature = tempNode["day"] as? Double {
                                    tempWeatherInfo.temperature = "\(temperature)"
                                } else {
                                    tempWeatherInfo.temperature = ""
                                }
                                
                            }
                            
                            
                            //"weather" node
                            if let weatherNode = weatherInfo[i]["weather"] as? [Dictionary<String, AnyObject>] where weatherNode.count > 0 {
                                
                                if let forecast = weatherNode[0]["description"] {
                                    tempWeatherInfo.forecast = forecast.capitalizedString
                                } else {
                                    tempWeatherInfo.forecast = ""
                                }
                                
                                if let icon = weatherNode[0]["icon"] {
                                    tempWeatherInfo.weatherIcon = "\(icon)"
                                } else {
                                    tempWeatherInfo.weatherIcon = ""
                                }

                            
                            
                            }
                            
                        }

                    self.weatherDetails.append(tempWeatherInfo)
                    print("\(i)) \(self.weatherDetails[i].pressure)")
                    }
                }

                completed()
                
            case .Failure(let error):
                
                print("\(error)")
            }
            
            
        }
    
    }
    
    
    

}