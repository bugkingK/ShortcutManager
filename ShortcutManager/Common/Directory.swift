//
//  Directory.swift
//  ShortcutManager
//
//  Created by bugking on 20/06/2019.
//  Copyright © 2019 bugking. All rights reserved.
//

import Cocoa

public struct Metadata: CustomDebugStringConvertible, Equatable {
    
    let name: String
    let icon: NSImage
    let url: URL
    
    init(fileURL: URL, name: String, icon: NSImage) {
        self.name = name
        self.icon = icon
        self.url = fileURL
    }
    
    public var debugDescription: String {
        return name
    }
}

// MARK:  Metadata  Equatable

public func ==(lhs: Metadata, rhs: Metadata) -> Bool {
    return (lhs.url == rhs.url)
}


public struct Directory  {
    
    fileprivate var files: [Metadata] = []
    let url: URL
    
    public enum FileOrder: String {
        case Name
    }
    
    public init(folderURL: URL) {
        url = folderURL
        let requiredAttributes = [URLResourceKey.localizedNameKey, URLResourceKey.effectiveIconKey,
                                  URLResourceKey.typeIdentifierKey, URLResourceKey.contentModificationDateKey,
                                  URLResourceKey.fileSizeKey, URLResourceKey.isDirectoryKey,
                                  URLResourceKey.isPackageKey]
        if let enumerator = FileManager.default.enumerator(at: folderURL,
                                                           includingPropertiesForKeys: requiredAttributes,
                                                           options: [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants],
                                                           errorHandler: nil) {
            
            while let url = enumerator.nextObject() as? URL {
                do {
                    let properties = try  (url as NSURL).resourceValues(forKeys: requiredAttributes)
                    files.append(Metadata(fileURL: url,
                                          name: properties[URLResourceKey.localizedNameKey] as? String ?? "",
                                          icon: properties[URLResourceKey.effectiveIconKey] as? NSImage  ?? NSImage()
                    ))
                }
                catch {
                    print("Error reading file attributes")
                }
            }
        }
    }
    
    
    func contentsOrderedBy(_ orderedBy: FileOrder, ascending: Bool) -> [Metadata] {
        let sortedFiles: [Metadata]
        switch orderedBy {
        case .Name:
            sortedFiles = files.sorted {
                return sortMetadata(lhsIsFolder:true, rhsIsFolder: true, ascending: ascending,
                                    attributeComparation:itemComparator(lhs:$0.name, rhs: $1.name, ascending:ascending))
            }
        }
        return sortedFiles
    }
    
}

// MARK: - Sorting

func sortMetadata(lhsIsFolder: Bool, rhsIsFolder: Bool,  ascending: Bool,
                  attributeComparation: Bool) -> Bool {
    if(lhsIsFolder && !rhsIsFolder) {
        return ascending ? true : false
    }
    else if (!lhsIsFolder && rhsIsFolder) {
        return ascending ? false : true
    }
    return attributeComparation
}

func itemComparator<T:Comparable>(lhs: T, rhs: T, ascending: Bool) -> Bool {
    return ascending ? (lhs < rhs) : (lhs > rhs)
}


public func ==(lhs: Date, rhs: Date) -> Bool {
    if lhs.compare(rhs) == .orderedSame {
        return true
    }
    return false
}

public func <(lhs: Date, rhs: Date) -> Bool {
    if lhs.compare(rhs) == .orderedAscending {
        return true
    }
    return false
}
