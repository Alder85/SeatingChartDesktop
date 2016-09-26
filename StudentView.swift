//
//  StudentView.swift
//

import Cocoa
import Foundation
import AppKit


class StudentView: NSView  {
    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
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
    var updateTimer = Timer()
    var student = Student()
    var studentLocations: [String] = retrieveStringArray("StudentLoc")
    var arrayIndexes: [Int] = []
    var frameArray: [CGFloat] = [0.0, 0.0, 0.0, 0.0]
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("StudentViews")
    
    struct PropertyKey {
        static let frameKey = "frame"
        static let studentKey = "student"
    }
    
    init(inRect: CGRect, inStudent: Student)
    {
        super.init(frame: inRect)
        delay(0.3)
        {
            //Swift.print(self.superview?.subviews)
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
 
        let label = NSTextField(frame: CGRect(x: 0, y: 0, width: viewLength, height: viewHeight))
        
        if student.namesOfInformationArray.count > 0
        {
            for x in 0...student.namesOfInformationArray.count - 1
            {
                if student.namesOfInformationArray[x] == "Name"
                {
                    label.stringValue = student.getInformation()[x]
                    break
                }
            }
        }
        
        //Swift.print(label.stringValue)
        
        var firstnamelength = 0
        var lastnamelength = 0
        
        if(label.stringValue.characters.count > 0)
        {
            var firstname = ""
            var lastname = ""
            var afterfirst = false
            for character in label.stringValue.characters
            {
                if afterfirst
                {
                    lastname += String(character)
                }
                else
                {
                    if character == " "
                    {
                        afterfirst = true
                    }
                    else
                    {
                        firstname += String(character)
                    }
                }
            }
            firstnamelength = firstname.characters.count
            lastnamelength = lastname.characters.count
            label.stringValue = firstname + "\n" + lastname
        }
        
        
        
        //label.stringValue = student.getInformation()[0]
        label.isEditable = false
        label.isBezeled = false
        label.drawsBackground = false
        label.alignment = NSTextAlignment.center
        
        var fontsize: CGFloat = 10
        
        if firstnamelength > 8 || lastnamelength > 8
        {
            if firstnamelength > 9 || lastnamelength > 9
            {
                fontsize -= 2
            }
            else
            {
                fontsize -= 1
            }
        }
        
        label.font = NSFont(descriptor: NSFontDescriptor(name: "Arial-BoldItalicMT", size: 10), size: fontsize)
        
        
        //button.titleLabel?.adjustsFontSizeToFitWidth
        
        self.addSubview(label)
        self.frame = inRect
        self.setNeedsDisplay(self.frame) //makes context exist
        self.backgroundColor = NSColor.cyan
        updateFrameArray()
        //label.backgroundColor = NSColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48() * 2), alpha: 1.0)//NSColor.purpleColor()
        //self.backgroundColor = NSColor.redColor()
        //updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "updateLocation:", userInfo: nil, repeats: true)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.frameArray, forKey: PropertyKey.frameKey)
        aCoder.encode(self.student, forKey: PropertyKey.studentKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let frameArray = aDecoder.decodeObject(forKey: PropertyKey.frameKey) as! [CGFloat]
        
        let student = aDecoder.decodeObject(forKey: PropertyKey.studentKey) as! Student
        
        // Must call designated initializer.
        self.init(inRect: CGRect(x: frameArray[0], y: frameArray[1], width: frameArray[2], height: frameArray[3]), inStudent: student)
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        
        //NSColor.purpleColor().setFill()
        //NSRectFill(dirtyRect)
        //super.drawRect(dirtyRect)
    }
    
    override func mouseEntered(with theEvent: NSEvent) {
        super.mouseEntered(with: theEvent)
        //Swift.print("potatoe")
        rightMouseDown(with: theEvent)
    }
    
    override func acceptsFirstMouse(for theEvent: NSEvent?) -> Bool {
        return true
    }
    
    override func mouseDown(with theEvent: NSEvent)
    {
        //Swift.print(self.superview!.subviews)
        //Swift.print("Mouse Down S")
        
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
        
        clickX = firstClick.x
        clickY = firstClick.y
        
        checkForRemovingStudentFromSeat()
    }
    
    override func rightMouseDown(with theEvent : NSEvent) {
        let theMenu = NSMenu(title: "Contextual menu")
        //theMenu.addItemWithTitle("Name: " + student.getName(), action: Selector(), keyEquivalent: "")
        //theMenu.addItemWithTitle("Chair #" + String(student.getChair()), action: Selector("action2:"), keyEquivalent: "")
        //theMenu.addItemWithTitle(String(student.getInstrument()), action: Selector("action2:"), keyEquivalent: "")
        
        if student.getInformation().count > 0
        {
            for x in 0...student.getInformation().count - 1
            {
                if student.getInformation()[x] != ""
                {
                    theMenu.addItem(withTitle: student.namesOfInformationArray[x] + " - " + student.getInformation()[x], action: Selector("action2:"), keyEquivalent: "")
                }
            }
        }
        
        theMenu.addItem(withTitle: "terminate", action: #selector(StudentView.remove(_:)), keyEquivalent: "")
        
        for item: AnyObject in theMenu.items {
            if let menuItem = item as? NSMenuItem {
                menuItem.target = self
            }
        }
        
        NSMenu.popUpContextMenu(theMenu, with: theEvent, for: self)
    }
    func remove(_ sender: AnyObject?)
    {
        self.removeFromSuperview()
    }
    
    func setLocation(_ xpoint: CGFloat, ypoint: CGFloat)
    {
        self.frame = CGRect(x: xpoint, y: ypoint, width: viewLength, height: viewHeight)
    }
    
    override func mouseDragged(with theEvent: NSEvent)
    {
        //Swift.print("Mouse Drag S")
        //groups = GroupView(inView: self.superview!.subviews[0])
        //Swift.print(self.superview!.subviews)
        
        checkForGroupViews()
        
        clickX = theEvent.locationInWindow.x
        clickY = theEvent.locationInWindow.y
        //Swift.print(clickX)
        //Swift.print(clickY)
        offsetX = clickX - firstClick.x
        offsetY = clickY - firstClick.y
        
        self.frame = edgeCheck(CGRect(x: offsetX + firstFrame.x, y: offsetY + firstFrame.y, width: viewLength, height: viewHeight))
        updateFrameArray()
    }
    override func mouseUp(with theEvent: NSEvent) {
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
                        if currentSubview.subviewArray[x][y].isInside(CGPoint(x: clickX, y: clickY))
                        {
                            currentSubview.subviewArray[x][y].setStudentView(StudentView(inRect: CGRect(x: 0, y: 0, width: 0, height: 0), inStudent: Student(inName: "", inChair: 12, inInstrument: "")))
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
                        if currentSubview.subviewArray[x][y].isInside(CGPoint(x: self.frame.midX, y: self.frame.midY))
                        {
                            if let _ = currentSubview.subviewArray[x][y].studentview
                            {
                                if currentSubview.subviewArray[x][y].studentview?.student.getName() == ""
                                {
                                    let i = currentSubview.subviewArray[x][y].frame.minX + currentSubview.frame.minX
                                    let h = currentSubview.subviewArray[x][y].frame.minY + currentSubview.frame.minY
                                    currentSubview.subviewArray[x][y].setStudentView(self)
                                    self.frame = CGRect(x: i, y: h, width: viewLength, height: viewHeight)
                                    break
                                }
                            }
                            else
                            {
                                let i = currentSubview.subviewArray[x][y].frame.minX + currentSubview.frame.minX
                                let h = currentSubview.subviewArray[x][y].frame.minY + currentSubview.frame.minY
                                currentSubview.subviewArray[x][y].setStudentView(self)
                                self.frame = CGRect(x: i, y: h, width: viewLength, height: viewHeight)
                                break
                            }
                        }
                    }
                }
            }
        }
        updateFrameArray()
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
