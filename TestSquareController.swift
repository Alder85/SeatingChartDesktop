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
    var groupcoords: [Double] = retrieveDoubleArray("GroupC")
    var subviewsfilled: [Bool] = retrieveBoolArray("Subfilled")
    
    /*
     0 - minX
     1 - minY
     2 - maxX
     3 - maxY
    */
    var subcoords: [[Double]] = retrieveObjectArray("Subcoords") as! [[Double]]
    
    //var temp2 = GroupView(subviewIn: [], rect: CGRectMake(0,0,100,100))
    
    
    
    
    
    
    
    override func viewDidLoad() {
        if spotsfilled.count == 0
        {
            let spotfilled = [Bool](count:2, repeatedValue: false)
            storeBoolArray("Spots", valArray: spotfilled)
        }
        
        if subviewsfilled.count == 0
        {
            subviewsfilled = [Bool](count: 5, repeatedValue: false)
            subviewsfilled[0] = true
            storeBoolArray("Subfilled", valArray: subviewsfilled)
        }
        
        if groupcoords.count == 0
        {
            groupcoords = [Double](count: 4, repeatedValue: 0.0)
            storeDoubleArray("GroupC", valArray: groupcoords)
        }
        
        if subcoords.count == 0
        {
            subcoords = [[Double]](count: 5, repeatedValue: [Double](count: 4, repeatedValue: 0.0))
            storeObjectArray("Subcoords", valArray: subcoords) //as! [[Double]]
        }
        let temp2 = GroupView()
        //temp2.frame = CGRectMake(0,0,100,100)
        temp2.startUp(1)
        //spotsfilled[0] = false
        //spotsfilled[1] = false
        storeBoolArray("Spots", valArray: spotsfilled)
        super.viewDidLoad()
        let temp = StudentView()
        temp.frame = CGRectMake(0,0,200,200)
        let textField = NSTextField(frame: CGRectMake(0,0,100,100))
        textField.stringValue = "test"
        textField.editable = false
        //temp.addSubview(textField)
        let tempStudent = Student(inName: "Joe", inChair: 12, inInstrument: "Trombone")
        temp.startUp(tempStudent, group: temp2)
        
        let temp1 = StudentView()
        temp1.frame = CGRectMake(0,0,200,200)
        let textField1 = NSTextField(frame: CGRectMake(0,0,100,100))
        textField1.stringValue = "test"
        textField1.editable = false
        //temp.addSubview(textField)
        let tempStudent1 = Student(inName: "Bob", inChair: 5, inInstrument: "Trumpet")
        temp1.startUp(tempStudent1, group: temp2)
       
        
        //let temp2 = GroupView()
        //temp2.frame = CGRectMake(0,0,100,100)
        //temp2.startUp(1)
        self.view.addSubview(temp2)
        
        self.view.addSubview(temp)
         self.view.addSubview(temp1)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(temp2)
        userDefaults.setObject(encodedData, forKey: "Group1")
        userDefaults.synchronize()

    }
    
    
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    
    
}

