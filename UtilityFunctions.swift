//
//  UtilityFunctions.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/3/16.
//
//

import Foundation
import Cocoa
import AppKit

func dataToStudentArray(dataArray: [[String]]) -> [Student]
{
    var outArray: [Student] = []
    for x in 1...dataArray.count - 1
    {
        let temp = Student(inArray: dataArray[x])
        outArray.append(temp)
    }
    return outArray
}
extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let layer = layer, backgroundColor = layer.backgroundColor else { return nil }
            return NSColor(CGColor: backgroundColor)
        }
        
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.CGColor
        }
    }
    var center: CGPoint {
        return CGPointMake(NSMidX(self.frame), NSMidY(self.frame))
    }
    
    var centerInFrame: CGPoint {
        return CGPointMake(self.frame.width / 2, self.frame.height / 2)
    }
}

/*
 *  MAXIMUM EFFICIENCY
 */
extension String
{
    func substring(start: Int, end: Int) -> String
    {
        return self.substringWithRange(Range<String.Index>(start: self.startIndex.advancedBy(start), end: self.startIndex.advancedBy(end + 1)))
    }
    func indexOf(string: String) -> String.Index? {
        return rangeOfString(string, options: .LiteralSearch, range: nil, locale: nil)?.startIndex
    }
}

/*
 *  Able to be called from ObjC
 */
@objc class SwiftFunctions1: NSObject {
    func determineFileType(description: String) -> String {
        var type = description.indexOf("google-apps")
        //print(type)
        var loc: String
        loc = String(type)
        if String(type).isEmpty || type == nil {
            //print("IsEmpty")
            loc = "empty"
        }
        else
        {
            loc = String(type).substring(9,end: 10)
        }
        //print(loc)
        if loc.isEmpty || loc == "empty"
        {
            //print("empty")
        }
        else
        {
            print(description.substring(Int(loc)! + 12, end: Int(loc)! + 15))
            loc = description.substring(Int(loc)! + 12, end: Int(loc)! + 15)
        }
        return loc
    }
    
    func basic() -> String {
        return "Did something"
    }
    
    
}


let defaults = NSUserDefaults.standardUserDefaults()
func storeStudentArrayArray(name: String, valArray: [[Student]])
{
    defaults.setValue(valArray, forKey: name)
}

func retrieveStudentArrayArray(name: String) -> [[Student]]
{
    if let temp = defaults.valueForKey(name) as? [[Student]]
    {return temp}
    return [[]] 
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

