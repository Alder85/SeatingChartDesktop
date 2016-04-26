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
    var frameRect: CGRect
    
    init(inFrame: NSRect) {
        frameRect = inFrame
        super.init(frame: inFrame);
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCoordsOfSubview(x: Int, y: Int) -> CGPoint
    {
        return CGPoint(x: (subviewArray[x][y].frame.minX + CGFloat(frameRect.minX)), y: (subviewArray[x][y].frame.minY + CGFloat(frameRect.minY)))
    }
    
    func isInRange(testVal: CGFloat, val1: Double, val2: Double) -> Bool
    {
        return Double(testVal) > val1 && Double(testVal) < val2
    }

    func toggleEditable(obj:AnyObject?) {
        editable = !editable
    }

    //>>>DRAGGABLE STUFF<<<\\
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    override func mouseDown(theEvent: NSEvent)
    {
        Swift.print("Mouse Down")
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    func redraw()
    {
        let dummy = false
        redraw(dummy)
    }
    
    func redraw(obj: AnyObject?) //redraws view, solves dragging issues
    {
        self.needsDisplay = true
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        Swift.print("Mouse Drag")
        let clickX = theEvent.locationInWindow.x
        let clickY = theEvent.locationInWindow.y
        let offsetX = clickX - firstClick.x
        let offsetY = clickY - firstClick.y
        if editable
        {
            frameRect = self.frame
            self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, frameRect.width, frameRect.height)
            //locX = Double(offsetX + firstFrame.x)
            //locY = Double(offsetY + firstFrame.y)
            
            for y in 0...subviewArray[0].count - 1
            {
                for x in 0...subviewArray.count - 1
                {
                    if let _ = subviewArray[x][y].studentview
                    {
                        if subviewArray[x][y].studentview?.student.getName() != ""
                        {
                            let i = getCoordsOfSubview(x, y: y).x
                            let h = getCoordsOfSubview(x, y: y).y
                            subviewArray[x][y].studentview!.frame = CGRectMake(i, h, frameRect.width, frameRect.height)
                        }
                    }
                }
            }
            self.frame = edgeCheck(CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, self.frame.width, self.frame.height))
        }
        redraw()
    }
    
    func edgeCheck(checkFrame: CGRect) -> CGRect
    {
        var x = checkFrame.minX
        var y = checkFrame.minY
        let maxX = checkFrame.maxX
        let maxY = checkFrame.maxY
        let width = checkFrame.width
        let height = checkFrame.height
        let bigFrame = self.superview!.frame
        if(x < bigFrame.minX)
        {
            x = 0
        }
        if(y < bigFrame.minY)
        {
            y = 0
        }
        if(maxX > bigFrame.maxX)
        {
            x = bigFrame.maxX - width
        }
        if(maxY > bigFrame.maxY)
        {
            y = bigFrame.maxY - height
        }
        return CGRectMake(x, y, width, height)
    }

}
















