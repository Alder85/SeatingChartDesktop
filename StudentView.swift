//
//  StudentView.swift
//

import Cocoa
import Foundation
import AppKit

class StudentView: NSView {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    //var center: CGPoint
    var acceptsFirstResponer = true
    var acceptsFirstMouse = true
    let viewLength: CGFloat = 100
    let viewHeight: CGFloat  = 100
    var firstClick = CGPoint()
    var firstFrame = CGPoint()
    
    func startUp() {
        let label = NSTextField(frame: CGRectMake(0, 0, viewLength, viewHeight))
        label.stringValue = "potatoes"
        label.editable = false
        //label.= NSTextAlignment.Center
        self.addSubview(label)
        label.backgroundColor = NSColor.purpleColor()
        //self.layer?.backgroundColor = NSColor.purpleColor().CGColor
        //self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        //self.layer!.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 0.9)
        
    }
    
    override func acceptsFirstMouse(theEvent: NSEvent?) -> Bool {
        return true
    }
 
    
    private func center() -> CGPoint
    {
        return CGPointMake((self.frame.origin.x + (self.frame.size.width / 2)),
            (self.frame.origin.y + (self.frame.size.height / 2)))
    }
    
    /*
    func detectPan(recognizer:NSPanGestureRecognizer) {
        //lastLocation = CGPoint(x: self.frame.minX, y: self.frame.minY)
        let translation  = recognizer.translationInView(self.superview!)
        //self.frame = CGRectMake(lastLocation.x + translation.x + 500, lastLocation.y + translation.y - 25, 50, 50)
        self.frame = CGRectMake(lastLocation.x, , 50, 50)
    }
*/

    /*
    NSView* superview = [view superview];
    [view removeFromSuperview];
    [superview addSubview:view];
    - (void)touchesBeganWithEvent:(NSEvent *)event;
*/
    /*
    override func mouseDown(theEvent: NSEvent) {
       // self.superview?.bringSubviewToFront(self)
       // self.removeFromSuperview()
       // self.superview?.addSubview(self)
        lastLocation = CGPoint(x: self.frame.maxX, y: self.frame.minY)
        Swift.print(String(self.frame.minX) + " " + String(self.frame.maxX))
    }
*/
    
    override func mouseDown(theEvent: NSEvent)
    {
       // Swift.print("Mouse was clicked")
        firstClick = theEvent.locationInWindow
        firstFrame = CGPoint(x: self.frame.minX, y: self.frame.minY)
    }
    
    override func mouseDragged(theEvent: NSEvent)
    {
        //Swift.print("Mouse is dragging")
        let clickX = theEvent.locationInWindow.x
        let clickY = theEvent.locationInWindow.y
        let offsetX = clickX - firstClick.x
        let offsetY = clickY - firstClick.y

        self.frame = CGRectMake(offsetX + firstFrame.x, offsetY + firstFrame.y, viewLength, viewHeight)
    }
    
    override func mouseUp(theEvent: NSEvent)
    {
       // Swift.print("Mouse was let go")
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        //Swift.print("mouse entered")
    }
    
    override func hitTest(aPoint: NSPoint) -> NSView? {
       // Swift.print("hitTest")
       // Swift.print(String(self.frame.minX) + " " + String(self.frame.maxX))
        return self
    }
    
    
    
}
