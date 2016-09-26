//
//  GroupSubview.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 4/13/16.
//
//

import Cocoa
import Foundation
import AppKit

class GroupSubview: NSView
{
    let viewLength: CGFloat = 50
    let viewHeight: CGFloat  = 50
    var isSnapped = false
    var studentview: StudentView! = StudentView(inRect: CGRect(x: 0,y: 0,width: 0,height: 0), inStudent: Student(inName: "", inChair: 0, inInstrument: ""))
    var pointerloc = -1
    var updateTimer = Timer()
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("GroupSubviews")
    
    struct PropertyKey {
        static let studentViewKey = "studentView"
    }
    
    init(inRect: NSRect, studentv: StudentView) {
        
        
        super.init(frame: inRect)
        self.frame = inRect
        self.setNeedsDisplay(self.frame) //makes context exist
        self.studentview = studentv
        
        /*
        self.wantsLayer = true
        self.layer!.borderWidth = 2
        self.layer!.cornerRadius = 10
        */
        //self.backgroundColor = NSColor.greenColor()
        updateTimer = Timer.scheduledTimer(timeInterval: 0.033, target: self, selector: "redraw:", userInfo: nil, repeats: true)
    }
    override var isOpaque: Bool{
        return false
    }
    
    convenience init(inRect: NSRect) {
        
        self.init(inRect: inRect, studentv: StudentView(inRect: CGRect(x: 0,y: 0,width: 0,height: 0), inStudent: Student(inName: "", inChair: 0, inInstrument: "")))
        self.frame = inRect
        self.setNeedsDisplay(self.frame) //makes context exist
        //self.studentview = studentv
        
        /*
        self.wantsLayer = true
        self.layer!.borderWidth = 2
        self.layer!.cornerRadius = 10
        */
    }

    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
       
       // let bPath:NSBezierPath = NSBezierPath(roundedRect: dirtyRect, xRadius: 15, yRadius: 15)
        //let borderColor = NSColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
       // borderColor.set()
       // bPath.stroke()
        NSColor.blue.setFill()
        NSRectFill(dirtyRect);
            
    }

    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.studentview, forKey: PropertyKey.studentViewKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // Must call designated initializer.
        self.init(inRect: CGRect(x: 0,y: 0,width: 0,height: 0), studentv: StudentView(inRect: CGRect(x: 0,y: 0,width: 0,height: 0), inStudent: Student(inName: "", inChair: 0, inInstrument: "")))
    }
    
    
    func setSnapped(_ inVal: Bool)
    {
        isSnapped = inVal
    }
    
    func isInRange(_ testVal: CGFloat, val1: Double, val2: Double) -> Bool
    {
        return Double(testVal) > val1 && Double(testVal) < val2
    }
    
    func isInside(_ inPoint: CGPoint) -> Bool
    {
        if isInRange(inPoint.x, val1: Double((self.superview?.frame.minX)! + frame.minX), val2: Double((self.superview?.frame.minX)! + frame.maxX)) &&
            isInRange(inPoint.y, val1: Double((self.superview?.frame.minY)! + frame.minY), val2: Double((self.superview?.frame.minY)! + frame.maxY))
        {
            return true
        }
        return false
    }
    
    func getSnapped() -> Bool
    {
        return isSnapped
    }
    
    func setStudentView(_ dastudent: StudentView)
    {
        studentview = dastudent
    }
    
    func getFrame() -> CGRect
    {
        return self.frame
    }
    
}
