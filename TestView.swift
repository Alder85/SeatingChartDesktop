//
//  StudentView.swift
//

import Cocoa
import Foundation
import AppKit

class TestView: NSView {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        let panRecognizer = NSPanGestureRecognizer(target:self, action:"detectPan:")
        self.gestureRecognizers = [panRecognizer]
               // var label = NSTextField(frame: CGRectMake(0, 0, 400, 42))
        //label.alignment = NSTextAlignment.Center
       // label.stringValue = "testLabel"
        //self.addSubview(label)
        //self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.backgroundColor = NSColor.purpleColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func detectPan(recognizer:NSPanGestureRecognizer) {
        let translation =  recognizer.locationInView(self.superview!)
        Swift.print(translation)
        self.frame = CGRectMake(lastLocation.x + translation.x - 25, lastLocation.y + translation.y - 25, 50, 50)
    }

    override func touchesBeganWithEvent(event: NSEvent) {
        //self.superview?..bringSubviewToFront(self)
        lastLocation = self.center
        Swift.print("ll", lastLocation)
        super.touchesBeganWithEvent(event)
    }
}
