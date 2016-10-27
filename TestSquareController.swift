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
    
    
    var studentviewfile = StudentView.ArchiveTwo.path + nameOfCurrentFile
    var curveviewfile = CurveView.ArchiveTwo.path + nameOfCurrentFile
    var rectangleviewfile = RectangleView.ArchiveTwo.path + nameOfCurrentFile
    
    
    
    @IBAction func addRectangleView(_ sender: AnyObject) {
        let tempG = RectangleView(inRect: CGRect(x: 800, y: 500, width: 300, height: 100), subviews: 1)
        self.view.addSubview(tempG)
    }

    @IBAction func addRightCurveViews(_ sender: AnyObject) {
        let button = sender as! NSMenuItem
        let temp = CurveView(size: 500, isLeft: false, rows: CGFloat(button.tag), length: 70)
        self.view.addSubview(temp)
    }
    
    @IBAction func addLeftCurveViews(_ sender: AnyObject) {
        let button = sender as! NSMenuItem
        let temp = CurveView(size: 500, isLeft: true, rows: CGFloat(button.tag), length: 70)
        self.view.addSubview(temp)
    }
    
    
    @IBAction func SaveViews(_ sender: AnyObject) {
        saveViewsWithTimer()
    }
    
    
    var studentViewArray: [StudentView] = []
    var curveViewArray: [CurveView] = []
    var rectangleViewArray: [RectangleView] = []
    var firstsnap = false
    var studentViewFilename = StudentView.ArchiveTwo.path
    var curveViewFilename = CurveView.ArchiveTwo.path
    var rectangleViewFilename = RectangleView.ArchiveTwo.path
    
    override func viewDidLoad()
    {
        self.title = nameOfCurrentFile
        Swift.print(studentviewfile)
        if needToChangeCSV
        {
            openFile()
            let _: CSwiftV
        }
        
        if nameOfFileChanged == ""
        {
            loadRectangleViews(rectangleviewfile)
        
            loadCurveViews(curveviewfile)
        
            if needToChangeCSV
            {
                loadStudentsWithCSV(studentviewfile)
            }
            else
            {
                loadStudentViews(studentviewfile)
            }
        }
        else
        {
            loadRectangleViews(RectangleView.ArchiveTwo.path + nameOfFileChanged)
            
            loadCurveViews(CurveView.ArchiveTwo.path + nameOfFileChanged)
            
            loadStudentViews(StudentView.ArchiveTwo.path + nameOfFileChanged)
            
            do
            {
                try FileManager().removeItem(atPath: CurveView.ArchiveTwo.path + nameOfFileChanged)
            } catch let error as NSError {
                Swift.print("Can't Delete \(error)")
            }
            do
            {
                try FileManager().removeItem(atPath: RectangleView.ArchiveTwo.path + nameOfFileChanged)
            } catch let error as NSError {
                Swift.print("Can't Delete \(error)")
            }
            do
            {
                try FileManager().removeItem(atPath: StudentView.ArchiveTwo.path + nameOfFileChanged)
            } catch let error as NSError {
                Swift.print("Can't Delete \(error)")
            }
            saveViews(studentviewfile, curvefilename: curveviewfile, rectanglefilename: rectangleviewfile)
        }
        
        nameOfFileChanged = ""
        needToChangeCSV = false
        
        //_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TestSquareController.saveViewsWithTimer), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(TestSquareController.updateAllStudentViewsGroups), userInfo: nil, repeats: true)

    }
    
    func setFileNames(_ str: String)
    {
        studentviewfile = str
        curveviewfile = str
        rectangleviewfile = str
    }
    
    var fileLocation: String = "/Users/732408/Desktop/ClassList.csv"//""
    func openFile() {
        
        let myFileDialog: NSOpenPanel = NSOpenPanel()
        myFileDialog.runModal()
        
        // Get the path to the file chosen in the NSOpenPanel
        fileLocation = (myFileDialog.url?.path)!
        Swift.print(fileLocation)
    }
    
    func loadCSV() throws -> String
    {
        let contents = try String(contentsOfFile: fileLocation, encoding: String.Encoding.utf8)
        //Swift.print(contents)
        return contents
    }
    
    func saveViewsWithTimer()
    {
        saveViews(studentviewfile, curvefilename: curveviewfile, rectanglefilename: rectangleviewfile)
    }
    
    func saveViews(_ studentfilename: String, curvefilename: String, rectanglefilename: String)
    {
        studentViewArray = []
        curveViewArray = []
        rectangleViewArray = []
        
        if Int(self.view.subviews.count) > 0
        {
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
        }
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(studentViewArray, toFile: studentfilename)
        if !isSuccessfulSave {
            Swift.print("Failed to save student views...")
            if FileManager.SearchPathDirectory.desktopDirectory.createSubFolder(named: "SeatingChartInfo") {
                print("folder successfully created")
            }
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(studentViewArray, toFile: studentfilename)
            if !isSuccessfulSave {
                Swift.print("Something screwed up...")
            }
        }
        else
        {
            //Swift.print("Succeded to save student views")
        }
        
        let isSuccessfulSave2 = NSKeyedArchiver.archiveRootObject(curveViewArray, toFile: curvefilename)
        if !isSuccessfulSave2 {
            Swift.print("Failed to save curve views...")
            if FileManager.SearchPathDirectory.desktopDirectory.createSubFolder(named: "SeatingChartInfo") {
                print("folder successfully created")
            }
            let isSuccessfulSave2 = NSKeyedArchiver.archiveRootObject(curveViewArray, toFile: curvefilename)
            if !isSuccessfulSave2 {
                Swift.print("Something screwed up...")
            }
        }
        else
        {
            
        }
        
        let isSuccessfulSave3 = NSKeyedArchiver.archiveRootObject(rectangleViewArray, toFile: rectanglefilename)
        if !isSuccessfulSave3 {
            Swift.print("Failed to save rectangle views...")
            if FileManager.SearchPathDirectory.desktopDirectory.createSubFolder(named: "SeatingChartInfo") {
                print("folder successfully created")
            }
            let isSuccessfulSave3 = NSKeyedArchiver.archiveRootObject(rectangleViewArray, toFile: rectanglefilename)
            if !isSuccessfulSave3 {
                Swift.print("Something screwed up...")
            }
        }
        else
        {
            
        }
    }
    
    func updateAllStudentViewsGroups()
    {
        if Int(self.view.subviews.count) > 0
        {
            for i in 0...Int(self.view.subviews.count) - 1
            {
                if self.view.subviews[i] is StudentView
                {
                    (self.view.subviews[i] as! StudentView).checkForGroupViews()
                }
            }
        }
    }
    /*
    override var representedObject: AnyObject {
        didSet {
            // Update the view, if already loaded.
        }
    }
 */
    
    func loadCurveViews(_ filename: String)
    {
        if NSKeyedUnarchiver.unarchiveObject(withFile: filename) != nil
        {
            curveViewArray = (NSKeyedUnarchiver.unarchiveObject(withFile: filename) as? [CurveView])!
        }
        else
        {
            curveViewArray = []
        }
        
        if curveViewArray.count > 0
        {
            for x in 0...curveViewArray.count - 1
            {
                //print(curveViewArray[x].leftRect)
                let temp1 = curveViewArray[x] as CurveView
                //let temp = CurveView(size: Int(temp1.frameArray[2]), isLeft: temp1.leftRect, rows: CGFloat(temp1.subviewArray.count), length: temp1.rowLength, startX: temp1.frameArray[0], startY: temp1.frameArray[1], subArray: temp1.subviewArray)
                self.view.addSubview(temp1)
            }
        }
    }
    
    func loadRectangleViews(_ filename: String)
    {
        if NSKeyedUnarchiver.unarchiveObject(withFile: filename) != nil
        {
            rectangleViewArray = (NSKeyedUnarchiver.unarchiveObject(withFile: filename) as? [RectangleView])!
        }
        else
        {
            rectangleViewArray = []
        }
        
        if rectangleViewArray.count > 0
        {
            for x in 0...rectangleViewArray.count - 1
            {
                //let tempRect = CGRect(x: rectangleViewArray[x].frameArray[0], y: rectangleViewArray[x].frameArray[1], width: rectangleViewArray[x].frameArray[2], height: rectangleViewArray[x].frameArray[3])
                //let temp = RectangleView(inRect: tempRect, subviews: rectangleViewArray[x].numberOfSubviews)
                let temp = rectangleViewArray[x] as RectangleView
                self.view.addSubview(temp)
            }
        }
    }
    
    func loadStudentViews(_ filename: String)
    {
        if NSKeyedUnarchiver.unarchiveObject(withFile: filename) != nil
        {
            studentViewArray = (NSKeyedUnarchiver.unarchiveObject(withFile: filename) as? [StudentView])!
        }
        else
        {
            studentViewArray = []
        }
        
        do
        {
            if studentViewArray.count > 0
            {
                for x in 0...studentViewArray.count - 1
                {
                    let temp = studentViewArray[x] as StudentView
                    self.view.addSubview(temp)
                    temp.checkForGroupViews()
                    temp.snap()
                }
            }
        }
        catch
        {
            Swift.print("failed")
        }
    }
    
    func loadStudentsWithCSV(_ filename: String)
    {
        if NSKeyedUnarchiver.unarchiveObject(withFile: filename) != nil
        {
            studentViewArray = (NSKeyedUnarchiver.unarchiveObject(withFile: filename) as? [StudentView])!
        }
        else
        {
            studentViewArray = []
        }
        
        let csv: CSwiftV
        var studentsAlreadyCreated: [Int] = []
        
        do
        {
            try csv = CSwiftV(string: loadCSV())
            let studentArray: [Student] = dataToStudentArray(csv.rows)
            let nameArray: [String] = csv.headers
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
                            if  loadedStudent.getName() == studentArray[b].getName()
                            {
                                let temp = StudentView(inRect: CGRect(x: studentViewArray[x].frameArray[0], y: studentViewArray[x].frameArray[1], width: studentViewArray[x].viewHeight, height: studentViewArray[x].viewLength), inStudent: Student(inArray: studentArray[b].getInformation(), otherArray: nameArray))
                                self.view.addSubview(temp)
                                temp.checkForGroupViews()
                                temp.snap()
                                isAdded = true
                                studentsAlreadyCreated.append(x)
                                break
                            }
                        }
                    }
                }
                if !isAdded
                {
                    let temp = StudentView(inRect: CGRect(x: CGFloat(0), y: CGFloat(0), width: 50, height: 50), inStudent: Student(inArray: studentArray[b].getInformation(), otherArray: nameArray))
                    self.view.addSubview(temp)
                }
            }
        }
        catch
        {
            Swift.print("failed")
        }
    }
    
    func isNumberInArrayInt(_ num: Int, numArray: [Int]) -> Bool
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

