//
//  StatusMenuController.swift
//  WeatherBar
//
//  Created by Max Coplan on 10/9/18.
//  Copyright © 2018 Max Coplan. All rights reserved.
//

import Cocoa
let DEFAULT_CITY="Baltimore"

class StatusMenuController: NSObject, PreferencesWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferenceWindow.showWindow(nil)
    }
    
    @IBOutlet weak var weatherView: WeatherView!
    
    var weatherMenuItem: NSMenuItem!
    var preferenceWindow: PreferencesWindow!
    
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let weatherAPI=WeatherAPI()
    
    override func awakeFromNib() {
        statusItem.menu = statusMenu
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true // best for dark mode
        statusItem.image = icon
        weatherMenuItem=statusMenu.item(withTitle: "Weather")
        weatherMenuItem.view=weatherView
        
        preferenceWindow=PreferencesWindow()
        preferenceWindow.delegate=self
        
        updateWeather()
    }
    
    func updateWeather() {
        let defaults = UserDefaults.standard
        let city = defaults.string(forKey: "city") ?? DEFAULT_CITY
        
        weatherAPI.fetchWeather(city) { weather in
           self.weatherView.update(weather)
        }
    }
    
    func preferencesDidUpdate() {
        updateWeather()
    }
    
    @IBAction func updateClicked(_ sender: NSMenuItem) {
        updateWeather()
    }
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
  
}
