//
//  UtilityFunctions.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/3/16.
//
//

import Foundation

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

