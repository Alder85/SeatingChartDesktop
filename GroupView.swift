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
        let panRecognizer = NSPanGestureRecognizer(target:self, action:"detectPan:")
        self.gestureRecognizers = [panRecognizer]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCoordsOfSubview(x: Int, y: Int) -> CGPoint
    {
        return CGPoint(x: (subviewArray[x][y].frame.minX + CGFloat(self.frame.minX)), y: (subviewArray[x][y].frame.minY + CGFloat(self.frame.minY)))
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
    /*
    override func mouseDown(theEvent: NSEvent)
    {
        Swift.print("Mouse Down")
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    override func mouseDragged(theEvent: NSEvent) {
        self.needsDisplay = false
        Swift.print("Mouse Drag")
        let clickX = theEvent.locationInWindow.x
        let clickY = theEvent.locationInWindow.y
        let offsetX = clickX - firstClick.x
        let offsetY = clickY - firstClick.y
        if editable
        {
            moveAllViewsWithGroup(offsetX, offsetY: offsetY)
        }
    }
    
    override func mouseUp(theEvent: NSEvent) {
        self.needsDisplay = true
    }
*/
    
    func detectPan(recognizer:NSPanGestureRecognizer) {
        let translation =  recognizer.locationInView(self.superview!)
        Swift.print(translation)
        self.frame = edgeCheck(CGRectMake(lastLocation.x + translation.x - 25, lastLocation.y + translation.y - 25, self.frame.width, self.frame.height))
        moveAllViewsWithGroup()
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
    
    
    func moveAllViewsWithGroup()
    {
        /*frameRect = self.frame
        self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, frameRect.width, frameRect.height)*/
        
        for x in 0...subviewArray.count - 1
        {
            for y in 0...subviewArray[x].count - 1
            {
                if let _ = subviewArray[x][y].studentview
                {
                    if subviewArray[x][y].studentview?.student.getName() != ""
                    {
                        let i = getCoordsOfSubview(x, y: y).x
                        let h = getCoordsOfSubview(x, y: y).y
                        subviewArray[x][y].studentview!.frame = CGRectMake(i, h, subviewArray[x][y].studentview!.frame.width, subviewArray[x][y].studentview!.frame.height)
                    }
                }
            }
        }
        /*self.frame = edgeCheck(CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, self.frame.width, self.frame.height))*/
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
















