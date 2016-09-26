//
//  StudentView.swift
//

import Cocoa
import Foundation
import AppKit

class TestView: NSView {
    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        let panRecognizer = NSPanGestureRecognizer(target:self, action:#selector(TestView.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
               // var label = NSTextField(frame: CGRectMake(0, 0, 400, 42))
        //label.alignment = NSTextAlignment.Center
       // label.stringValue = "testLabel"
        //self.addSubview(label)
        //self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.backgroundColor = NSColor.purple
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func detectPan(_ recognizer:NSPanGestureRecognizer) {
        let translation =  recognizer.location(in: self.superview!)
        Swift.print(translation)
        self.frame = CGRect(x: lastLocation.x + translation.x - 25, y: lastLocation.y + translation.y - 25, width: 50, height: 50)
    }

    override func touchesBegan(with event: NSEvent) {
        //self.superview?..bringSubviewToFront(self)
        lastLocation = self.center
        Swift.print("ll", lastLocation)
        super.touchesBegan(with: event)
    }
}
