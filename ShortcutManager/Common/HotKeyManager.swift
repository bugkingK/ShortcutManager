//
//  HotKeyManager.swift
//  ShortcutManager
//
//  Created by bugking on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa
import MASShortcut

class HotKeyManager: NSObject {
    static let shared = HotKeyManager()
    
    public func registerHotKey(shortcutView:MASShortcutView, path:URL, appName:String) {
        let associatedKey:String = appName.replacingOccurrences(of: " ", with: "-")
        shortcutView.associatedUserDefaultsKey = associatedKey
        MASShortcutBinder.shared()?.bindShortcut(withDefaultsKey: associatedKey, toAction: {
            NSWorkspace.shared.open(path)
        })
    }
    
}
