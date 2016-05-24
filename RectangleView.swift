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

    //let viewLength: CGFloat = 300
    //let viewHeight: CGFloat  = 100
    var numberOfSubviews: Int = 0
    var position: CGFloat = 0
    let moveButton = NSButton(frame: CGRectMake(2,2,10,10))
    var locX = 50.0
    var locY = 100.0
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("RectangleViews")
    
    struct PropertyKey {
        static let frameKey = "frame"
        static let numberOfSubviewsKey = "numberOfSubviews"
    }
    
    convenience init(inView: NSView)
    {
        self.init(inRect: inView.frame, subviews: 1)
    }
    
    init(inRect: CGRect, subviews: Int)
    {
        super.init(inFrame: inRect)
        numberOfSubviews = subviews
        subviewArray.append([])
        for _ in 0...numberOfSubviews - 1
        {
            
            let temp = GroupSubview(inRect: CGRectMake(position, (frameRect.height / 2) - 25, 50, 50))
            //temp.startUp(position, y: (viewHeight / 2) - 25)
            subviewArray[0].append(temp)
            self.addSubview(subviewArray[0][subviewArray[0].count - 1])
            position = position + 60
            
        }
        self.setNeedsDisplayInRect(self.frame) //makes context exist
        self.frame = inRect
        //self.frame = CGRectMake(50, 100, viewLength, viewHeight)
        
        
        let label = NSTextField(frame: CGRectMake(0, 0, frameRect.width, 17)) //moveable label
        label.stringValue = "   Moveable"
        label.editable = false
        label.bezeled  = false
        label.drawsBackground = false
        label.selectable = false
        self.addSubview(label)
        
        let moveButton = NSButton(frame: CGRectMake(2,2,10,10))
        moveButton.setButtonType(NSButtonType.SwitchButton) //moveable checkbox
        moveButton.action = "toggleEditable:"
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
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.033, target: self, selector: "redraw:", userInfo: nil, repeats: true)
    }
    
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.frameArray, forKey: PropertyKey.frameKey)
        aCoder.encodeObject(self.numberOfSubviews, forKey: PropertyKey.numberOfSubviewsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let frameArray = aDecoder.decodeObjectForKey(PropertyKey.frameKey) as! [CGFloat]
        
        let numberOfSubviews = aDecoder.decodeObjectForKey(PropertyKey.numberOfSubviewsKey) as! Int
        
        // Must call designated initializer.
        self.init(inRect: CGRectMake(frameArray[0], frameArray[1], frameArray[2], frameArray[3]), subviews: numberOfSubviews)
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
        let temp = GroupSubview(inRect: CGRectMake(position, (frameRect.height / 2) - 25, 50, 50))
        subviewArray[0].append(temp)
        self.addSubview(temp)
        position = position + 60
        numberOfSubviews++
    }
    
    func removeView(obj:AnyObject?) {
        if subviewArray[0].count > 1
        {
            subviewArray[0][subviewArray[0].count - 1].removeFromSuperview()
            subviewArray[0].removeAtIndex(subviewArray[0].count - 1)
            position = position - 60
            numberOfSubviews--
        }
    }
    
    override func rightMouseDown(theEvent : NSEvent) {
        let theMenu = NSMenu(title: "Contextual menu")
        theMenu.addItemWithTitle("Remove View", action: Selector("remove:"), keyEquivalent: "")
        
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


}