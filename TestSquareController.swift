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
        
        loadRectangleViews(RectangleView.ArchiveURL.path!)
        
        loadCurveViews(CurveView.ArchiveURL.path!)
        
        loadStudentsWithCSV(StudentView.ArchiveURL.path!)
        
        snapAllStudentViews()
        
        var updateTimer = NSTimer()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "saveViews", userInfo: nil, repeats: true)

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
    
    func loadCurveViews(filename: String)
    {
        curveViewArray = (NSKeyedUnarchiver.unarchiveObjectWithFile(filename) as? [CurveView])!
        
        if curveViewArray.count > 0
        {
            for x in 0...curveViewArray.count - 1
            {
                let temp1 = curveViewArray[x]
                let temp = CurveView(size: Int(temp1.frameArray[2]), isLeft: temp1.leftRect, rows: CGFloat(temp1.subviewArray.count), length: temp1.rowLength, startX: temp1.frameArray[0], startY: temp1.frameArray[1], subArray: temp1.subviewArray)
                self.view.addSubview(temp)
            }
        }
    }
    
    func loadRectangleViews(filename: String)
    {
        rectangleViewArray = (NSKeyedUnarchiver.unarchiveObjectWithFile(filename) as? [RectangleView])!
        
        if rectangleViewArray.count > 0
        {
            for x in 0...rectangleViewArray.count - 1
            {
                let tempRect = CGRectMake(rectangleViewArray[x].frameArray[0], rectangleViewArray[x].frameArray[1], rectangleViewArray[x].frameArray[2], rectangleViewArray[x].frameArray[3])
                let temp = RectangleView(inRect: tempRect, subviews: rectangleViewArray[x].numberOfSubviews)
                self.view.addSubview(temp)
            }
        }
    }
    
    func loadStudentsWithCSV(filename: String)
    {
        studentViewArray = (NSKeyedUnarchiver.unarchiveObjectWithFile(filename) as? [StudentView])!
        
        let csv: CSwiftV
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
        }
        catch
        {
            Swift.print("failed")
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

