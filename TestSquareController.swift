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
    //var classList: [Class] = [Class.init(inArray: [Student.init()], name: "potatoes"), Class.init(inArray: [Student.init()], name: "potatoes2")]
    
    var studentViewArray: [StudentView] = []
    var curveViewArray: [CurveView] = []
    var rectangleViewArray: [RectangleView] = []
    var firstsnap = false
    
    
    
    

    
    
    override func viewDidLoad() {
        
        /*let tempG = RectangleView(inRect: CGRectMake(800, 500, 300, 100), subviews: 1)
        self.view.addSubview(tempG)
        /*
        //temp2.frame = CGRectMake(0,0,100,100)
        super.viewDidLoad()
        //temp.frame = CGRectMake(0,0,200,200)
        let textField = NSTextField(frame: CGRectMake(0,0,100,100))
        textField.stringValue = "test"
        textField.editable = false
        //temp.addSubview(textField)
        //let tempStudent = Student(inName: "Joe", inChair: 12, inInstrument: "Trombone")
        //let temp = StudentView(inRect: CGRectMake(0, 0, 50, 50), inStudent: tempStudent, groupIn: tempG)
        */


        let potatoe1 = CurveView(size: 500, isLeft: false, rows: 3, length: 70)
        curveViewArray.append(potatoe1)
        self.view.addSubview(potatoe1) */

        /*let potatoe = TestView(frame: CGRectMake(0, 0, 50, 50))
        rectangleViewArray.append(tempG)
        self.view.addSubview(potatoe)*/
        
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
        
        let csv: CSwiftV
        
        rectangleViewArray = (NSKeyedUnarchiver.unarchiveObjectWithFile(RectangleView.ArchiveURL.path!) as? [RectangleView])!
        
        for x in 0...rectangleViewArray.count - 1
        {
            let tempRect = CGRectMake(rectangleViewArray[x].frameArray[0], rectangleViewArray[x].frameArray[1], rectangleViewArray[x].frameArray[2], rectangleViewArray[x].frameArray[3])
            let temp = RectangleView(inRect: tempRect, subviews: rectangleViewArray[x].numberOfSubviews)
            self.view.addSubview(temp)
        }
        
        curveViewArray = (NSKeyedUnarchiver.unarchiveObjectWithFile(CurveView.ArchiveURL.path!) as? [CurveView])!
        
        for x in 0...curveViewArray.count - 1
        {
           let temp1 = curveViewArray[x]
           let temp = CurveView(size: Int(temp1.frameArray[2]), isLeft: temp1.leftRect, rows: CGFloat(temp1.subviewArray.count), length: temp1.rowLength, startX: temp1.frameArray[0], startY: temp1.frameArray[1], subArray: temp1.subviewArray)
          self.view.addSubview(temp)
        }
        
        studentViewArray = (NSKeyedUnarchiver.unarchiveObjectWithFile(StudentView.ArchiveURL.path!) as? [StudentView])!
        
        /*for x in 0...studentViewArray.count - 1
        {
            let temp = StudentView(inRect: CGRectMake(studentViewArray[x].frameArray[0], studentViewArray[x].frameArray[1], studentViewArray[x].viewHeight, studentViewArray[x].viewLength), inStudent: studentViewArray[x].student)
            self.view.addSubview(temp)
        }*/
        
        var studentsAlreadyCreated: [Int] = []

        do
        {
            try csv = CSwiftV(string: loadCSV())
            let studentArray: [Student] = dataToStudentArray(csv.rows)
            for b in 0...studentArray.count - 1
            {
                var isAdded = false
                if studentViewArray.count > 0
                {
                    for x in 0...studentViewArray.count - 1
                    {
                        if !isNumberInArrayInt(x, numArray: studentsAlreadyCreated)
                        {
                            let loadedStudent = studentViewArray[x].student as Student
                            if  loadedStudent.getName() == studentArray[b].getName() &&
                                loadedStudent.getInstrument() == studentArray[b].getInstrument()
                            {
                                let temp = StudentView(inRect: CGRectMake(studentViewArray[x].frameArray[0], studentViewArray[x].frameArray[1], studentViewArray[x].viewHeight, studentViewArray[x].viewLength), inStudent: Student(inArray: studentArray[b].getInformation()))
                                self.view.addSubview(temp)
                                isAdded = true
                                studentsAlreadyCreated.append(x)
                                break
                            }
                        }
                    }
                }
                if !isAdded
                {
                    let temp = StudentView(inRect: CGRectMake(CGFloat(0), CGFloat(0), 50, 50), inStudent: Student(inArray: studentArray[b].getInformation()))
                    self.view.addSubview(temp)
                }
            }
            /*for x in 0...studentViewArray.count - 1
            {
                let loadedStudent = studentViewArray[x].student as Student
                for b in 0...studentArray.count - 1
                {
                    if loadedStudent.getName() == studentArray[b].getName() &&
                       loadedStudent.getInstrument() == studentArray[b].getInstrument()
                    {
                        let temp = StudentView(inRect: CGRectMake(studentViewArray[x].frameArray[0], studentViewArray[x].frameArray[1], studentViewArray[x].viewHeight, studentViewArray[x].viewLength), inStudent: Student(inArray: studentArray[b].getInformation()))
                        self.view.addSubview(temp)
                    }
                }
            }*/
            /*for x in 0...studentArray.count - 1
            {
                let temp = StudentView(inRect: CGRectMake(CGFloat(arc4random_uniform(500)), CGFloat(arc4random_uniform(500)), 50, 50), inStudent: Student(inArray: studentArray[x].getInformation()))
                studentViewArray.append(temp)
                self.view.addSubview(temp)
            }*/
        }
        catch
        {
            Swift.print("failed")
        }
        
        snapAllStudentViews()
        
        var updateTimer = NSTimer()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "saveViews", userInfo: nil, repeats: true)

        
        /*        let userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(temp2)
        userDefaults.setObject(encodedData, forKey: "Group1")
        userDefaults.synchronize()*/

    }
    
    func loadCSV() throws -> String
    {
        let contents = try String(contentsOfFile: "/Users/732408/Desktop/ClassList.csv", encoding: NSUTF8StringEncoding)
        //Swift.print(contents)
        return contents
    }
    
    func saveViews()
    {
        studentViewArray = []
        curveViewArray = []
        rectangleViewArray = []
        
        for i in 0...Int(self.view.subviews.count) - 1
        {
            if self.view.subviews[i] is CurveView
            {
                let temp = self.view.subviews[i] as! CurveView
                curveViewArray.append(temp)
            }
            else if self.view.subviews[i] is RectangleView
            {
                let temp = self.view.subviews[i] as! RectangleView
                rectangleViewArray.append(temp)
            }
            else if self.view.subviews[i] is StudentView
            {
                let temp = self.view.subviews[i] as! StudentView
                studentViewArray.append(temp)
            }
        }
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(studentViewArray, toFile: StudentView.ArchiveURL.path!)
        if !isSuccessfulSave {
            Swift.print("Failed to save student views...")
        }
        else
        {
            //Swift.print("Succeded to save student views")
        }
        
        let isSuccessfulSave2 = NSKeyedArchiver.archiveRootObject(curveViewArray, toFile: CurveView.ArchiveURL.path!)
        if !isSuccessfulSave2 {
            Swift.print("Failed to save student views...")
        }
        else
        {
            ///Swift.print("Succeded to save curve views")
        }
        
        let isSuccessfulSave3 = NSKeyedArchiver.archiveRootObject(rectangleViewArray, toFile: RectangleView.ArchiveURL.path!)
        if !isSuccessfulSave3 {
            Swift.print("Failed to save student views...")
        }
        else
        {
            //Swift.print("Succeded to save rectangle views")
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func snapAllStudentViews()
    {
        for i in 0...Int(self.view.subviews.count) - 1
        {
            if self.view.subviews[i] is StudentView
            {
                (self.view.subviews[i] as! StudentView).checkForGroupViews()
                (self.view.subviews[i] as! StudentView).snap()
            }
        }
    }
    
    func isNumberInArrayInt(num: Int, numArray: [Int]) -> Bool
    {
        if numArray.count > 0
        {
            for x in 0...numArray.count - 1
            {
                if num == numArray[x]
                {
                    return true
                }
            }
            return false
        }
        else
        {
            return false
        }
    }
    
    
    
    
    
}

