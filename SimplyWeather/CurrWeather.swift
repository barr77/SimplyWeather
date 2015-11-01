//
//  CurrWeather.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 02/11/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//

import Foundation

class currWeather {
    
    private var _location: String!
    private var _forecast: String!
    private var _minTemp: String!
    private var _maxTemp: String!
    private var _wind: String!
    private var _humidity: String!
    private var _weatherIcon: String!
    private var _sunrise: String!
    private var _sunset: String!
    
    
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

    
    
}
