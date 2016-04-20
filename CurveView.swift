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

class CurveView: GroupView {
    //Dragable stuff
    
    
    var numRows: CGFloat
    var rowLength: CGFloat
    var buttonArray: [NSButton] = []
    
    
    
    var leftRect = false
    var frameRect: CGRect
    
    init(size: Int, isLeft: Bool, rows: CGFloat, length: CGFloat)
    {
        frameRect = CGRect(origin: CGPointMake(0,0), size: CGSize(width: size, height: size))
        leftRect = isLeft
        numRows = rows
        rowLength = length
        super.init(frame: frameRect)
        makeButtons()
        addEditToggle()
        hideButtons()
        for i in 0...(Int(rows - 1))
        {
            subviewArray.insert([], atIndex: i)
            for q in 0...4
            {
                let temp = GroupSubview(inRect: CGRectMake(CGFloat(arc4random_uniform(UInt32(self.frame.height))), CGFloat(arc4random_uniform(UInt32(self.frame.height))), 50, 50))
                subviewArray[i].insert(temp, atIndex: q)
                //self.addSubview(subviewArray[i][q])
            }
        }
        
        self.setNeedsDisplayInRect(self.frame) //makes context exist
        
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "redraw:", userInfo: nil, repeats: true)
    }
    
    func makeButtons()
    {
        if !leftRect
        {
            for i in 1...Int(numRows)
            {
                let y = ((self.frame.size.width - rowLength) / numRows) * CGFloat(i)
                makeAddButton(CGPointMake(y + 2, 2), row: i)
                makeSubtractButton(CGPointMake(y + 20, 2), row: i)
            }
        }
        else
        {
            for i in 1...Int(numRows)
            {
                let y = ((self.frame.size.width - rowLength) / numRows) * (numRows - CGFloat(i))
                makeAddButton(CGPointMake(y + 2, 2), row: i)
                makeSubtractButton(CGPointMake(y + 20, 2), row: i)
            }
        }
    }
    
    func makeAddButton(point: CGPoint, row: Int)
    {
        let buttonSize = 20
        let button = NSButton(frame: CGRect(origin: point, size: CGSize(width: buttonSize, height: buttonSize))) //add views
        button.setButtonType(NSButtonType.MomentaryLightButton)
        button.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        button.title = "+"
        //button.sendActionOn(Int(NSEventMask.LeftMouseDownMask.rawValue))
        button.sendActionOn(Int(NSEventMask.LeftMouseDownMask.rawValue))
        button.action = "addView:"
        button.target = self
        button.identifier = String(row - 1)
        self.addSubview(button)
        buttonArray.append(button)
    }
    
    func makeSubtractButton(point: CGPoint, row: Int)
    {
        let buttonSize = 20
        let button = NSButton(frame: CGRect(origin: point, size: CGSize(width: buttonSize, height: buttonSize))) //add views
        button.setButtonType(NSButtonType.MomentaryLightButton)
        button.bezelStyle = NSBezelStyle.SmallSquareBezelStyle
        button.title = "-"
        button.sendActionOn(Int(NSEventMask.LeftMouseDownMask.rawValue))
        
        button.action = "removeView:"
        button.target = self
        button.identifier = String(row - 1)
        self.addSubview(button)
        buttonArray.append(button)
    }
    
    func addView(obj: NSButton)
    {
        let rowNumber = Int(obj.identifier!)
        Swift.print("add" + String(rowNumber))
        let temp = GroupSubview(inRect: CGRectMake(100, 100, 50, 50))
        temp.setLabelString("test " + String(subviewArray[rowNumber!].count))
        subviewArray[rowNumber!].insert(temp, atIndex: subviewArray[rowNumber!].count)
        redraw()
    }
    
    func removeView(obj: NSButton)
    {
        let rowNumber = Int(obj.identifier!)
        Swift.print("subtract" + String(rowNumber))
        if(subviewArray[rowNumber!].count > 0)
        {
            subviewArray[rowNumber!][subviewArray[rowNumber!].count - 1].removeFromSuperview()
            subviewArray[rowNumber!].removeAtIndex(subviewArray[rowNumber!].count - 1)
        }
        redraw()
    }
    
    func addEditToggle()
    {
        let toggleSize: CGFloat = 20
        let button = NSButton(frame: CGRectMake(self.frame.height - toggleSize, self.frame.height - toggleSize, toggleSize, toggleSize))
        if leftRect
        {
            button.frame = CGRectMake(0, self.frame.height - toggleSize, toggleSize, toggleSize)
        }
        button.setButtonType(NSButtonType.SwitchButton) //moveable checkbox
        button.sendActionOn(Int(NSEventMask.LeftMouseDownMask.rawValue))
        button.action = "toggleEditable:"
        button.target = self
        self.addSubview(button)
    }
    
    override func toggleEditable(obj: AnyObject?)
    {
        
        if editable
        {
            hideButtons()
        }
        else
        {
            showButtons()
        }
        redraw()
        super.toggleEditable(obj)
    }
    
    func hideButtons()
    {
        for i in 0...buttonArray.count - 1
        {
            buttonArray[i].hidden = true
        }
    }
    func showButtons()
    {
        for i in 0...buttonArray.count - 1
        {
            buttonArray[i].hidden = false
        }
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

    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)
        let lineWidth: CGFloat = 5
        let context = NSGraphicsContext.currentContext()?.CGContext
        CGContextSetStrokeColorWithColor(context, NSColor.purpleColor().CGColor)
        CGContextSetLineWidth(context, lineWidth)
        if !leftRect
        {
            for i in 1...Int(numRows)
            {
                let y = ((dirtyRect.size.width - rowLength) / numRows) * CGFloat(i)
                makeRightCurve(context, startSpot: y, length: rowLength, rect: dirtyRect)
               // if i == 5
              //  {
                    makeRightSubviewCurve(y, length: rowLength, curveNumber: (i-1))
                //}
            }

        }
        else
        {
            for i in 1...Int(numRows)
            {
                let y = ((dirtyRect.size.width - rowLength) / numRows) * CGFloat(i)
                makeLeftCurve(context, startSpot: y, length: rowLength, rect: dirtyRect)
                makeLeftSubviewCurve(y, length: rowLength, curveNumber: (i-1))
            }
        }

        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
//*/
    }
    
    func makeRightSubviewCurve(startSpot: CGFloat, length: CGFloat, curveNumber: Int)
    {
        let numSubviews = subviewArray[curveNumber].count
        if numSubviews <= 0
        {
            return
        }
        for i in 0...numSubviews - 1
        {
            let t = ((M_PI / 2) / Double(numSubviews - 1)) * Double(i)
            //let t = M_PI / 2
            let tempX = round( CGFloat(Double(startSpot) * cos(t)) )
            let tempY = round( CGFloat(Double(startSpot) * sin(t)) )
        
            subviewArray[curveNumber][i].frame = CGRectMake(tempX, tempY, 50, 50)
            
            self.addSubview(subviewArray[curveNumber][i])
        }
        if numSubviews == 1
        {
            let tempDegree = round( CGFloat(Double(startSpot) * sin(M_PI / 4)) )
            subviewArray[curveNumber][0].frame = CGRectMake(tempDegree, tempDegree, 50, 50)
            self.addSubview(subviewArray[curveNumber][0])
        }
    }
    
    func makeLeftSubviewCurve(startSpot: CGFloat, length: CGFloat, curveNumber: Int)
    {
        let numSubviews = subviewArray[curveNumber].count
        if numSubviews <= 0
        {
            return
        }
        for i in 0...numSubviews - 1
        {
            let t = ((M_PI / 2) / Double(numSubviews - 1)) * Double(i)
            //let t = M_PI / 2
            let tempX = frameRect.maxX - (round( CGFloat(Double(startSpot) * cos(t)) ) + 50)
            let tempY = round( CGFloat(Double(startSpot) * sin(t)) )
            
            subviewArray[curveNumber][i].frame = CGRectMake(tempX, tempY, 50, 50)
            
            self.addSubview(subviewArray[curveNumber][i])
        }
        if numSubviews == 1
        {
            let tempDegree = round( CGFloat(Double(startSpot) * sin(M_PI / 4)) )
            subviewArray[curveNumber][0].frame = CGRectMake(tempDegree, tempDegree, 50, 50)
            self.addSubview(subviewArray[curveNumber][0])
        }
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

    
    
    
    
    override func mouseDragged(theEvent: NSEvent)
    {
        
        let clickX = theEvent.locationInWindow.x
        let clickY = theEvent.locationInWindow.y
        let offsetX = clickX - firstClick.x
        let offsetY = clickY - firstClick.y
        
        if editable
        {
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
