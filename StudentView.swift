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
    
    func startUp() {
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, viewHeight))
        label.stringValue = "potatoes"
        label.editable = false
        //label.= NSTextAlignment.Center
        self.addSubview(label)
        label.backgroundColor = NSColor.purpleColor()
        
    }
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func mouseDown(theEvent: NSEvent)
    {
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    override func mouseDragged(theEvent: NSEvent)
    {
        let clickX = theEvent.locationInWindow.x
        let clickY = theEvent.locationInWindow.y
        let offsetX = clickX - firstClick.x
        let offsetY = clickY - firstClick.y

        self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, viewLength, viewHeight)
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
        
    }
    
    
}
