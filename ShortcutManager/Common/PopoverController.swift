//
//  PopoverController.swift
//  ShortcutManager
//
//  Created by moon on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa

private let _sharedInstance = PopoverController()

class PopoverController: NSObject {
    @discardableResult
    open class func sharedInstance() -> PopoverController {
        return _sharedInstance
    }
    
    fileprivate let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    public override init() {
        super.init()
        if AutoLogin.enabled {
            NSApplication.shared.windows.first?.setIsVisible(false)
        }
        
        if let button = self.statusItem.button {
            let icon = NSImage(named: .init("StatusBarButtonImage"))
            button.image = icon
            button.focusRingType = .none
            button.setButtonType(.pushOnPushOff)
        }
        
        let menu = NSMenu()
        let arr_items = [
            NSMenuItem(title: "Welcome", action: #selector(onWelcome), keyEquivalent: ""),
            NSMenuItem(title: "About", action: #selector(onAbout), keyEquivalent: ""),
            NSMenuItem.separator(),
            NSMenuItem(title: "Open ShortcutManager", action: #selector(openApp), keyEquivalent: ""),
            NSMenuItem(title: "Auto-Login", action: #selector(onAutoLogin(_:)), keyEquivalent: ""),
            NSMenuItem.separator(),
            NSMenuItem(title: "Quit", action: #selector(onQuit), keyEquivalent: ""),
        ]
        
        arr_items[4].state = AutoLogin.enabled ? .on : .off
        
        for item in arr_items {
            item.target = self
            menu.addItem(item)
        }
        
        self.statusItem.menu = menu
    }
    
    @objc private func onAbout() {
        guard let vc = NSStoryboard.init(name: "Settings", bundle: nil).instantiateController(withIdentifier: "Settings_About") as? Settings_About else {
            return
        }
        
        let windowVC = NSWindowController(window: NSWindow(contentViewController: vc))
        windowVC.showWindow(self)
    }
    
    @objc public func onWelcome() {
        guard let vc = NSStoryboard.init(name: "Settings", bundle: nil).instantiateController(withIdentifier: "Settings_Welcome") as? Settings_Welcome else {
            return
        }
        
        let windowVC = NSWindowController(window: NSWindow(contentViewController: vc))
        windowVC.showWindow(self)
    }
    
    @objc private func onAutoLogin(_ sender:NSMenuItem) {
        AutoLogin.enabled = !AutoLogin.enabled
        sender.state = AutoLogin.enabled ? .on : .off
    }
    
    @objc private func onQuit() {
        NSApp.terminate(nil)
    }
    
    @objc private func openApp() {
        NSApplication.shared.windows.first?.setIsVisible(true)
    }
}
