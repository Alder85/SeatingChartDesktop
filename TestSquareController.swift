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
    
    @IBAction func addLeftCurveView(sender: AnyObject) {
        let tempLeftCurveView = CurveView(size: 500, isLeft: true, rows: 3, length: 70)
        //self.view.addSubview(tempLeftCurveView)
        self.view.addSubview(tempLeftCurveView, positioned: NSWindowOrderingMode.Below, relativeTo: self.view.subviews[16])
        updateAllStudentViewsGroups()
    }
    @IBAction func addRightCurveView(sender: AnyObject) {
        let tempRightCurveView = CurveView(size: 500, isLeft: false, rows: 3, length: 70)
        //self.view.addSubview(tempRightCurveView)
        self.view.addSubview(tempRightCurveView, positioned: NSWindowOrderingMode.Below, relativeTo: self.view.subviews[16])

        updateAllStudentViewsGroups()
    }
    @IBAction func addRectangleView(sender: AnyObject) {
        let tempG = RectangleView(inRect: CGRectMake(800, 500, 300, 100), subviews: 1)
        //self.view.addSubview(tempG)
        self.view.addSubview(tempG, positioned: NSWindowOrderingMode.Below, relativeTo: self.view.subviews[16])
        updateAllStudentViewsGroups()
    }
    
    var studentViewArray: [StudentView] = []
    var curveViewArray: [CurveView] = []
    var rectangleViewArray: [RectangleView] = []
    var firstsnap = false
    var studentViewFilename = StudentView.ArchiveURL.path!
    var curveViewFilename = CurveView.ArchiveURL.path!
    var rectangleViewFilename = RectangleView.ArchiveURL.path!
    
    override func viewDidLoad()
    {
        openFile()
        let _: CSwiftV
        
        loadRectangleViews(RectangleView.ArchiveURL.path!)
        
        loadCurveViews(CurveView.ArchiveURL.path!)
        
        loadStudentsWithCSV(StudentView.ArchiveURL.path!)
        
        snapAllStudentViews()
        
        var updateTimer = NSTimer()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "saveViewsWithTimer", userInfo: nil, repeats: true)

    }
    
    var fileLocation: String = "/Users/732408/Desktop/ClassList.csv"//""
    func openFile() {
        
        let myFileDialog: NSOpenPanel = NSOpenPanel()
        myFileDialog.runModal()
        
        // Get the path to the file chosen in the NSOpenPanel
        fileLocation = (myFileDialog.URL?.path)!
        Swift.print(fileLocation)
    }
    
    func loadCSV() throws -> String
    {
        let contents = try String(contentsOfFile: fileLocation, encoding: NSUTF8StringEncoding)
        //Swift.print(contents)
        return contents
    }
    
    func saveViewsWithTimer()
    {
        saveViews(studentViewFilename, curvefilename: curveViewFilename, rectanglefilename: rectangleViewFilename)
    }
    
    func saveViews(studentfilename: String, curvefilename: String, rectanglefilename: String)
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
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(studentViewArray, toFile: studentfilename)
        if !isSuccessfulSave {
            Swift.print("Failed to save student views...")
        }
        else
        {
            //Swift.print("Succeded to save student views")
        }
        
        let isSuccessfulSave2 = NSKeyedArchiver.archiveRootObject(curveViewArray, toFile: curvefilename)
        if !isSuccessfulSave2 {
            Swift.print("Failed to save student views...")
        }
        else
        {
            ///Swift.print("Succeded to save curve views")
        }
        
        let isSuccessfulSave3 = NSKeyedArchiver.archiveRootObject(rectangleViewArray, toFile: rectanglefilename)
        if !isSuccessfulSave3 {
            Swift.print("Failed to save student views...")
        }
        else
        {
            //Swift.print("Succeded to save rectangle views")
        }
    }
    
    func updateAllStudentViewsGroups()
    {
        for i in 0...Int(self.view.subviews.count) - 1
        {
            if self.view.subviews[i] is StudentView
            {
                (self.view.subviews[i] as! StudentView).checkForGroupViews()
            }
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

