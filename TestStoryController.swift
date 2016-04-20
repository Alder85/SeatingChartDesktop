//
//  TestStoryController.swift
//  DriveSample
//
//  Created by WENDOLEK, CONNOR on 1/20/16.
//
//


import Cocoa
import Darwin

class TestStoryController: NSViewController {
    //potatoepotatoe
    var classList: [Class] = [Class.init(inArray: [Student.init()], name: "potatoes"), Class.init(inArray: [Student.init()], name: "potatoes2")]
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let potatoe = CurveView(size: 550, isLeft: true, rows: 4, length: 80)
        self.view.addSubview(potatoe)
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

    }
    
    func loadCSV() throws -> String
    {
        let contents = try String(contentsOfFile: "/Users/735582/Desktop/MOCK_DATA.csv", encoding: NSUTF8StringEncoding)
        Swift.print(contents)
        return contents
    }

    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    

    
    
}

