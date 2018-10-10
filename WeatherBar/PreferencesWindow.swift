//
//  PreferencesWindow.swift
//  WeatherBar
//
//  Created by Max Coplan on 10/10/18.
//  Copyright © 2018 Max Coplan. All rights reserved.
//

import Cocoa

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}


class PreferencesWindow: NSWindowController, NSWindowDelegate {
    @IBOutlet weak var cityTextField: NSTextField!
    var delegate: PreferencesWindowDelegate?
    
    override var windowNibName : String! {
        return "PreferencesWindow"
    }
    
    func windowWillClose(_ notification: Notification) {
        let defaults = UserDefaults.standard
        defaults.setValue(cityTextField.stringValue, forKey: "city")
        
        delegate?.preferencesDidUpdate()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        let defaults = UserDefaults.standard
        let city = defaults.string(forKey: "city") ?? DEFAULT_CITY
        cityTextField.stringValue=city
    }
}
