//
//  StudentView.swift
//

import Cocoa
import Foundation
import AppKit


class StudentView: NSView {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    var acceptsFirstResponer = true
    var acceptsFirstMouse = true
    let viewLength: CGFloat = 50
    let viewHeight: CGFloat = 50
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    var clickX: CGFloat = 0
    var clickY: CGFloat = 0
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var updateTimer = NSTimer()
    var student = Student()
    var studentLocations: [String] = retrieveStringArray("StudentLoc")
    var arrayIndexes: [Int] = []
    
    init(inRect: CGRect, inStudent: Student)
    {
        super.init(frame: inRect)
        delay(0.3)
        {
            Swift.print(self.superview?.subviews)
            if self.superview?.subviews != nil
            {
                for i in 0...Int((self.superview?.subviews.count)!) - 1
                {
                    if self.superview?.subviews[i] is GroupView
                    {
                        self.arrayIndexes.append(i)
                    }
                }
            }
        }
        
        student = inStudent
 
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, viewHeight))
        
        label.stringValue = student.getName()
        label.editable = false
        label.bezeled = false
        label.drawsBackground = false
        label.alignment = NSTextAlignment.Center
        
        label.font = NSFont(descriptor: NSFontDescriptor(name: "Arial-BoldItalicMT", size: 10), size: 10)
        
        self.addSubview(label)
        self.frame = inRect
        self.setNeedsDisplayInRect(self.frame) //makes context exist
        self.backgroundColor = NSColor.lightGrayColor()
        //updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "updateLocation:", userInfo: nil, repeats: true)
    }
    
    override func drawRect(dirtyRect: NSRect)
    {
        
        //NSColor.purpleColor().setFill()
        //NSRectFill(dirtyRect)
        //super.drawRect(dirtyRect)
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        super.mouseEntered(theEvent)
        Swift.print("potatoe")
        rightMouseDown(theEvent)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func mouseDown(theEvent: NSEvent)
    {
        //Swift.print(self.superview!.subviews)
        Swift.print("Mouse Down S")
        
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
        
        clickX = firstClick.x
        clickY = firstClick.y
        
        checkForRemovingStudentFromSeat()
    }
    
    override func rightMouseDown(theEvent : NSEvent) {
        let theMenu = NSMenu(title: "Contextual menu")
        theMenu.addItemWithTitle("Name: " + student.getName(), action: Selector("action1:"), keyEquivalent: "")
        theMenu.addItemWithTitle("Chair #" + String(student.getChair()), action: Selector("action2:"), keyEquivalent: "")
        theMenu.addItemWithTitle(String(student.getInstrument()), action: Selector("action2:"), keyEquivalent: "")
        theMenu.addItemWithTitle("terminate", action: Selector("remove:"), keyEquivalent: "")
        
        for item: AnyObject in theMenu.itemArray {
            if let menuItem = item as? NSMenuItem {
                menuItem.target = self
            }
        }
        
        NSMenu.popUpContextMenu(theMenu, withEvent: theEvent, forView: self)
    }
    func remove(sender: AnyObject?)
    {
        self.removeFromSuperview()
    }
    
    func setLocation(xpoint: CGFloat, ypoint: CGFloat)
    {
        self.frame = CGRectMake(xpoint, ypoint, viewLength, viewHeight)
    }
    
    override func mouseDragged(theEvent: NSEvent)
    {
        Swift.print("Mouse Drag S")
        //groups = GroupView(inView: self.superview!.subviews[0])
        //Swift.print(self.superview!.subviews)
        
        checkForGroupViews()
        
        clickX = theEvent.locationInWindow.x
        clickY = theEvent.locationInWindow.y
        Swift.print(clickX)
        Swift.print(clickY)
        offsetX = clickX - firstClick.x
        offsetY = clickY - firstClick.y
        
        self.frame = edgeCheck(CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, viewLength, viewHeight))
    }
    override func mouseUp(theEvent: NSEvent) {
        snap()
    }
    
    func checkForRemovingStudentFromSeat()
    {
        if arrayIndexes.count > 0
        {
            for h in 0...arrayIndexes.count - 1
            {
                let currentSubview = self.superview!.subviews[arrayIndexes[h]] as! GroupView
                for x in 0...currentSubview.subviewArray.count - 1
                {
                    for y in 0...currentSubview.subviewArray[x].count - 1
                    {
                        if currentSubview.subviewArray[x][y].isInside(CGPointMake(clickX, clickY))
                        {
                            currentSubview.subviewArray[x][y].setStudentView(StudentView(inRect: CGRectMake(0, 0, 0, 0), inStudent: Student(inName: "", inChair: 12, inInstrument: "")))
                            break
                        }
                    }
                }
            }
        }
    }
    
    func checkForGroupViews()
    {
        arrayIndexes = []
        if self.superview?.subviews != nil
        {
            for i in 0...Int((self.superview?.subviews.count)!) - 1
            {
                if self.superview?.subviews[i] is GroupView
                {
                    self.arrayIndexes.append(i)
                }
            }
        }
    }
    
    func snap()
    {
        if arrayIndexes.count > 0
        {
            for h in 0...arrayIndexes.count - 1
            {
                let currentSubview = self.superview!.subviews[arrayIndexes[h]] as! GroupView
                for x in 0...currentSubview.subviewArray.count - 1
                {
                    for y in 0...currentSubview.subviewArray[x].count - 1
                    {
                        if currentSubview.subviewArray[x][y].isInside(CGPointMake(self.frame.midX, self.frame.midY))
                        {
                            if let _ = currentSubview.subviewArray[x][y].studentview
                            {
                                if currentSubview.subviewArray[x][y].studentview?.student.getName() == ""
                                {
                                    let i = currentSubview.subviewArray[x][y].frame.minX + currentSubview.frame.minX
                                    let h = currentSubview.subviewArray[x][y].frame.minY + currentSubview.frame.minY
                                    currentSubview.subviewArray[x][y].setStudentView(self)
                                    self.frame = CGRectMake(i, h, viewLength, viewHeight)
                                    break
                                }
                            }
                            else
                            {
                                let i = currentSubview.subviewArray[x][y].frame.minX + currentSubview.frame.minX
                                let h = currentSubview.subviewArray[x][y].frame.minY + currentSubview.frame.minY
                                currentSubview.subviewArray[x][y].setStudentView(self)
                                self.frame = CGRectMake(i, h, viewLength, viewHeight)
                                break
                            }
                        }
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
}