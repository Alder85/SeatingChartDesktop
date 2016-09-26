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
    var lastLocation: CGPoint = CGPoint(x: 0, y: 0)
    var acceptsFirstResponer = true
    var acceptsFirstMouse = true
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    var editable = false
    var updateTimer = Timer()
    var subviewArray: [[GroupSubview]] = [] //row, subview
    
    var frameRect: CGRect
    var frameArray: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
    
    init(inFrame: NSRect) {
        frameRect = inFrame
        super.init(frame: inFrame);
        updateFrameArray()
        let panRecognizer = NSPanGestureRecognizer(target:self, action:#selector(GroupView.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        updateTimer = Timer.scheduledTimer(timeInterval: 0.033, target: self, selector: "redraw:", userInfo: nil, repeats: true)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCoordsOfSubview(_ x: Int, y: Int) -> CGPoint
    {
        return CGPoint(x: (subviewArray[x][y].frame.minX + CGFloat(self.frame.minX)), y: (subviewArray[x][y].frame.minY + CGFloat(self.frame.minY)))
    }
    
    func isInRange(_ testVal: CGFloat, val1: Double, val2: Double) -> Bool
    {
        return Double(testVal) > val1 && Double(testVal) < val2
    }

    func toggleEditable(_ obj:AnyObject?) {
        editable = !editable
    }

    //>>>DRAGGABLE STUFF<<<\\
    override func acceptsFirstMouse(for theEvent: NSEvent?) -> Bool {
        //Swift.print("potatoe")
        return true
    }
    
    override var isOpaque: Bool{
        return false
    }
    
    func detectPan(_ recognizer:NSPanGestureRecognizer) {
        let location = recognizer.location(in: self.superview!)
        let translation = recognizer.translation(in: self)
        
        //Swift.print(location, "    ", centerInFrame)
        self.frame = edgeCheck(CGRect(x: location.x - centerInFrame.x, y: location.y - centerInFrame.y, width: self.frame.width, height: self.frame.height))
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
                        subviewArray[x][y].studentview!.frame = CGRect(x: i, y: h, width: subviewArray[x][y].studentview!.frame.width, height: subviewArray[x][y].studentview!.frame.height)
                        subviewArray[x][y].studentview!.updateFrameArray()
                    }
                }
            }
        }
    }
    
    func edgeCheck(_ checkFrame: CGRect) -> CGRect
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
        return CGRect(x: x, y: y, width: width, height: height)
    }

    func updateFrameArray()
    {
        frameArray[0] = self.frame.minX
        frameArray[1] = self.frame.minY
        frameArray[2] = self.frame.width
        frameArray[3] = self.frame.height
    }

}
















