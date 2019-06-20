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
        
        if let button = self.statusItem.button {
            let icon = NSImage(named: .init("StatusBarButtonImage"))
            button.image = icon
            button.focusRingType = .none
            button.setButtonType(.pushOnPushOff)
        }
        
        let menu = NSMenu()
        let arr_items = [
            NSMenuItem(title: "About", action: #selector(onAbout), keyEquivalent: ""),
            NSMenuItem.separator(),
            NSMenuItem(title: "Open ShortcutManager", action: #selector(openApp), keyEquivalent: ""),
            NSMenuItem.separator(),
            NSMenuItem(title: "Quit", action: #selector(onQuit), keyEquivalent: ""),
            NSMenuItem.separator()
        ]
        
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
    
    @objc private func onQuit() {
        NSApp.terminate(nil)
    }
    
    @objc private func openApp() {
        NSApplication.shared.windows.first?.setIsVisible(true)
    }
}
