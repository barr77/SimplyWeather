//
//  ViewController.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 02/11/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//
// Credits:
//Icons:
// - sun by Sergey Demushkin from the Noun Project
// - sunny by Sergey Demushkin from the Noun Project
// - Moon by Sergey Demushkin from the Noun Project
// - Partly Cloudy by Sergey Demushkin from the Noun Project
// - clouds by Sergey Demushkin from the Noun Project
// - Cloud by Sergey Demushkin from the Noun Project
// - mostly cloudy by Sergey Demushkin from the Noun Project
// - storm cloud by Sergey Demushkin from the Noun Project
// - rain cloud by Sergey Demushkin from the Noun Project
// - rain cloud by Sergey Demushkin from the Noun Project
// - Sun Shower by Sergey Demushkin from the Noun Project
// - Snow by Sergey Demushkin from the Noun Project
// - fog by Sergey Demushkin from the Noun Project
// - Thermometer by Sergey Demushkin from the Noun Project
// - Barometer by Sergey Demushkin from the Noun Project
// - Steam by Sergey Demushkin from the Noun Project



import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIScrollViewDelegate {

    
    @IBOutlet weak var forecastImg: UIImageView!
    @IBOutlet weak var forecastLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var sunriseLbl: UILabel!
    @IBOutlet weak var sunsetLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var switchUnits: UISwitch!
    @IBOutlet weak var labelUnits: UILabel!

    
    @IBOutlet weak var thermometerImg: UIImageView!
    @IBOutlet weak var sunriseImg: UIImageView!
    @IBOutlet weak var humidityImg: UIImageView!
    @IBOutlet weak var barometerImg: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aboutBtn: UIButton!
    
    
    
    //1) Get location first to be submitted for forecast
    var locationManager:CLLocationManager!
    var initRefreshed:Bool?
    var currWeather: CurrWeather!
    var dailyWeather: DailyWeather!
    var tempUnit: String!
    var selUnit: String!
    
    let gradientLayer = CAGradientLayer()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        selUnit = UNIT_METRIC
        
        scrollView.delegate = self
        
        tintImages(forecastImg)
        tintImages(thermometerImg)
        tintImages(sunriseImg)
        tintImages(humidityImg)
        tintImages(barometerImg)

        getDefaultUnit()

        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        aboutBtn.layer.borderWidth = 1.0
        aboutBtn.layer.borderColor = borderColor.CGColor
        aboutBtn.layer.cornerRadius = 15.0

        
        
        
//        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        //=> Check if got internet. If no internet load last info (if available)
        if Reachability.isConnectedToNetwork() == false {
            errNoInternet()
        } else {
            //Get user location
            getLocation()
        }
        
        
        refreshInfo()
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }

    
    func tintImages(img: UIImageView!) {
        
        img.image = img.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        img.tintColor = UIColor.whiteColor()
        
    }
    
    
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        initRefreshed = false
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        var currentLocation:String?
        var userLatitude:Double?
        var userLongitude:Double?
        
        let userLocation:CLLocation = locations[0]
        userLatitude = userLocation.coordinate.latitude
        userLongitude = userLocation.coordinate.longitude
        
        //Store into weather object & then retrieve weather forecast
        if initRefreshed == false {
            if (userLatitude != nil) {
                if (userLongitude != nil) {

                    //Initiate currWeather object
                    currWeather = CurrWeather(longitude: userLongitude!, latitude: userLatitude!, units: selUnit)
                    getWeatherInfo()
                    
                    //Then initiate daily weather object
                    dailyWeather = DailyWeather(longitude: userLongitude!, latitude: userLatitude!, units: selUnit)
                    getDailyInfo()
                    
                }
            }
            initRefreshed = true
        }
        
    }
    
    
    func getWeatherInfo() {
        if let gotWeather = currWeather {
            
            toggleRefreshAnimation(true)
            
            gotWeather.getWeatherDetails { () -> () in
                
                var temperatureUnit: String!
                var windUnit: String!
                
                if self.selUnit == UNIT_METRIC {
                    temperatureUnit = UNIT_C
                    windUnit = UNIT_WIND_METRIC
                } else {
                    temperatureUnit = UNIT_F
                    windUnit = UNIT_WIND_IMPERIAL
                }

                self.forecastImg.image = UIImage(named: "\(self.currWeather.weatherIcon)")
                self.forecastImg.image = self.forecastImg.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                self.forecastImg.tintColor = UIColor.whiteColor()
                

                self.forecastLbl.text = self.currWeather.forecast
                self.locationLbl.text = self.currWeather.location
                self.temperatureLbl.text = self.currWeather.temperature + temperatureUnit
                self.pressureLbl.text = self.currWeather.pressure + "hPa"
                self.sunriseLbl.text = "↑ " + self.currWeather.sunrise
                self.sunsetLbl.text = "↓ " + self.currWeather.sunset
                self.maxTempLbl.text = "Max: " + self.currWeather.maxTemp + temperatureUnit
                self.minTempLbl.text = "Min:  " + self.currWeather.minTemp + temperatureUnit
                self.humidityLbl.text = self.currWeather.humidity + "%"
                self.windLbl.text = "Wind: " + self.currWeather.wind + windUnit

                let formatter = NSDateFormatter();
                formatter.dateFormat = "EEEE, MMMM dd";
                self.dateLbl.text = "\(formatter.stringFromDate(NSDate()))"
                
                self.toggleRefreshAnimation(false)
                
            }
        }
        
    }
    
    
    func getDailyInfo() {
        if let gotDailyWeather = dailyWeather {
            
            toggleRefreshAnimation(true)
            
            gotDailyWeather.getDailyDetails { () -> () in
                
//                var temperatureUnit: String!
//                var windUnit: String!
//                
//                if self.selUnit == UNIT_METRIC {
//                    temperatureUnit = UNIT_C
//                    windUnit = UNIT_WIND_METRIC
//                } else {
//                    temperatureUnit = UNIT_F
//                    windUnit = UNIT_WIND_IMPERIAL
//                }
                
//                print("\(self.dailyWeather.weatherDetails[0].humidity)")
                
//                self.forecastImg.image = UIImage(named: "\(self.currWeather.weatherIcon)")
//                self.forecastImg.image = self.forecastImg.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
//                self.forecastImg.tintColor = UIColor.whiteColor()
//                
//                
//                self.forecastLbl.text = self.currWeather.forecast
//                self.locationLbl.text = self.currWeather.location
//                self.temperatureLbl.text = self.currWeather.temperature + temperatureUnit
//                self.pressureLbl.text = self.currWeather.pressure + "hPa"
//                self.sunriseLbl.text = "↑ " + self.currWeather.sunrise
//                self.sunsetLbl.text = "↓ " + self.currWeather.sunset
//                self.maxTempLbl.text = "Max: " + self.currWeather.maxTemp + temperatureUnit
//                self.minTempLbl.text = "Min:  " + self.currWeather.minTemp + temperatureUnit
//                self.humidityLbl.text = self.currWeather.humidity + "%"
//                self.windLbl.text = "Wind: " + self.currWeather.wind + windUnit
//                
//                let formatter = NSDateFormatter();
//                formatter.dateFormat = "EEEE, MMMM dd";
//                self.dateLbl.text = "\(formatter.stringFromDate(NSDate()))"
                
                self.toggleRefreshAnimation(false)
                
            }
        }
        
    }


    @IBAction func switchUnits(sender: AnyObject) {

        if switchUnits.on == true {
            labelUnits.text = "\(UNIT_METRIC.capitalizedString)"
            selUnit = UNIT_METRIC
        } else {
            labelUnits.text = "\(UNIT_IMPERIAL.capitalizedString)"
            selUnit = UNIT_IMPERIAL
        }
        
        defaults.setObject(selUnit, forKey: "measureUnits")
        refreshInfo()
    
    }
    
    
    @IBAction func refreshBtn(sender: AnyObject) {
        
        refreshInfo()
    }

    
    func refreshInfo() {
        //=> Check if got internet. If no internet load last info (if available)
        if Reachability.isConnectedToNetwork() == false {
            errNoInternet()
        } else {
            //Get user location
            getLocation()
        }
    }
    
    func toggleRefreshAnimation(on: Bool) {

        
        if on {
            activityIndicator?.hidden = false
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
            activityIndicator?.hidden = true
        }
    }

    func errNoInternet() {
        let alertError = UIAlertController(title: "No Internet", message: "Please check your Internet connection.", preferredStyle: .Alert)
        
        let oKAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil )
        alertError.addAction(oKAction)
        
        presentViewController(alertError, animated: true, completion: nil)
        
    }


    func getDefaultUnit(){
        
        var units:String? = defaults.stringForKey("measureUnits")
        if (units == nil) {
            
            units = UNIT_METRIC
            defaults.setObject(UNIT_METRIC, forKey: "measureUnits")
            switchUnits.on = true
            
        } else {

            if units == UNIT_IMPERIAL {
                switchUnits.on = false
                labelUnits.text = UNIT_IMPERIAL.capitalizedString
            } else if units == UNIT_METRIC {
                switchUnits.on = true
                labelUnits.text = UNIT_METRIC.capitalizedString
            }

        }

        selUnit = units
        
    }
    
    @IBAction func aboutBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("ShowAboutVC", sender: sender)

        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
    }
    
    
    
}

