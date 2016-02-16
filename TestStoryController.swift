//
//  TestStoryController.swift
//  DriveSample
//
//  Created by WENDOLEK, CONNOR on 1/20/16.
//
//


import Cocoa

class TestStoryController: NSViewController {
    //potatoepotatoe
    var classList: [Class] = [Class.init(inArray: [Student.init()], name: "potatoes"), Class.init(inArray: [Student.init()], name: "potatoes2")]
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let temp = StudentView()
        temp.frame = CGRectMake(0,0,200,200)
        let textField = NSTextField(frame: CGRectMake(0,0,100,100))
        textField.stringValue = "test"
        textField.editable = false
        //temp.addSubview(textField)
        temp.startUp()
        self.view.addSubview(temp)
    }
    

    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    

    
    
}

