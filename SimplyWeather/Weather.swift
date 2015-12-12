//
//  weather.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 12/12/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//

import Foundation


class Weather {
    
    private var _location: String! //Curr n Daily
    private var _forecast: String! //Curr n Daily
    private var _minTemp: String! //Curr n Daily
    private var _maxTemp: String! //Curr n Daily
    private var _wind: String! //Curr n Daily
    private var _humidity: String! //Curr n Daily
    private var _weatherIcon: String! //Curr n Daily
    private var _latitude: Double! //Curr n Daily
    private var _longitude: Double! //Curr n Daily
    private var _pressure: String! //Curr n Daily
    private var _temperature: String! //Curr n Daily
    private var _units: String! //Curr n Daily

    //    private var _sunrise: String
    //    private var _sunset: String!
    //    private var _weatherApiUrl: String!
    //    private var _weatherDailyApiUrl: String!
    
    
    
    //GETTERS
    var location: String {
        get {
            if _location == nil {
                _location = ""
            }
            return _location
        }
        set(locationVal) {
            _location = locationVal
        }
    }
    
    var forecast: String {
        get {
            if _forecast == nil {
                _forecast = ""
            }
            return _forecast
        }
        set(forecastVal) {
            _forecast = forecastVal
        }
        
        
    }
    
    var minTemp: String {
        get {
            if _minTemp == nil {
                _minTemp = ""
            }
            return _minTemp
        }
        set(minTempVal) {
            _minTemp = minTempVal
        }

    
    }
    
    var maxTemp: String {
        get {
            if _maxTemp == nil {
                _maxTemp = ""
            }
            return _maxTemp
        }
        set(maxTempVal) {
            _maxTemp = maxTempVal
        }

    }
    
    var wind: String {
        get {
            if _wind == nil {
                _wind = ""
            }
            return _wind
        }
        set(windVal) {
            _wind = windVal
        }

    }
    
    var humidity: String {
        get {
            if _humidity == nil {
                _humidity = ""
            }
            return _humidity
        }
        set(humidityVal) {
            _humidity = humidityVal
        }

    }
    
    var weatherIcon: String {
        get {
            if _weatherIcon == nil {
                _weatherIcon = ""
            }
            return _weatherIcon
        }
        set(weatherIconVal) {
            _weatherIcon = weatherIconVal
        }

    }
    
//    var sunrise: String {
//        if _sunrise == nil {
//            _sunrise = ""
//        }
//        return _sunrise
//    }
//    
//    var sunset: String {
//        if _sunset == nil {
//            _sunset = ""
//        }
//        return _sunset
//    }
    
    
    var temperature: String {
        get {
            if _temperature == nil {
                _temperature = ""
            }
            return _temperature
        }
        set(temperatureVal) {
            _temperature = temperatureVal
        }

    }
    
    var pressure: String {
        get {
            if _pressure == nil {
                _pressure = ""
            }
            return _pressure
        }
        set(pressureVal) {
            _pressure = pressureVal
        }
        
    }
    
//    var weatherApiUrl: String {
//        if _weatherApiUrl == nil {
//            _weatherApiUrl = ""
//        }
//        return _weatherApiUrl
//    }
//    
//    var weatherDailyApiUrl: String {
//        if _weatherApiUrl == nil {
//            _weatherApiUrl = ""
//        }
//        return _weatherApiUrl
//    }
    
    
    
    
    
    
    //Initiate weather object by acquiring location & measurement units
    init(longitude: Double, latitude: Double, units: String) {
        self._longitude = longitude
        self._latitude = latitude
        self._units = units
        
    }

    
    
}