//
//  GroupView.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/17/16.
//
//

import Cocoa
import Foundation
import AppKit

class GroupView: NSView
{
    var lastLocation: CGPoint = CGPointMake(0, 0)
    var acceptsFirstResponer = true
    var acceptsFirstMouse = true
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    var editable = false
    
    var subviewArray: [[GroupSubview]] = [] //row, subview
    
    var updateTimer = NSTimer()
    

    func toggleEditable(obj:AnyObject?) {
        editable = !editable
    }

    //>>>DRAGGABLE STUFF<<<\\
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    override func mouseDown(theEvent: NSEvent)
    {
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
}
















