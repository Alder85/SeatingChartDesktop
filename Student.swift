//
//  Student.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/3/16.
//
//

import Foundation

class Student: CustomStringConvertible{
    private var name: String        = "invalid name"
    private var instrument: String  = "invalid instrument"
    private var chair: Int          = -42
    
    init()
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
    
    var description: String
    {
        return name + " plays " + instrument + " and is chair #" + String(chair)
    }
}








