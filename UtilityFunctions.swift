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
func dataToStudentArray(_ dataArray: [[String]]) -> [Student]
{
    var outArray: [Student] = []
    for x in 0...dataArray.count - 1
    {
        let temp = Student(inArray: dataArray[x], otherArray: [""])
        outArray.append(temp)
    }
    return outArray
}

func dataToStudentArrayAndNameArray(_ dataArray: [[String]]) -> (studentArray: [Student], nameArray: [String])
{
    var outArray: [Student] = []
    var otherArray: [String] = []
    var gotnames = false
    for x in 0...dataArray.count - 1
    {
        if(!gotnames && dataArray[x][0] == ("Name"))
        {
            otherArray = dataArray[x]
            gotnames = true
        }
        else
        {
            let temp = Student(inArray: dataArray[x], otherArray: otherArray)
            outArray.append(temp)
        }
    }
    return (outArray, otherArray)
}

extension NSView {
    
    var backgroundColor: NSColor? {
        get {
            guard let layer = layer, let backgroundColor = layer.backgroundColor else { return nil }
            return NSColor(cgColor: backgroundColor)
        }
        
        set {
            wantsLayer = true
            layer?.backgroundColor = newValue?.cgColor
        }
        


    }
    var center: CGPoint {
        return CGPoint(x: NSMidX(self.frame), y: NSMidY(self.frame))
    }
    
    var centerInFrame: CGPoint {
        return CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    }
    func redraw()
    {
        let dummy = false
        redraw(dummy as AnyObject?)
    }
    
    func redraw(_ obj: AnyObject?) //redraws view, solves dragging issues
    {
        self.needsDisplay = true
    }
}

/*
 *  MAXIMUM EFFICIENCY
 */
extension String
{
    func substring(_ start: Int, end: Int) -> String
    {
        
        
        let endVal = self.characters.index(self.startIndex, offsetBy: end + 1)
        let startVal = self.characters.index(self.startIndex, offsetBy: start, limitedBy: endVal)
        return self.substring(with: (startVal! ..< endVal))

        //return self.substringWithRange(Range<String.Index>(start: self.startIndex.advancedBy(start), end: self.startIndex.advancedBy(end + 1)))
    }
    func indexOf(_ string: String) -> String.Index? {
        return range(of: string, options: .literal, range: nil, locale: nil)?.lowerBound
    }
}

/*
 *  Able to be called from ObjC
 */
@objc class SwiftFunctions1: NSObject {
    func determineFileType(_ description: String) -> String {
        let type = description.indexOf("google-apps")
        //print(type)
        var loc: String
        loc = String(describing: type)
        if String(describing: type).isEmpty || type == nil {
            //print("IsEmpty")
            loc = "empty"
        }
        else
        {
            loc = String(describing: type).substring(9,end: 10)
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


let defaults = UserDefaults.standard
func storeStudentArrayArray(_ name: String, valArray: [[Student]])
{
    defaults.setValue(valArray, forKey: name)
}

func retrieveStudentArrayArray(_ name: String) -> [[Student]]
{
    if let temp = defaults.value(forKey: name) as? [[Student]]
    {return temp}
    return [[]] 
}

/**
    Delays for a time, in seconds
    - Parameters:
        - delay: Seconds to delay
    ![Wait a minute](https://cdn.meme.am/instances/49880791.jpg)
 */
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

/**
    Flips a Boolean value
    - Note: Do not attempt to simplify, this is the scientifically proven most effective method
    - Parameters:
        - bool: The Boolean to be flipped
    - Returns: The flipped Boolean
 
    ![Visible Confusion](https://i.warosu.org/data/ck/thumb/0058/69/1412871056921s.jpg)
 */
func flipBoolean(_ bool: Bool) -> Bool
{
    var bool = bool
    let bool1 = bool;
    bool = false;
    var bool2 = bool;
    bool2 = bool1 == bool ? bool2 : bool1
    bool = !bool2
    return bool
}


