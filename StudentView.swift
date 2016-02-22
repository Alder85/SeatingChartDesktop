//
//  StudentView.swift
//

import Cocoa
import Foundation
import AppKit

class StudentView: NSView {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    var acceptsFirstResponer = true
    var acceptsFirstMouse = true
    let viewLength: CGFloat = 100
    let viewHeight: CGFloat  = 100
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    var clickX: CGFloat = 0
    var clickY: CGFloat = 0
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var spotsfilled: [Bool] = []
    
    func startUp() {
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, viewHeight))
        label.stringValue = "potatoes"
        label.editable = false
        //label.= NSTextAlignment.Center
        self.addSubview(label)
        label.backgroundColor = NSColor.purpleColor()
        spotsfilled = retrieveBoolArray("Spots")
    }
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func mouseDown(theEvent: NSEvent)
    {
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
        Swift.print(self.frame.minX)
        if self.frame.minX == 300.0
        {
            spotsfilled = retrieveBoolArray("Spots")
            spotsfilled[0] = false
            storeBoolArray("Spots", valArray: spotsfilled)
        }
        
        if self.frame.minX == 100.0
        {
            spotsfilled = retrieveBoolArray("Spots")
            spotsfilled[1] = false
            storeBoolArray("Spots", valArray: spotsfilled)
        }
    }
    
    override func mouseDragged(theEvent: NSEvent)
    {
        clickX = theEvent.locationInWindow.x
        clickY = theEvent.locationInWindow.y
        offsetX = clickX - firstClick.x
        offsetY = clickY - firstClick.y
        
        //Swift.print(clickX)
        //Swift.print(clickY)
        
        self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, viewLength, viewHeight)
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
        if clickX > 600 && clickY > 300 && spotsfilled[0] == false
        {
            spotsfilled = retrieveBoolArray("Spots")
            spotsfilled[0] = true
            storeBoolArray("Spots", valArray: spotsfilled)
            self.frame = CGRectMake(300, 300, viewLength, viewHeight)
        }
        
        if clickX < 200 && clickY < 200 && spotsfilled[1] == false
        {
            spotsfilled = retrieveBoolArray("Spots")
            spotsfilled[1] = true
            Swift.print("Entered")
            storeBoolArray("Spots", valArray: spotsfilled)
            self.frame = CGRectMake(100, 100, viewLength, viewHeight)
        }
    }
    
    
}
