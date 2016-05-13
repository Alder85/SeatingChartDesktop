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
    
    override func viewDidLoad() {
        
        let tempG = RectangleView(inRect: CGRectMake(800, 500, 300, 100), subviews: 1)
        self.view.addSubview(tempG)
        
        //temp2.frame = CGRectMake(0,0,100,100)
        super.viewDidLoad()
        //temp.frame = CGRectMake(0,0,200,200)
        let textField = NSTextField(frame: CGRectMake(0,0,100,100))
        textField.stringValue = "test"
        textField.editable = false
        //temp.addSubview(textField)
        //let tempStudent = Student(inName: "Joe", inChair: 12, inInstrument: "Trombone")
        //let temp = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent, groupIn: tempG)
        
        let potatoe = CurveView(size: 500, isLeft: false, rows: 3, length: 70)
        self.view.addSubview(potatoe)
        let potatoe2 = CurveView(size: 500, isLeft: true, rows: 3, length: 70)
        self.view.addSubview(potatoe2)

        //let potatoe = TestView(frame: CGRectMake(0, 0, 50, 50))
        //self.view.addSubview(potatoe)
        
        /*
        //temp1.frame = CGRectMake(0,0,200,200)
        let tempStudent1 = Student(inName: "Frederick", inChair: 12, inInstrument: "Trombone")
        let temp1 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent1)
        
        let tempStudent2 = Student(inName: "Connor", inChair: 12, inInstrument: "Trombone")
        let temp2 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent2)
        
        let tempStudent3 = Student(inName: "Josh", inChair: 12, inInstrument: "Trombone")
        let temp3 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent3)
        
        let tempStudent4 = Student(inName: "Trevon", inChair: 12, inInstrument: "Trombone")
        let temp4 = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent4)
        
        
        self.view.addSubview(temp1)
        self.view.addSubview(temp2)
        self.view.addSubview(temp3)
        self.view.addSubview(temp4)
        */
        
        let csv: CSV
        
        do
        {
            try csv = CSV(input: loadCSV())
            let studentArray: [Student] = dataToStudentArray(csv.dataArray)
            for x in 0...studentArray.count - 1
            {
                let temp = StudentView(inRect: CGRectMake(CGFloat(arc4random_uniform(500)), CGFloat(arc4random_uniform(500)), 50, 50), inStudent: studentArray[x])
                self.view.addSubview(temp)
            }
        }
        catch
        {
            Swift.print("failed")
        }

        
        /*        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(temp2)
        userDefaults.setObject(encodedData, forKey: "Group1")
        userDefaults.synchronize()*/

    }
    
    func loadCSV() throws -> String
    {
        let contents = try String(contentsOfFile: "/Users/735582/Desktop/ClassList.csv", encoding: NSUTF8StringEncoding)
        Swift.print(contents)
        return contents
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
    
    
    
}

