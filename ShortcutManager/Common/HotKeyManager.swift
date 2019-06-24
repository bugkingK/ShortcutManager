//
//  HotKeyManager.swift
//  ShortcutManager
//
//  Created by bugking on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa
import MASShortcut
import GoogleAnalyticsTracker

class HotKeyManager: NSObject {
    static let shared = HotKeyManager()
    
    public func registerHotKey(shortcutView:MASShortcutView, path:URL, appName:String) {
        let associatedKey:String = appName.replacingOccurrences(of: " ", with: "")
        let arr_key = associatedKey.components(separatedBy: ".")
        shortcutView.associatedUserDefaultsKey = arr_key[0]
        MASShortcutBinder.shared()?.bindShortcut(withDefaultsKey: arr_key[0], toAction: {
            NSWorkspace.shared.open(path)
            MPGoogleAnalyticsTracker.trackEvent(ofCategory: AnalyticsCategory.root, action: AnalyticsAction.shortcut, label: AnalyticsLabel.execute, value: 0)
        })
        MPGoogleAnalyticsTracker.trackEvent(ofCategory: AnalyticsCategory.root, action: AnalyticsAction.shortcut, label: AnalyticsLabel.new, value: 0)
    }
    
}
