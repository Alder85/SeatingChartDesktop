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
    let moveButton = NSButton(frame: CGRect(x: 2,y: 2,width: 10,height: 10))
    var locX = 50.0
    var locY = 100.0
    
    /*static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).last!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("RectangleViews")*/
    
    static let CoreDirectory = FileManager().urls(for: .desktopDirectory, in: .userDomainMask).first!
    
    static let ArchiveTwo = CoreDirectory.appendingPathComponent("/SeatingChartInfo/RectangleViews")
    
    struct PropertyKey {
        static let frameKey = "frame"
        static let numberOfSubviewsKey = "numberOfSubviews"
        static let allArrayKey = "allArray"
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
            
            let temp = GroupSubview(inRect: CGRect(x: position, y: (frameRect.height / 2) - 25, width: 50, height: 50))
            //temp.startUp(position, y: (viewHeight / 2) - 25)
            subviewArray[0].append(temp)
            self.addSubview(subviewArray[0][subviewArray[0].count - 1])
            position = position + 60
            
        }
        self.setNeedsDisplay(self.frame) //makes context exist
        self.frame = inRect
        //self.frame = CGRectMake(50, 100, viewLength, viewHeight)
        
        
        let label = NSTextField(frame: CGRect(x: 0, y: 0, width: frameRect.width, height: 17)) //moveable label
        label.stringValue = "   Moveable"
        label.isEditable = false
        label.isBezeled  = false
        label.drawsBackground = false
        label.isSelectable = false
        self.addSubview(label)
        
        let moveButton = NSButton(frame: CGRect(x: 2,y: 2,width: 10,height: 10))
        moveButton.setButtonType(NSButtonType.switch) //moveable checkbox
        moveButton.action = "toggleEditable:"
        moveButton.target = self
        self.addSubview(moveButton)
        
        let removeViewButton = NSButton(frame: CGRect(x: 163,y: 2,width: 15,height: 15)) //remove views
        removeViewButton.title = "-"
        removeViewButton.action = #selector(RectangleView.removeView(_:))
        removeViewButton.target = self
        self.addSubview(removeViewButton)
        
        let addViewButton = NSButton(frame: CGRect(x: 180,y: 2,width: 15,height: 15)) //add views
        addViewButton.title = "+"
        addViewButton.action = #selector(RectangleView.addView(_:))
        addViewButton.target = self
        self.addSubview(addViewButton)
        
        //change the time value if this gets laggy
        updateTimer = Timer.scheduledTimer(timeInterval: 0.033, target: self, selector: "redraw:", userInfo: nil, repeats: true)
    }
    
    
    override func encode(with aCoder: NSCoder) {
        //aCoder.encode(self.frameArray, forKey: PropertyKey.frameKey)
        //aCoder.encode(self.numberOfSubviews, forKey: PropertyKey.numberOfSubviewsKey)
        
        let allArray: Any? = [frameArray, numberOfSubviews]
        aCoder.encode(allArray, forKey: PropertyKey.allArrayKey)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let allArray = aDecoder.decodeObject(forKey: PropertyKey.allArrayKey)
        let potatoe = allArray as! NSArray
        
        let frameArray = potatoe[0] as! [CGFloat]
        let numberOfSubviews = potatoe[1] as! Int
        
        // Must call designated initializer.
        self.init(inRect: CGRect(x: frameArray[0], y: frameArray[1], width: frameArray[2], height: frameArray[3]), subviews: numberOfSubviews)
    }
    
    override func draw(_ dirtyRect: NSRect)
    {
        super.draw(dirtyRect)
        
        let bPath:NSBezierPath = NSBezierPath(rect: dirtyRect)
        
        let borderColor = NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        borderColor.set()
        bPath.stroke()
        
    }
    
    func addView(_ obj:AnyObject?) {
        let temp = GroupSubview(inRect: CGRect(x: position, y: (frameRect.height / 2) - 25, width: 50, height: 50))
        subviewArray[0].append(temp)
        self.addSubview(temp)
        position = position + 60
        numberOfSubviews += 1
    }
    
    func removeView(_ obj:AnyObject?) {
        if subviewArray[0].count > 1
        {
            subviewArray[0][subviewArray[0].count - 1].removeFromSuperview()
            subviewArray[0].remove(at: subviewArray[0].count - 1)
            position = position - 60
            numberOfSubviews -= 1
        }
    }
    
    override func rightMouseDown(with theEvent : NSEvent) {
        let theMenu = NSMenu(title: "Contextual menu")
        theMenu.addItem(withTitle: "Remove View", action: #selector(RectangleView.remove(_:)), keyEquivalent: "")
        
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


}
