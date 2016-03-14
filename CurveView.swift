//
//  CurveView.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/29/16.
//
//

import Foundation
import Cocoa
import AppKit
import Darwin

class CurveView: NSView {
    //Dragable stuff
    var lastLocation: CGPoint = CGPointMake(0, 0)
    var acceptsFirstResponer = true
    var acceptsFirstMouse = true
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    var isMovable = true
    var numRows: CGFloat
    var rowLength: CGFloat
    
    var leftRect = false
    var frameRect: CGRect
    
    var updateTimer = NSTimer() //solves dragging issue
    
    init(size: Int, isLeft: Bool, rows: CGFloat, length: CGFloat) {
        frameRect = CGRect(origin: CGPointMake(0,0), size: CGSize(width: size, height: size))
        leftRect = isLeft
        numRows = rows
        rowLength = length
        super.init(frame: frameRect)

        self.setNeedsDisplayInRect(self.frame) //makes context exist
        
        //change the time value if this gets laggy
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "redraw:", userInfo: nil, repeats: true)
        
    }
    func redraw(obj:AnyObject?) //redraws view, solves dragging issues
    {
        self.needsDisplay = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)
        let context = NSGraphicsContext.currentContext()?.CGContext
        CGContextSetStrokeColorWithColor(context, NSColor.purpleColor().CGColor)
        CGContextSetLineWidth(context, 5.0)
        if !leftRect
        {
            for i in 1...Int(numRows)
            {
                let y = ((dirtyRect.size.width - rowLength) / numRows) * CGFloat(i)
                makeRightCurve(context, startSpot: y, length: rowLength, rect: dirtyRect)
            }
        }
        else
        {
            for i in 1...Int(numRows)
            {
                let y = ((dirtyRect.size.width - rowLength) / numRows) * CGFloat(i)
                makeLeftCurve(context, startSpot: y, length: rowLength, rect: dirtyRect)
            }
        }
        
        
        
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
//*/
    }
    func makeRightCurve(context: CGContext?, startSpot: CGFloat, length: CGFloat, rect: NSRect)
    {
        CGContextAddArc(context, 0, 0, startSpot + length, 0, CGFloat(M_PI) / 2, 0) //big curve
        
        CGContextMoveToPoint(context, startSpot + length, 0)                        //bottom line
        CGContextAddLineToPoint(context, startSpot, 0)
        
        CGContextAddArc(context, 0, 0, startSpot, 0, CGFloat(M_PI) / 2, 0)          //little curve
        
        CGContextMoveToPoint(context, 0, startSpot)                                 //left line
        CGContextAddLineToPoint(context, 0, startSpot + length)
        CGContextStrokePath(context)
    }
    
    func makeLeftCurve(context: CGContext?, startSpot: CGFloat, length: CGFloat, rect: NSRect)
    {
        CGContextAddArc(context, rect.width, 0, startSpot + length, 0, CGFloat(M_PI) / 2, 1) //big curve
        
        CGContextMoveToPoint(context, rect.width - (startSpot + length), 0)                  //bottom line
        CGContextAddLineToPoint(context, rect.width - startSpot, 0)
        CGContextStrokePath(context)
        
        CGContextAddArc(context, rect.width, 0, startSpot, 0, CGFloat(M_PI) / 2, 1)          //little curve
        
        CGContextMoveToPoint(context, rect.width, startSpot)
        CGContextAddLineToPoint(context, rect.width, startSpot + length)                     //left line
        CGContextStrokePath(context)
        /*
        CGContextAddArc(context, rect.maxX, 0, startSpot + length, 0, CGFloat(M_PI) / 2, 1) //big curve
        
        CGContextMoveToPoint(context, rect.maxX - (startSpot + length), 0)                  //bottom line
        CGContextAddLineToPoint(context, rect.maxX - startSpot, 0)
        CGContextStrokePath(context)
        
        CGContextAddArc(context, rect.maxX, 0, startSpot, 0, CGFloat(M_PI) / 2, 1)          //little curve
        
        CGContextMoveToPoint(context, rect.maxX, startSpot)
        CGContextAddLineToPoint(context, rect.maxX, startSpot + length)                     //left line
        CGContextStrokePath(context)
        */
    }

    
    
    func changeMoveable(obj:AnyObject?) {
        isMovable = !isMovable
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
        
        if isMovable
        {
            self.frame = edgeCheck(CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, self.frame.width, self.frame.height))
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
    

}
