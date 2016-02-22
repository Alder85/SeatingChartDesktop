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

class GroupView: NSView {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    var acceptsFirstResponer = true
    var acceptsFirstMouse = true
    let viewLength: CGFloat = 100
    let viewHeight: CGFloat  = 100
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    var isMovable = true
    var numberOfSubviews: Int = 0
    var subviewArray: [NSView] = []
    var position: CGFloat = 0
    var groupcoords: [Double] = retrieveDoubleArray("GroupC")
    
    func startUp(subviews: Int) {
        numberOfSubviews = subviews
        
        for i in 0...numberOfSubviews - 1
        {
            position = position + 10
            subviewArray.append(NSView(frame: CGRectMake(position, 0, viewLength, viewHeight)))
            
            let label = NSTextField(frame: CGRectMake(0, 0, viewLength, viewHeight))
            label.stringValue = "groupsubview"
            label.editable = false
            subviewArray[i].addSubview(label)
           // label.backgroundColor = NSColor.redColor()
            //self.addSubview(subviewArray[i])
        }
        
        drawRect(NSRect(x: 0, y: 0, width: viewLength, height: viewHeight)) // outline
        
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, 17)) //moveable label
        label.stringValue = "   Moveable"
        label.editable = false
        label.bezeled  = false
        label.drawsBackground = false
        label.selectable = false
        self.addSubview(label)
        
        moveButton.setButtonType(NSButtonType.SwitchButton) //moveable checkbox
        moveButton.action = "buttonAction:"
        moveButton.target = self

        self.addSubview(moveButton)
    }
    
    func buttonAction(obj:AnyObject?) {
        isMovable = !isMovable
    }
    
    override func drawRect(dirtyRect: NSRect)
    {
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
       
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
        
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
        
        if !isMovable
        {
            self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, viewLength, viewHeight)
            groupcoords[0] = (Double)(offsetX + firstFrame.x)
            groupcoords[1] = (Double)(offsetY + firstFrame.y)
            groupcoords[2] = (Double)(viewLength + offsetX + firstFrame.x)
            groupcoords[3] = (Double)(viewHeight + offsetY + firstFrame.y)
        }
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
        
    }
    
    
}
