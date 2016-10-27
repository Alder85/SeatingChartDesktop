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

var nameOfCurrentFile = ""
var nameOfFileChanged = ""

var needToChangeCSV = false

class TestStoryController: NSViewController {
    //potatoepotatoe
    var classList: [Class] = [Class.init(inArray: [Student.init()], name: "potatoes"), Class.init(inArray: [Student.init()], name: "potatoes2")]
    
    var listOfHours = retrieveObjectArray("List of Hours") as! [String]
    
    @IBOutlet weak var potatoeFileSelector: NSPopUpButton!

    func assignFiles(_ sender: NSMenuItem)
    {
        currentfilestudentviewsname = sender.title
        currentfilecurveviewsname = sender.title
        currentfilerectangleviewsname = sender.title
        nameOfCurrentFile = sender.title
        nameOfFileChanged = ""
        Swift.print(sender.title)
    }
    
    func addFile(_ sender: NSMenuItem)
    {
        currentfilestudentviewsname = "File " + String(listOfHours.count + 1)
        currentfilecurveviewsname = "File " + String(listOfHours.count + 1)
        currentfilerectangleviewsname = "File " + String(listOfHours.count + 1)
        nameOfCurrentFile = "File " + String(listOfHours.count + 1)
        Swift.print(sender.title)
        listOfHours.append("File " + String(listOfHours.count + 1))
        storeObjectArray("List of Hours", valArray: listOfHours as [AnyObject])
        potatoeFileSelector.menu?.removeItem(at: (listOfHours.count - 1))
        potatoeFileSelector.menu?.addItem(NSMenuItem(title:  ("File " + String(listOfHours.count)), action: #selector(self.assignFiles(_:)), keyEquivalent: " data"))
        potatoeFileSelector.menu?.addItem( NSMenuItem(title:  "Add New File", action: #selector(self.addFile(_:)), keyEquivalent: " data"))
        self.performSegue(withIdentifier: "DaSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if listOfHours.count == 0
        {
            listOfHours.append(("File 1" as AnyObject) as! String)
        }
        _ = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.adminApplicationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        /*let potatoeFile = NSMenuItem(title:  "File 1", action: #selector(self.assignFiles(_:)), keyEquivalent: " data")
        let potatoeFile2 = NSMenuItem(title:  "File 2", action: #selector(self.assignFiles(_:)), keyEquivalent: " data")
        let potatoeFile3 = NSMenuItem(title:  "File 3", action: #selector(self.assignFiles(_:)), keyEquivalent: " data")*/
        
        
        
        
        for x in 0...listOfHours.count - 1
        {
            potatoeFileSelector.menu?.addItem( NSMenuItem(title:  listOfHours[x], action: #selector(self.assignFiles(_:)), keyEquivalent: " data"))
        }
        
        potatoeFileSelector.menu?.removeItem(at: (potatoeFileSelector.menu?.indexOfItem(withTitle: "None"))!)
        
        nameOfCurrentFile = (potatoeFileSelector.menu?.item(at: 0)?.title)!
        
        print(potatoeFileSelector.menu?.indexOfItem(withTitle: "Hour 1"))
        
        
        
        
        potatoeFileSelector.menu?.addItem( NSMenuItem(title:  "Add New File", action: #selector(self.addFile(_:)), keyEquivalent: " data"))
        
        /*let isSuccessfulSave = NSKeyedArchiver.archiveRootObject([], toFile: StudentView.ArchiveURL.path + "Hour 3")
        if !isSuccessfulSave {
            Swift.print("Failed to save student views...")
        }
        else
        {
            //Swift.print("Succeded to save student views")
        }
        
        let isSuccessfulSave2 = NSKeyedArchiver.archiveRootObject([], toFile: CurveView.ArchiveTwo.path + "Hour 3")
        if !isSuccessfulSave2 {
            Swift.print("Failed to save student views...")
        }
        else
        {
            ///Swift.print("Succeded to save curve views")
        }
        
        let isSuccessfulSave3 = NSKeyedArchiver.archiveRootObject([], toFile: RectangleView.ArchiveURL.path + "Hour 3")
        if !isSuccessfulSave3 {
            Swift.print("Failed to save student views...")
        }
        else
        {
            //Swift.print("Succeded to save rectangle views")
        }*/
        
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
    
    @IBAction func DaSegue(_ sender: AnyObject) {
        
    }

    @IBOutlet weak var ChangeNameOut: NSTextField!
    
    @IBAction func ChangeName(_ sender: AnyObject) {
        if potatoeFileSelector.indexOfItem(withTitle: ChangeNameOut.stringValue) == -1
        {
            for x in 0...listOfHours.count - 1
            {
                if listOfHours[x] == nameOfCurrentFile
                {
                    nameOfFileChanged = listOfHours[x]
                    listOfHours[x] = ChangeNameOut.stringValue
                }
            }
            nameOfCurrentFile = ChangeNameOut.stringValue
            potatoeFileSelector.menu?.item(withTitle: nameOfFileChanged)?.title = ChangeNameOut.stringValue
            storeObjectArray("List of Hours", valArray: listOfHours as [AnyObject])
            self.performSegue(withIdentifier: "DaSegue", sender: self)
        }
    }
    
    @IBAction func deleteFile(_ sender: AnyObject) {
        if listOfHours.count > 1 && nameOfCurrentFile != ""
        {
            /*let isSuccessfulSave = NSKeyedArchiver.archiveRootObject([], toFile: StudentView.ArchiveURL.path + nameOfCurrentFile)
            if !isSuccessfulSave {
                Swift.print("Failed to save student views...")
            }
            else
            {
                //Swift.print("Succeded to save student views")
            }
            
            let isSuccessfulSave2 = NSKeyedArchiver.archiveRootObject([], toFile: CurveView.ArchiveTwo.path + nameOfCurrentFile)
            if !isSuccessfulSave2 {
                Swift.print("Failed to save student views...")
            }
            else
            {
                ///Swift.print("Succeded to save curve views")
            }
            
            let isSuccessfulSave3 = NSKeyedArchiver.archiveRootObject([], toFile: RectangleView.ArchiveURL.path + nameOfCurrentFile)
            if !isSuccessfulSave3 {
                Swift.print("Failed to save student views...")
            }
            else
            {
                //Swift.print("Succeded to save rectangle views")
            }*/
            let indexToDelete = listOfHours.index(of: nameOfCurrentFile)!
            potatoeFileSelector.removeItem(withTitle: nameOfCurrentFile)
            listOfHours.remove(at: indexToDelete)
            storeObjectArray("List of Hours", valArray: listOfHours as [AnyObject])
            do
            {
                try FileManager().removeItem(atPath: CurveView.ArchiveTwo.path + nameOfCurrentFile)
            } catch let error as NSError {
                Swift.print("Can't Delete \(error)")
            }
            do
            {
                try FileManager().removeItem(atPath: RectangleView.ArchiveTwo.path + nameOfCurrentFile)
            } catch let error as NSError {
                Swift.print("Can't Delete \(error)")
            }
            do
            {
                try FileManager().removeItem(atPath: StudentView.ArchiveTwo.path + nameOfCurrentFile)
            } catch let error as NSError {
                Swift.print("Can't Delete \(error)")
            }
            nameOfCurrentFile = listOfHours[0]
            // nameOfCurrentFile = new one
        }
    }
    /*
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    */
    
    @IBAction func ChangeCSV(_ sender: AnyObject) {
        needToChangeCSV = true
        self.performSegue(withIdentifier: "DaSegue", sender: self)
    }
    
    
    

    
    
}

