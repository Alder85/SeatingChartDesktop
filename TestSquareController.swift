//
//  TestSquareController.swift
//  DriveSample
//
//  Created by WENDOLEK, CONNOR on 2/17/16.
//
//

import Cocoa

class TestSquareController: NSViewController {
    //potatoepotatoe
    var classList: [Class] = [Class.init(inArray: [Student.init()], name: "potatoes"), Class.init(inArray: [Student.init()], name: "potatoes2")]
    
    var spotsfilled: [Bool] = retrieveBoolArray("Spots")
    
    
    
    
    
    override func viewDidLoad() {
        if spotsfilled.count == 0
        {
            let spotfilled = [Bool](count:2, repeatedValue: false)
            storeBoolArray("Spots", valArray: spotfilled)
        }
       // spotsfilled[0] = false
        //spotsfilled[1] = false
        storeBoolArray("Spots", valArray: spotsfilled)
        super.viewDidLoad()
        let temp = StudentView()
        temp.frame = CGRectMake(0,0,200,200)
        let textField = NSTextField(frame: CGRectMake(0,0,100,100))
        textField.stringValue = "test"
        textField.editable = false
        //temp.addSubview(textField)
        temp.startUp()
        self.view.addSubview(temp)
        
        let temp1 = StudentView()
        temp1.frame = CGRectMake(0,0,100,100)
        let textField1 = NSTextField(frame: CGRectMake(0,0,50,50))
        textField1.stringValue = "test"
        textField1.editable = false
        //temp.addSubview(textField)
        temp1.startUp()
        self.view.addSubview(temp1)
    }
    
    
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    
    
}

