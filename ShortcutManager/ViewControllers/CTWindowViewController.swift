//
//  CTWindowViewController.swift
//  ShortcutManager
//
//  Created by moon on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa

class CTWindowViewController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        m_arr_btn = [m_btnPlus, m_btnList]
        self.m_vcAppPlus = self.storyboard?.instantiateController(withIdentifier: "Main_AppPlusVC") as? NSViewController
        self.m_vcAppList = self.storyboard?.instantiateController(withIdentifier: "Main_AppListVC") as? NSViewController
        
        self.onClickMenuButton(self.m_btnList)
    }

    @IBOutlet weak var m_btnPlus: CTCircleButton!
    @IBOutlet weak var m_btnList: CTCircleButton!
    private var m_arr_btn:[CTCircleButton]!
    private var m_vcAppPlus:NSViewController?
    private var m_vcAppList:NSViewController?
    
    @IBAction func onClickMenuButton(_ sender: CTCircleButton) {
        for btn in m_arr_btn {
            btn.state = sender == btn ? .on : .off
        }
        
        self.contentViewController = sender.tag == 0 ? self.m_vcAppPlus : self.m_vcAppList
    }
}
