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
        let potatoe = CurveView(size: 500, isLeft: false, rows: 6, length: 50)
        self.view.addSubview(potatoe)
    }
    

    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    

    
    
}

