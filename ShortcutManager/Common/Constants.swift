//
//  Constants.swift
//  ShortcutManager
//
//  Created by moon on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa

struct BundleInfo {
    static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    static let build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    static let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as! String
}

enum UserDefaults_DEFINE_KEY:String, CaseIterable {
    case initKey = "init"
}


extension UserDefaults {
    func DEFINE_Clear() {
        _ = UserDefaults_DEFINE_KEY.allCases.map {
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}

struct AnalyticsCategory {
    static let root = "ShortcutManager"
    static let about = "About"
}

struct AnalyticsAction {
    static let itself = "Itself"
    
    // root
    static let launch = "Launch"
    static let shortcut = "Shortcut"
    static let autoLogin = "AutoLogin"
    
    // about
    static let mail = "Mail"
    static let github = "Github"
    static let page = "Page"
}

struct AnalyticsLabel {
    
    // root
    static let new = "New"
    static let existing = "Existing"
    static let execute = "Execute"
}
