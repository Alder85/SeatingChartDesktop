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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var csv = CSV(input: "Name,Instument,Chair\nJosh,Percussion,420\nConnor,None,3\n")
        var temp = csv.getDataArray()
        print(temp)
        var temp2 = dataToStudentArray(temp)
        print(temp2)
        

    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var fileSelectedIndicator: NSTextField!
    
}

