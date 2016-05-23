//
//  Student.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/3/16.
//
//

import Foundation

class Student: NSObject, NSCoding
{
    private var informationArray: [String] = []
    private var name: String        = "invalid name"
    private var instrument: String  = "invalid instrument"
    private var chair: Int          = -42
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("Students")
    
    struct PropertyKey {
        static let informationKey = "information"
    }
    
    override init()
    {
        
    }
    
    init(inArray: [String])
    {
        informationArray = inArray
        name = inArray[0]
        instrument = inArray[1]
        chair = Int(inArray[2])!
    }
    
    init(inName: String, inChair: Int, inInstrument: String)
    {
        name = inName
        instrument = inInstrument
        chair = inChair
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(informationArray, forKey: PropertyKey.informationKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let informationArray = aDecoder.decodeObjectForKey(PropertyKey.informationKey) as! [String]
        
        // Must call designated initializer.
        self.init(inArray: informationArray)
    }
    
    func getName() -> String
    {
        return name
    }
    
    func getInstrument() -> String
    {
        return instrument
    }
    
    func getChair() -> Int
    {
        return chair
    }
    
    func setName(inName: String)
    {
        name = inName
    }
    
    func setInstrument(inInstrument: String)
    {
        instrument = inInstrument
    }
    
    func setChair(inChair: Int)
    {
        chair = inChair
    }
    
    func getInformation() -> [String]
    {
        return informationArray
    }
    
    func setInformation(str: String, loc: Int)
    {
        informationArray[loc] = str
    }
    
    override var description: String
    {
        return name + " plays " + instrument + " and is chair #" + String(chair)
    }
}








