//
//  Student.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/3/16.
//
//

import Foundation

class Student {
    private var name: String        = "invalid name"
    private var chair: Int          = -42
    private var instrument: String  = "invalid instrument"
    
    init()
    {
        
    }
    
    init(inArray: [String])
    {
        name = inArray[0]
        chair = Int(inArray[1])!
        instrument = inArray[2]
    }
    
    init(inName: String, inChair: Int, inInstrument: String)
    {
        name = inName
        chair = inChair
        instrument = inInstrument
    }
    
    func getName() -> String
    {
        return name
    }
    
    func getChair() -> Int
    {
        return chair
    }
    
    func getInstrument() -> String
    {
        return instrument
    }
    
    func setName(inName: String)
    {
        name = inName
    }
    
    func setChair(inChair: Int)
    {
        chair = inChair
    }
    
    func setInstrument(inInstrument: String)
    {
        instrument = inInstrument
    }
}






