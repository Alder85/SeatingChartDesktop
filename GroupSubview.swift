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
    var student = Student()
    var pointerloc = -1
    var label: NSTextField
    
    init(inRect: NSRect) {
        label = NSTextField(frame: CGRectMake(0, 0, inRect.width, inRect.height)) //moveable label
        label.stringValue = "test"
        label.editable = false
        label.bezeled  = false
        label.drawsBackground = false
        label.selectable = false
        
        
        super.init(frame: inRect)
        self.frame = inRect
        self.setNeedsDisplayInRect(self.frame) //makes context exist
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelString(inLabel: String)
    {
        label.stringValue = inLabel
    }
    
    func setSnapped(inVal: Bool)
    {
        isSnapped = inVal
    }
    
    func isInRange(testVal: CGFloat, val1: Double, val2: Double) -> Bool
    {
        return Double(testVal) > val1 && Double(testVal) < val2
    }
    
    func isInside(inPoint: CGPoint) -> Bool
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
    
    func setStudent(dastudent: Student)
    {
        student = dastudent
    }
    
    func getStudent() -> Student
    {
        return student
    }
    
    func getFrame() -> CGRect
    {
        return self.frame
    }
    
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)
        
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
        
    }
}