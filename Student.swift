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
    private var name: String        = "invalid name"
    private var instrument: String  = "invalid instrument"
    private var chair: Int          = -42
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("Students")
    
    struct PropertyKey {
        static let nameKey = "name"
        static let instrumentKey = "instrument"
        static let chairKey = "chair"
    }
    
    override init()
    {
        
    }
    
    init(inArray: [String])
    {
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
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(instrument, forKey: PropertyKey.instrumentKey)
        aCoder.encodeObject(chair, forKey: PropertyKey.chairKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        let instrument = aDecoder.decodeObjectForKey(PropertyKey.instrumentKey) as! String
        
        let chair = aDecoder.decodeObjectForKey(PropertyKey.chairKey) as! Int
        
        // Must call designated initializer.
        self.init(inName: name, inChair: chair, inInstrument: instrument)
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
    
    override var description: String
    {
        return name + " plays " + instrument + " and is chair #" + String(chair)
    }
}








