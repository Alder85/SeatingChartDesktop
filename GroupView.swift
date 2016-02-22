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
    var isMovable = false
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
        
        drawRect(NSRect(x: 0, y: 0, width: viewLength, height: viewHeight))
        //self.addSubview(dirtyRect)
        
        //self.addSubview(frameRect)
        
        
        //self.layer!.borderColor = NSColor.orangeColor().CGColor
        
        
        
        
    }
    
    override func drawRect(dirtyRect: NSRect)
    {
        var bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
       // let fillColor = NSColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        //fillColor.set()
       // bPath.fill()
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
       // bPath.lineWidth = 12.0
        bPath.stroke()
        
       // let circleFillColor = NSColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
       // var circleRect = NSMakeRect(dirtyRect.size.width/4, dirtyRect.size.height/4, dirtyRect.size.width/2, dirtyRect.size.height/2)
       // var cPath: NSBezierPath = NSBezierPath(ovalInRect: circleRect)
      //  circleFillColor.set()
      //  cPath.fill()
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
