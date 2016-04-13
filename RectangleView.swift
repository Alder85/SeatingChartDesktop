//
//  RectangleView.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 4/13/16.
//
//

import Cocoa
import Foundation
import AppKit

class RectangleView: GroupView
{

    let viewLength: CGFloat = 300
    let viewHeight: CGFloat  = 100
    var numberOfSubviews: Int = 0
    var position: CGFloat = 0
    let moveButton = NSButton(frame: CGRectMake(2,2,10,10))
        var locX = 50.0
    var locY = 100.0
    var isdragging = false
    
    convenience init(inView: NSView)
    {
        self.init(inRect: inView.frame, subviews: 1)
    }
    
    init(inRect: CGRect, subviews: Int)
    {
        super.init(frame: inRect)
        numberOfSubviews = subviews
        subviewArray.append([])
        for _ in 0...numberOfSubviews - 1
        {
            
            let temp = GroupSubview(inRect: CGRectMake(position, (viewHeight / 2) - 25, 50, 50))
            //temp.startUp(position, y: (viewHeight / 2) - 25)
            subviewArray[0].append(temp)
            self.addSubview(subviewArray[0][subviewArray[0].count - 1])
            position = position + 60
            
        }
        self.setNeedsDisplayInRect(self.frame) //makes context exist
        self.frame = inRect
        //self.frame = CGRectMake(50, 100, viewLength, viewHeight)
        
        
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
        
        //change the time value if this gets laggy
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "redraw:", userInfo: nil, repeats: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redraw(obj:AnyObject?)
    {
        self.needsDisplay = true
    }
    
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)
        
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
        
    }
    
    
    func addView(obj:AnyObject?) {
        let temp = GroupSubview(inRect: CGRectMake(position, (viewHeight / 2) - 25, 50, 50))
        //temp.startUp(position, y: (viewHeight / 2) - 25)
        subviewArray[0].append(temp)
        self.addSubview(temp)
        position = position + 60
        numberOfSubviews++
        
        
    }
    
    func removeView(obj:AnyObject?) {
        subviewArray[0][subviewArray[0].count - 1].removeFromSuperview()
        subviewArray[0].removeAtIndex(subviewArray[0].count - 1)
        position = position - 60
        numberOfSubviews--
    }
    
    func getCoordsOfSubview(index: Int) -> CGPoint
    {
        return CGPoint(x: (subviewArray[0][index].frame.minX + CGFloat(locX)), y: (subviewArray[0][index].frame.minY + CGFloat(locY)))
    }
    
    func isInRange(testVal: CGFloat, val1: Double, val2: Double) -> Bool
    {
        return Double(testVal) > val1 && Double(testVal) < val2
    }
    
    
    override func mouseDragged(theEvent: NSEvent)
    {
        
        let clickX = theEvent.locationInWindow.x
        let clickY = theEvent.locationInWindow.y
        let offsetX = clickX - firstClick.x
        let offsetY = clickY - firstClick.y
        
        if !editable
        {
            isdragging = true
            self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, viewLength, viewHeight)
            locX = Double(offsetX + firstFrame.x)
            locY = Double(offsetY + firstFrame.y)
            
            
            
            for f in 0...subviewArray.count - 1
            {
                if subviewArray[0][f].student.getName() != ""
                {
                    for r in 0...Int((self.superview?.subviews.count)!) - 1
                    {
                        if self.superview?.subviews[r] is StudentView
                        {
                            if (self.superview?.subviews[r] as! StudentView).student.getName() == subviewArray[0][f].student.getName()
                            {
                                let i = getCoordsOfSubview(f).x
                                let h = getCoordsOfSubview(f).y
                                (self.superview?.subviews[r] as! StudentView).frame = CGRectMake(i, h, viewLength, viewHeight)
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
        isdragging = false
    }

}