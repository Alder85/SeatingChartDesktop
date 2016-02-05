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
        // Do any additional setup after loading the view, typically from a nib.
        //classList = retrieveObjectArray("classList") as! [Class]
        for x in 0...classList.count - 1
        {
            fileListButton.addItemWithTitle(classList[x].getName())
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    @IBOutlet weak var fileListButton: NSPopUpButton!
    @IBOutlet weak var fileSelectedIndicator: NSTextField!
    
    
}

