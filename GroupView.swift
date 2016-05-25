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
    var updateTimer = NSTimer()
    var subviewArray: [[GroupSubview]] = [] //row, subview
    
    var frameRect: CGRect
    var frameArray: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
    
    init(inFrame: NSRect) {
        frameRect = inFrame
        super.init(frame: inFrame);
        updateFrameArray()
        let panRecognizer = NSPanGestureRecognizer(target:self, action:"detectPan:")
        self.gestureRecognizers = [panRecognizer]
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.033, target: self, selector: "redraw:", userInfo: nil, repeats: true)

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
        Swift.print("potatoe")
        return true
    }
    
    override var opaque: Bool{
        return false
    }
    
    func detectPan(recognizer:NSPanGestureRecognizer) {
        let location = recognizer.locationInView(self.superview!)
        let translation = recognizer.translationInView(self)
        
        //Swift.print(location, "    ", centerInFrame)
        self.frame = edgeCheck(CGRectMake(location.x - centerInFrame.x, location.y - centerInFrame.y, self.frame.width, self.frame.height))
        moveAllViewsWithGroup()
        updateFrameArray()
    }

    
    
    func moveAllViewsWithGroup()
    {
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
                        subviewArray[x][y].studentview!.updateFrameArray()
                    }
                }
            }
        }
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

    func updateFrameArray()
    {
        frameArray[0] = self.frame.minX
        frameArray[1] = self.frame.minY
        frameArray[2] = self.frame.width
        frameArray[3] = self.frame.height
    }

}
















