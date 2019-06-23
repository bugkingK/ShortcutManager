//
//  AppDelegate.swift
//  ShortcutManager
//
//  Created by bugking on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa
import GoogleAnalyticsTracker

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        MPGoogleAnalyticsTracker.activate(.init(analyticsIdentifier: "UA-141906441-3"))
        PopoverController.sharedInstance()
        self.initUserDefaultKey()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        UserDefaults.standard.synchronize()
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        sender.windows.first?.setIsVisible(true)
        return true
    }
    
    private func initUserDefaultKey() {
        let defaults = UserDefaults.standard
        let initKey = defaults.bool(forKey: UserDefaults_DEFINE_KEY.initKey.rawValue)
        
        if initKey {
            MPGoogleAnalyticsTracker.trackEvent(ofCategory: AnalyticsCategory.root, action: AnalyticsAction.launch, label: AnalyticsLabel.existing, value: 0)
            return
        }
        
        defaults.set(true, forKey: UserDefaults_DEFINE_KEY.initKey.rawValue)
        PopoverController.sharedInstance().onWelcome()
        MPGoogleAnalyticsTracker.trackEvent(ofCategory: AnalyticsCategory.root, action: AnalyticsAction.launch, label: AnalyticsLabel.new, value: 0)
    }


}

