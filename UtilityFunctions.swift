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

/**
    Converts a 2D string array, assumedly loaded from a CSV, to an array of Students

    - Parameters:
        - dataArray: String array to convert
    - Returns: An array of Students
    ![Shaquille O'Neil](http://a.espncdn.com/combiner/i?img=/i/headshots/nba/players/full/614.png&w=350&h=254)
 */
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
    func redraw()
    {
        let dummy = false
        redraw(dummy)
    }
    
    func redraw(obj: AnyObject?) //redraws view, solves dragging issues
    {
        self.needsDisplay = true
    }
}

/*
 *  MAXIMUM EFFICIENCY
 */
extension String
{
    func substring(start: Int, end: Int) -> String
    {
        
        
        let endVal = self.startIndex.advancedBy(end + 1)
        let startVal = self.startIndex.advancedBy(start, limit: endVal)
        return self.substringWithRange(Range<String.Index>(start: startVal, end: endVal))

        //return self.substringWithRange(Range<String.Index>(start: self.startIndex.advancedBy(start), end: self.startIndex.advancedBy(end + 1)))
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

/**
    Delays for a time, in seconds
    - Parameters:
        - delay: Seconds to delay
    ![Wait a minute](https://cdn.meme.am/instances/49880791.jpg)
 */
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

/**
    Flips a Boolean value
    - Note: Do not attempt to simplify, this is the scientifically proven most effective method
    - Parameters:
        - bool: The Boolean to be flipped
    - Returns: The flipped Boolean
 
    ![Visible Confusion](https://i.warosu.org/data/ck/thumb/0058/69/1412871056921s.jpg)
 */
func flipBoolean(var bool: Bool) -> Bool
{
    let bool1 = bool;
    bool = false;
    var bool2 = bool;
    bool2 = bool1 == bool ? bool2 : bool1
    bool = !bool2
    return bool
}


