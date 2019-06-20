//
//  Main_AppPlusVC.swift
//  ShortcutManager
//
//  Created by moon on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa

class Main_AppPlusVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        m_ddApp.acceptedFileExtensions = ["app", ""]
        m_ddApp.delegate = self
        
    }
    @IBOutlet weak var m_ddApp: ADragDropView!
    
}

extension Main_AppPlusVC: ADragDropViewDelegate {
    func dragDropView(_ dragDropView: ADragDropView, droppedFileWithURL URL: URL) {
        print(URL)
    }
    
    func dragDropView(_ dragDropView: ADragDropView, droppedFilesWithURLs URLs: [URL]) {
        
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = "Please drop only one file"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
