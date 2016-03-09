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
    var updateTimer = NSTimer()
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
        for _ in 0...numberOfSubviews - 1
        {
            
            let temp = GroupSubview()
            temp.startUp(position, y: (viewHeight / 2) - 25)
            subviewArray.append(temp)
            self.addSubview(subviewArray[subviewArray.count - 1])
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
        let temp = GroupSubview()
        temp.startUp(position, y: (viewHeight / 2) - 25)
        subviewArray.append(temp)
        self.addSubview(temp)
        position = position + 60
        numberOfSubviews++
        
       
    }
    
    func removeView(obj:AnyObject?) {
        subviewArray[subviewArray.count - 1].removeFromSuperview()
        subviewArray.removeAtIndex(subviewArray.count - 1)
        position = position - 60
        numberOfSubviews--
    }
    
    func changeMoveable(obj:AnyObject?) {
        isMovable = !isMovable
    }
    
    func setSubviewSnap(index: Int, value: Bool)
    {
        subviewArray[index].setSnapped(value)
    }
    
    func getSubviewSnap(index: Int) -> Bool
    {
        return subviewArray[index].getSnapped()
    }
    
    func getCoordsOfSubview(index: Int) -> CGPoint
    {
        return CGPoint(x: (subviewArray[index].frame.minX + CGFloat(locX)), y: (subviewArray[index].frame.minY + CGFloat(locY)))
    }
    
    func getSubviewWithName(name: String) -> Int
    {
        var value = -1
        if subviewArray.count > 0
        {
            for i in 0...subviewArray.count - 1
            {
                if subviewArray[i].getStudent().getName() == name
                {
                    return i
                }
            }
        }
        return value
    }
    
    func doDaSnap(inPoint: CGPoint) -> (Bool, Int)
    {
        if subviewArray.count > 0
        {
            for i in 0...subviewArray.count - 1
            {
                let pointx = inPoint.x
                let pointy = inPoint.y
                
                let xLow  = (Double(subviewArray[i].frame.minX) + locX)
                let xHigh = (Double(subviewArray[i].frame.maxX) + locX)
                
                let yLow  = (Double(subviewArray[i].frame.minY) + locY)
                let yHigh = (Double(subviewArray[i].frame.maxY) + locY)
                
                
                if isInRange(inPoint.x, val1: xLow, val2: xHigh) &&
                   isInRange(inPoint.y, val1: yLow, val2: yHigh) /*&&
                   (subviewArray[i].getSnapped() == false)*/
                {
                    //subviewArray[i].setSnapped(true)
                    return (true, i)
                }
            }
        }
        return (false, 0)
    }
    
    func isInRange(testVal: CGFloat, val1: Double, val2: Double) -> Bool
    {
        return Double(testVal) > val1 && Double(testVal) < val2
    }
    
    
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func mouseDown(theEvent: NSEvent)
    {
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
        //storeObject("GroupView", value: self)
    }
    
    override func mouseDragged(theEvent: NSEvent)
    {
        
        let clickX = theEvent.locationInWindow.x
        let clickY = theEvent.locationInWindow.y
        let offsetX = clickX - firstClick.x
        let offsetY = clickY - firstClick.y
        
        if !isMovable
        {
            isdragging = true
            self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, viewLength, viewHeight)
            locX = Double(offsetX + firstFrame.x)
            locY = Double(offsetY + firstFrame.y)
       
        }
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(self)
        userDefaults.setObject(encodedData, forKey: "Group1")
        userDefaults.synchronize()
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
        isdragging = false
        //storeObject("GroupView", value: self)
    }
    
    
    
    
}

class GroupSubview: NSView
{
    let viewLength: CGFloat = 50
    let viewHeight: CGFloat  = 50
    var isSnapped = false
    var student = Student()
    func startUp(x: CGFloat, y: CGFloat)
    {
        self.frame = CGRectMake(x, y, viewLength, viewHeight)
        self.setNeedsDisplayInRect(self.frame) //makes context exist
        
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, viewHeight)) //moveable label
        label.stringValue = "test"
        label.editable = false
        label.bezeled  = false
        label.drawsBackground = false
        label.selectable = false
        self.addSubview(label)
    }
    
    func setSnapped(inVal: Bool)
    {
        isSnapped = inVal
    }
    
    func getSnapped() -> Bool
    {
        return isSnapped
    }
    
    func setStudent(dastudent: Student)
    {
        student = dastudent
    }
    
    func getStudent() -> Student
    {
        return student
    }
    
    func getFrame() -> CGRect
    {
        return self.frame
    }
    
    override func drawRect(dirtyRect: NSRect)
    {
        super.drawRect(dirtyRect)
        
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
        
    }
}














