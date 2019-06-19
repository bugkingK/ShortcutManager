//
//  Main_AppListVC.swift
//  ShortcutManager
//
//  Created by bugking on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa
import MASShortcut

class Main_AppListVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupLayout()
    }
    
    private func setupLayout() {
        self.m_tvMain.delegate = self
        self.m_tvMain.dataSource = self
        
        let url_applications = URL(string: "/Applications")!
        directory = Directory(folderURL: url_applications)
        directoryItems = directory?.contentsOrderedBy(.Name, ascending: true)
        if let items = directoryItems {
            for idx in 0..<items.count {
                self.sorted_items.append(idx)
            }
        }
        self.m_tvMain.reloadData()
        self.m_sfMain.target = self
        self.m_sfMain.action = #selector(onSearching(_:))
        if let cell = self.m_sfMain.cell as? NSSearchFieldCell {
            cell.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var m_tvMain: NSTableView!
    @IBOutlet weak var m_sfMain: NSSearchField!
    fileprivate var directory: Directory?
    var directoryItems: [Metadata]?
    var sorted_items:[Int] = []
    
    @objc private func onSearching(_ sender:NSSearchField) {
        guard let items = directoryItems else {
            return
        }
        
        var arr_idx:[Int] = []
        let str_search = sender.stringValue.uppercased()
        if str_search == "" {
            if let items = directoryItems {
                for idx in 0..<items.count {
                    arr_idx.append(idx)
                }
            }
        } else {
            for (idx, item) in items.enumerated() {
                if item.name.uppercased().contains(str_search) {
                    arr_idx.append(idx)
                }
            }
        }
        
        sorted_items = arr_idx
        self.m_tvMain.reloadData()
    }
    
}

extension Main_AppListVC:NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return sorted_items.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ApplicationCell"), owner: nil) as? ApplicationCell else {
            return nil
        }
        
        guard let item = directoryItems?[sorted_items[row]] else {
            return nil
        }
        
        cell.lbAppName.stringValue = item.name
        cell.imgIcon.image = item.icon
        cell.lbPath.stringValue = item.url.path
        HotKeyManager.shared.registerHotKey(shortcutView: cell.vwShortcut, path: item.url, appName: item.name)
        
        return cell
    }
}

class ApplicationCell: NSTableCellView {
    @IBOutlet weak var imgIcon: NSImageView!
    @IBOutlet weak var lbAppName: NSTextField!
    @IBOutlet weak var lbPath: NSTextField!
    @IBOutlet weak var vwShortcut: MASShortcutView!
}
