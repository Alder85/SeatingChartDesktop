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