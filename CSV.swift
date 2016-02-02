//
//  CSV.swift
//
//  Created by DEAN, JOSHUA on 1/27/16.
//
//
// CSV Format   >>"Heading,Heading,Heading\nData,Data,Data\nData,Data,Data
// Array Format >> [["Heading", "Heading", "Heading"],
//                  ["Data",    "Data",    "Data"   ],
//                  ["Data",    "Data",    "Data"   ]]
//

import Foundation

class CSV {
    var fileData: String = "Name,Instument,Chair\nJosh,Percussion,420\nConnor,None,Last\n"
    var dataArray: [[String]] = [[]]

    
    init(inputName: String)
    {

    }
    
    
    /*
     *   returns the data array
     */
    func getDataArray() -> [[String]]
    {
        return dataArray
    }
    
    
    func arrayToData() -> String
    {
        dataArray = [["Heading", "Heading", "Heading"], ["Data", "Data", "Data"], ["Data", "Data", "Data"]]

        fileData = ""
        for x in 0...dataArray.count - 1
        {
            for y in 0...dataArray[x].count - 1
            {
                fileData += dataArray[x][y]
                if y != dataArray[x].count - 1
                {
                    fileData += ","
                }
            }
            fileData += "\n"
        }
        return fileData
    }
    /*
     *   puts a raw string into an array
     */
    func dataToArray()
    {
        var lastPos = 0
        var lineArray: [String] = []
        
        for x in 0...fileData.characters.count  //divide raw string into separate lines
        {
            if(subString(fileData, start: x, end: x) == "\n")
            {
                lineArray.append(subString(fileData, start: lastPos, end: x - 1))
                lastPos = x + 1;
            }
            if lastPos > fileData.characters.count - 1
            {
                break
            }
        }
        
        
        for x in 0...lineArray.count - 1
        {
            lastPos = 0
            let divString = lineArray[x]
            var tempDiv: [String] = []
            if x != 0
            {
                dataArray.append(Array<String>())
            }
            
            for i in 0...divString.characters.count - 1     //divide lines into items
            {
                if(subString(divString, start: i, end: i) == ",")
                {
                    tempDiv.append(subString(divString, start: lastPos, end: i - 1))
                   lastPos = i + 1;
                }
                if lastPos > divString.characters.count - 1
                {
                    break
                }
            }
            tempDiv.append(subString(divString, start: lastPos, end: divString.characters.count - 1))
            
            for i in 0...tempDiv.count - 1  //put all into array
            {
                dataArray[x].append(tempDiv[i])
            }
        }
    }
    
    
    /*
     *  for efficiency
     */
    private func subString(inString: String, start: Int, end: Int) -> String //probably a better way to do this
    {
        return inString.substringWithRange(Range<String.Index>(start: inString.startIndex.advancedBy(start), end: inString.startIndex.advancedBy(end + 1)))
    }
    
}











