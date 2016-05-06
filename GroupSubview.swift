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
    var studentview: StudentView?
    var pointerloc = -1
    var updateTimer = NSTimer()
    
    init(inRect: NSRect) {
        
        
        super.init(frame: inRect)
        self.frame = inRect
        self.setNeedsDisplayInRect(self.frame) //makes context exist
        
        /*
        self.wantsLayer = true
        self.layer!.borderWidth = 2
        self.layer!.cornerRadius = 10
        */
        self.backgroundColor = NSColor.greenColor()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.033, target: self, selector: "redraw:", userInfo: nil, repeats: true)
    }
    override var opaque: Bool{
        return false
    }
    
    

    
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)
       
       // let bPath:NSBezierPath = NSBezierPath(roundedRect: dirtyRect, xRadius: 15, yRadius: 15)
        //let borderColor = NSColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0)
       // borderColor.set()
       // bPath.stroke()
            
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setStudentView(dastudent: StudentView)
    {
        studentview = dastudent
    }
    
    func getFrame() -> CGRect
    {
        return self.frame
    }
    
}