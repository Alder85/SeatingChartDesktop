//
//  SwiftFunctions1.swift
//  DriveSample
//
//  Created by WENDOLEK, CONNOR on 2/3/16.
//
//

import Foundation

@objc class SwiftFunctions1: NSObject {
    func determineFileType(description: String) -> String {
        var type = description.indexOf("ea")
        print(type)
        var loc: String
        loc = String(type)
        //loc = String(type).substringWithRange(8...9)
        return ""
    }
    
    func basic() -> String {
        return "Did something"
    }
    
    
}


extension String {
    func indexOf(string: String) -> String.Index? {
        return rangeOfString(string, options: .LiteralSearch, range: nil, locale: nil)?.startIndex
    }
}