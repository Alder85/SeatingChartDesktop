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
    let viewLength: CGFloat = 300
    let viewHeight: CGFloat  = 100
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    var isMovable = true
    var numberOfSubviews: Int = 0
    var subviewArray: [GroupSubview] = []
    var position: CGFloat = 0
    let moveButton = NSButton(frame: CGRectMake(2,2,10,10))
    var groupcoords: [Double] = retrieveDoubleArray("GroupC")
    
    
    func startUp(subviews: Int) {
        numberOfSubviews = subviews
        
        
        for _ in 0...numberOfSubviews - 1
        {
            
            let temp = GroupSubview()
                temp.startUp(position, y: (viewHeight / 2) - 25)
            subviewArray.append(temp)
            self.addSubview(subviewArray[subviewArray.count - 1])
            position = position + 60
            
        }
        
        self.frame = CGRectMake(50, 100, viewLength, viewHeight)
        
        drawRect(NSRect(x: 0, y: 0, width: viewLength, height: viewHeight)) // outline
        
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, 17)) //moveable label
        label.stringValue = "   Moveable"
        label.editable = false
        label.bezeled  = false
        label.drawsBackground = false
        label.selectable = false
        self.addSubview(label)
        
        let moveButton = NSButton(frame: CGRectMake(2,2,10,10))
        moveButton.setButtonType(NSButtonType.SwitchButton) //moveable checkbox
        moveButton.action = "changeMoveable:"
        moveButton.target = self
        self.addSubview(moveButton)
        
        let removeViewButton = NSButton(frame: CGRectMake(163,2,15,15)) //remove views
        removeViewButton.title = "-"
        removeViewButton.action = "removeView:"
        removeViewButton.target = self
        self.addSubview(removeViewButton)
        
        let addViewButton = NSButton(frame: CGRectMake(180,2,15,15)) //add views
        addViewButton.title = "+"
        addViewButton.action = "addView:"
        addViewButton.target = self
        self.addSubview(addViewButton)

    }
    
    func addView(obj:AnyObject?) {
        let temp = GroupSubview()
        temp.startUp(position, y: (viewHeight / 2) - 25)
        subviewArray.append(temp)
        self.addSubview(temp)
        position = position + 60
    }
    
    func removeView(obj:AnyObject?) {
        subviewArray[subviewArray.count - 1].removeFromSuperview()
        subviewArray.removeAtIndex(subviewArray.count - 1)
        position = position - 60
    }
    
    func changeMoveable(obj:AnyObject?) {
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
            //groupcoords[0] = (Double)(offsetX + firstFrame.x)
           // groupcoords[1] = (Double)(offsetY + firstFrame.y)
            //groupcoords[2] = (Double)(viewLength + offsetX + firstFrame.x)
           // groupcoords[3] = (Double)(viewHeight + offsetY + firstFrame.y)
          //  storeDoubleArray("GroupC", valArray: groupcoords)
        }
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
        
    }
}

class GroupSubview: NSView
{
    let viewLength: CGFloat = 50
    let viewHeight: CGFloat  = 50
    func startUp(x: CGFloat, y: CGFloat)
    {
        self.frame = CGRectMake(x, y, viewLength, viewHeight)
        
        drawRect(NSRect(x: 0, y: 0, width: viewLength, height: viewHeight)) // outline
        
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, viewHeight)) //moveable label
        label.stringValue = "test"
        label.editable = false
        label.bezeled  = false
        label.drawsBackground = false
        label.selectable = false
        self.addSubview(label)
    }
    override func drawRect(dirtyRect: NSRect)
    {
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
        
    }
}



















