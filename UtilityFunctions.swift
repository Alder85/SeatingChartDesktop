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