//
//  Constants.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 02/11/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//

import Foundation

let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?"
let URL_FORECASTBASE = "http://api.openweathermap.org/data/2.5/forecast/daily?"

//let URL_POKEMON = "/api/v1/pokemon/"
let APIKey = "2438a74296d39d3a043d61c9d05877a9"
let UNIT_METRIC = "metric"
let UNIT_IMPERIAL = "imperial"
let UNIT_C = "°C"
let UNIT_F = "°F"
let UNIT_WIND_METRIC = "m/s"
let UNIT_WIND_IMPERIAL = "mi/s"
let DAILY_COUNT = 8

typealias DownloadComplete = () -> ()

