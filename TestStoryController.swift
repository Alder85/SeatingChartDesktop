//
//  TestStoryController.swift
//  DriveSample
//
//  Created by WENDOLEK, CONNOR on 1/20/16.
//
//


import Cocoa
import Darwin

var currentfilestudentviewsname = ""
var currentfilecurveviewsname = ""
var currentfilerectangleviewsname = ""

class TestStoryController: NSViewController {
    //potatoepotatoe
    var classList: [Class] = [Class.init(inArray: [Student.init()], name: "potatoes"), Class.init(inArray: [Student.init()], name: "potatoes2")]
    
    var listOfHours = retrieveObjectArray("List of Hours")
    
    @IBOutlet weak var potatoeFileSelector: NSPopUpButton!

    func assignFiles(sender: NSMenuItem)
    {
        currentfilestudentviewsname = sender.title
        currentfilecurveviewsname = sender.title
        currentfilerectangleviewsname = sender.title
        Swift.print(sender.title)
    }
    
    func addFile(sender: NSMenuItem)
    {
        currentfilestudentviewsname = sender.title
        currentfilecurveviewsname = sender.title
        currentfilerectangleviewsname = sender.title
        Swift.print(sender.title)
        listOfHours.append("File " + String(listOfHours.count + 1))
        storeObjectArray("List of Hours", valArray: listOfHours)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if listOfHours.count == 0
        {
            listOfHours.append("File 1")
        }
        /*let potatoeFile = NSMenuItem(title:  "File 1", action: #selector(self.assignFiles(_:)), keyEquivalent: " data")
        let potatoeFile2 = NSMenuItem(title:  "File 2", action: #selector(self.assignFiles(_:)), keyEquivalent: " data")
        let potatoeFile3 = NSMenuItem(title:  "File 3", action: #selector(self.assignFiles(_:)), keyEquivalent: " data")*/
        
        
        for x in 0...listOfHours.count
        {
            potatoeFileSelector.menu?.addItem( NSMenuItem(title:  "File " + String(x + 1), action: #selector(self.assignFiles(_:)), keyEquivalent: " data"))
        }
        
        potatoeFileSelector.menu?.addItem( NSMenuItem(title:  "Add New File", action: #selector(self.addFile(_:)), keyEquivalent: " data"))
        
        //potatoeFileSelector.menu?.addItem(potatoeFile)
        //potatoeFileSelector.menu?.addItem(potatoeFile2)
        //potatoeFileSelector.menu?.addItem(potatoeFile3)
        
        //let potatoe = CurveView(size: 550, isLeft: true, rows: 4, length: 80)
        //self.view.addSubview(potatoe)
        /*
        let tempStudent1 = Student(inName: "Frederick", inChair: 12, inInstrument: "Trombone")
        let temp1 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent1)
        
        let tempStudent2 = Student(inName: "Connor", inChair: 12, inInstrument: "Trombone")
        let temp2 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent2)
        
        let tempStudent3 = Student(inName: "Josh", inChair: 12, inInstrument: "Trombone")
        let temp3 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent3)
        
        let tempStudent4 = Student(inName: "Trevon", inChair: 12, inInstrument: "Trombone")
        let temp4 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent4)
        
        
        //self.view.addSubview(temp1)
       // self.view.addSubview(temp2)
       // self.view.addSubview(temp3)
       // self.view.addSubview(temp4)
*/
        
    }
    
    @IBAction func DaSegue(sender: AnyObject) {
        
    }

    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    

    
    
}

