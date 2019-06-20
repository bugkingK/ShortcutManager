//
//  Settings_Welcome.swift
//  LogiAppManager-v2
//
//  Created by moon on 09/06/2019.
//  Copyright © 2019 banaple. All rights reserved.
//

import Cocoa

class Settings_Welcome: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        m_appName.stringValue = BundleInfo.bundleName
        m_btnAutoLogin.target = self
        m_btnAutoLogin.action = #selector(onAutoLogin(_:))
        m_btnAutoLogin.state = AutoLogin.enabled ? .on : .off
    }
    
    @IBOutlet weak var m_appName: NSTextField!
    @IBOutlet weak var m_btnAutoLogin: NSButton!
    
    @objc private func onAutoLogin(_ sender:NSButton) {
        AutoLogin.enabled = !AutoLogin.enabled
        sender.state = AutoLogin.enabled ? .on : .off
    }
    
}
