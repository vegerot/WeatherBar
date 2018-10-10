//
//  WeatherView.swift
//  WeatherBar
//
//  Created by Max Coplan on 10/10/18.
//  Copyright © 2018 Max Coplan. All rights reserved.
//

import Cocoa

class WeatherView: NSView {

    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var cityTextField: NSTextField!
    @IBOutlet weak var currentConditionsTextField: NSTextField!
    
    func update(_ weather: Weather) {
        // do UI updates on the main thread
        DispatchQueue.main.async {
            self.cityTextField.stringValue=weather.city
            self.currentConditionsTextField.stringValue="\(Int(weather.currentTemp))°F and \(weather.conditions)"
            self.imageView.image = NSImage(named: weather.icon)
            
        }
    }
}
