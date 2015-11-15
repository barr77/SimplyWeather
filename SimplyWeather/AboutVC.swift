//
//  AboutVC.swift
//  SimplyWeather
//
//  Created by Mohammad Akbar Bin Abdul Latip on 08/11/2015.
//  Copyright © 2015 Mohd Akbar. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var creditText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        creditText.layer.borderWidth = 1.0
        creditText.layer.borderColor = borderColor.CGColor
        creditText.layer.cornerRadius = 15.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
