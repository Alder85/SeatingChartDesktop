//
//  CurveView.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/29/16.
//
//

import Foundation
import Cocoa
import AppKit
import Darwin

class CurveView: GroupView {
    //Dragable stuff
    
    
    var numRows: CGFloat
    var rowLength: CGFloat
    var buttonArray: [NSButton] = []
    
    var leftRect: Bool
    var nv: Bool
    
    //static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let CoreDirectory = FileManager().urls(for: .desktopDirectory, in: .userDomainMask).first!
    
    static let ArchiveTwo = CoreDirectory.appendingPathComponent("/SeatingChartInfo/CurveViews")
    //static let ArchiveURL = DocumentsDirectory.appendingPathComponent("CurveViews")
    
    struct PropertyKey {
        static let frameKey = "frame"
        static let isLeftKey = "leftRect"
        static let subviewArrayKey = "subviewArray"
        static let rowLengthKey = "rowLength"
        static let nvKey = "NVK"
        static let allKey = "all"
    }
    
    init(size: Int, isLeft: Bool, rows: CGFloat, length: CGFloat, startX: CGFloat, startY: CGFloat)
    {
        
        leftRect = isLeft
        numRows = rows
        rowLength = length
        nv = leftRect
        super.init(inFrame: CGRect(origin: CGPoint(x: startX, y: startY), size: CGSize(width: size, height: size)))
        makeButtons()
        addEditToggle()
        hideButtons()
        Swift.print(FileManager().urls(for: .applicationSupportDirectory, in: .userDomainMask).first!)
        for i in 0...(Int(rows - 1))
        {
            subviewArray.insert([], at: i)
            for q in 0...4
            {
                let temp = GroupSubview(inRect: CGRect(x: CGFloat(arc4random_uniform(UInt32(self.frame.height))), y: CGFloat(arc4random_uniform(UInt32(self.frame.height))), width: 50, height: 50))
                subviewArray[i].insert(temp, at: q)
                //self.addSubview(subviewArray[i][q])
            }
        }
       // self.backgroundColor = NSColor.white
        
        updateSubviewCurves()
        self.setNeedsDisplay(self.frame) //makes context exist
        
        updateTimer = Timer.scheduledTimer(timeInterval: 0.033, target: self, selector: Selector("redraw:"), userInfo: nil, repeats: true)
        
    }
    
    
    convenience init(size: Int, isLeft: Bool, rows: CGFloat, length: CGFloat, startX: CGFloat, startY: CGFloat, subArray: [[GroupSubview]])
    {
        self.init(size: size, isLeft: isLeft, rows: rows, length: length, startX: startX, startY: startY)
        for x in 0...subArray.count - 1
        {
            if subArray[x].count < 5
            {
                let val = (5 - subArray[x].count)
                for _ in 0...val - 1
                {
                    removeViewInt(x)
                }
            }
            else if subArray[x].count > 5
            {
                
                let val = (subArray[x].count - 5)
                for _ in 0...val - 1
                {
                    addViewInt(x)
                }
            }
        }
    }
    
    convenience init(size: Int, isLeft: Bool, rows: CGFloat, length: CGFloat)
    {
        self.init(size: size, isLeft: isLeft, rows: rows, length: length, startX: 0.0, startY: 0.0)
    }
    
    
    
    override func encode(with aCoder: NSCoder) {
        let allArray: Any? = [frameArray, leftRect, subviewArray, rowLength]
        Swift.print(allArray)
        aCoder.encode(allArray, forKey: PropertyKey.allKey)
        /*
        aCoder.encode(self.frameArray, forKey: PropertyKey.frameKey)
        aCoder.encode(self.leftRect, forKey: PropertyKey.isLeftKey)
        //Swift.print(self.leftRect)
        aCoder.encode(self.nv, forKey: "NVK")
        //Swift.print(aCoder.decodeObject(forKey: PropertyKey.isLeftKey))
        aCoder.encode(self.subviewArray, forKey: PropertyKey.subviewArrayKey)
        aCoder.encode(self.rowLength, forKey: PropertyKey.rowLengthKey)
         */
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let allArray = aDecoder.decodeObject(forKey: PropertyKey.allKey)
        let potatoe = allArray as! NSArray
        
        let frameArray = potatoe[0] as! [CGFloat]
        let leftRect = potatoe[1] as! Bool
        let subviewArray = potatoe[2] as! [[GroupSubview]]
        let rowLength = potatoe[3] as! CGFloat
        
        // Must call designated initializer.
        self.init(size: Int(frameArray[2]), isLeft: leftRect, rows: CGFloat(subviewArray.count), length: rowLength, startX: frameArray[0], startY: frameArray[1] , subArray: subviewArray)
    }
    
    func makeButtons()
    {
        if !leftRect
        {
            for i in 1...Int(numRows)
            {
                let y = ((self.frame.size.width - rowLength) / numRows) * CGFloat(i)
                makeAddButton(CGPoint(x: y - 47, y: 2), row: i)
                makeSubtractButton(CGPoint(x: y - 25, y: 2), row: i)
            }
        }
        else
        {
            for i in 1...Int(numRows)
            {
                let y = ((self.frame.size.width - rowLength) / numRows) * (numRows - CGFloat(i))
                makeAddButton(CGPoint(x: y + 69, y: 2), row: i)
                makeSubtractButton(CGPoint(x: y + 91, y: 2), row: i)
            }
        }
    }
    
    func makeAddButton(_ point: CGPoint, row: Int)
    {
        let buttonSize = 20
        let button = NSButton(frame: CGRect(origin: point, size: CGSize(width: buttonSize, height: buttonSize))) //add views
        button.setButtonType(NSButtonType.momentaryLight)
        button.bezelStyle = NSBezelStyle.smallSquare
        button.title = "+"
        //button.sendActionOn(Int(NSEventMask.LeftMouseDownMask.rawValue))
        button.sendAction(on: NSEventMask(rawValue: UInt64(Int(NSEventMask.leftMouseDown.rawValue))))
        button.action = #selector(CurveView.addView(_:))
        button.target = self
        button.identifier = String(row - 1)
        self.addSubview(button)
        buttonArray.append(button)
    }
    
    func makeSubtractButton(_ point: CGPoint, row: Int)
    {
        let buttonSize = 20
        let button = NSButton(frame: CGRect(origin: point, size: CGSize(width: buttonSize, height: buttonSize))) //add views
        button.setButtonType(NSButtonType.momentaryLight)
        button.bezelStyle = NSBezelStyle.smallSquare
        button.title = "-"
        button.sendAction(on: NSEventMask(rawValue: UInt64(Int(NSEventMask.leftMouseDown.rawValue))))
        
        button.action = #selector(CurveView.removeView(_:))
        button.target = self
        button.identifier = String(row - 1)
        self.addSubview(button)
        buttonArray.append(button)
    }
    
    func addView(_ obj: NSButton)
    {
        addViewInt(Int(obj.identifier!)!)
    }
    
    func addViewInt(_ rowNumber: Int)
    {
        //Swift.print("add" + String(rowNumber))
        let temp = GroupSubview(inRect: CGRect(x: 100, y: 100, width: 50, height: 50))
        
        subviewArray[rowNumber].insert(temp, at: subviewArray[rowNumber].count)
        updateSubviewCurves()
        moveAllViewsWithGroup()
    }
    
    func removeView(_ obj: NSButton)
    {
        removeViewInt(Int(obj.identifier!)!)
    }
    
    func removeViewInt(_ rowNumber: Int)
    {
        //Swift.print("subtract" + String(rowNumber))
        if(subviewArray[rowNumber].count > 1)
        {
            subviewArray[rowNumber][subviewArray[rowNumber].count - 1].removeFromSuperview()
            subviewArray[rowNumber].remove(at: subviewArray[rowNumber].count - 1)
            updateSubviewCurves()
            moveAllViewsWithGroup()
        }
        
    }
    
    func addEditToggle()
    {
        let toggleSize: CGFloat = 20
        let button = NSButton(frame: CGRect(x: self.frame.height - toggleSize, y: self.frame.height - toggleSize, width: toggleSize, height: toggleSize))
        if leftRect
        {
            button.frame = CGRect(x: 0, y: self.frame.height - toggleSize, width: toggleSize, height: toggleSize)
        }
        button.setButtonType(NSButtonType.switch) //moveable checkbox
        button.sendAction(on: NSEventMask(rawValue: UInt64(Int(NSEventMask.leftMouseDown.rawValue))))
        button.action = "toggleEditable:"
        button.target = self
        self.addSubview(button)
    }
    
    func updateSubviewCurves()
    {
        for i in 1...Int(numRows)
        {
            let y = ((self.frame.size.width - rowLength) / numRows) * CGFloat(i)
            if !leftRect
            {
                makeRightSubviewCurve(y, length: rowLength, curveNumber: (i-1))
            }
            else
            {
                makeLeftSubviewCurve(y, length: rowLength, curveNumber: (i-1))
            }
        }

    }
    
    override func toggleEditable(_ obj: AnyObject?)
    {
        
        if editable
        {
            hideButtons()
        }
        else
        {
            showButtons()
        }
        redraw()
        super.toggleEditable(obj)
    }
    
    func hideButtons()
    {
        for i in 0...buttonArray.count - 1
        {
            buttonArray[i].isHidden = true
        }
    }
    
    func showButtons()
    {
        for i in 0...buttonArray.count - 1
        {
            buttonArray[i].isHidden = false
            self.addSubview(buttonArray[i])
        }
    }
    
    
    
    override func draw(_ dirtyRect: NSRect)
    {

        //super.drawRect(dirtyRect)
        /*
        let lineWidth: CGFloat = 5
        let context = NSGraphicsContext.current()?.cgContext
        context?.setStrokeColor(NSColor(red: 255.0/255.0, green: 204.0/255.0, blue: 153.0/255.0, alpha: 1.0).cgColor)
        context?.setLineWidth(lineWidth)
        if !leftRect
        {
            for i in 1...Int(numRows)
            {
                let y = ((dirtyRect.size.width - rowLength) / numRows) * CGFloat(i)
                makeRightCurve(context, startSpot: y, length: rowLength, rect: dirtyRect)
            }

        }
        else
        {
            for i in 1...Int(numRows)
            {
                let y = ((dirtyRect.size.width - rowLength) / numRows) * CGFloat(i)
                makeLeftCurve(context, startSpot: y, length: rowLength, rect: dirtyRect)
            }
        }
        context?.setStrokeColor(NSColor.green.cgColor)
        context?.setLineWidth(lineWidth)
        */
        showButtons()
    }
    
    func makeRightSubviewCurve(_ startSpot: CGFloat, length: CGFloat, curveNumber: Int)
    {
        let numSubviews = subviewArray[curveNumber].count
        if numSubviews <= 0
        {
            return
        }
        if numSubviews == 1
        {
            let tempDegree = round( CGFloat(Double(startSpot) * sin(M_PI / 4)) )
            subviewArray[curveNumber][0].frame = CGRect(x: tempDegree, y: tempDegree, width: 50, height: 50)
            self.addSubview(subviewArray[curveNumber][0])
            return
        }
        for i in 0...numSubviews - 1
        {
            let t = ((M_PI / 2) / Double(numSubviews - 1)) * Double(i)
            //let t = M_PI / 2
            let tempX = round( CGFloat(Double(startSpot) * cos(t)) )
            let tempY = round( CGFloat(Double(startSpot) * sin(t)) )
        
            subviewArray[curveNumber][i].frame = CGRect(x: tempX, y: tempY, width: 50, height: 50)
            
            self.addSubview(subviewArray[curveNumber][i])
        }
        
    }
    
    func makeLeftSubviewCurve(_ startSpot: CGFloat, length: CGFloat, curveNumber: Int)
    {
        let numSubviews = subviewArray[curveNumber].count
        if numSubviews <= 0
        {
            return
        }
        if numSubviews == 1
        {
            let tempDegree = round( CGFloat(Double(startSpot) * sin(M_PI / 4)) )
            subviewArray[curveNumber][0].frame = CGRect(x: tempDegree, y: tempDegree, width: 50, height: 50)
            self.addSubview(subviewArray[curveNumber][0])
            return
        }
        for i in 0...numSubviews - 1
        {
            let t = ((M_PI / 2) / Double(numSubviews - 1)) * Double(i)
            //let t = M_PI / 2
            let tempX = frameRect.maxX - (round( CGFloat(Double(startSpot) * cos(t)) ) + 50)
            let tempY = round( CGFloat(Double(startSpot) * sin(t)) )
            
            subviewArray[curveNumber][i].frame = CGRect(x: tempX, y: tempY, width: 50, height: 50)
            
            self.addSubview(subviewArray[curveNumber][i])
        }
        
    }
    
    
    func makeRightCurve(_ context: CGContext?, startSpot: CGFloat, length: CGFloat, rect: NSRect)
    {
        //CGContext.addArc(context, 0, 0, startSpot + length, 0, CGFloat(M_PI) / 2, 0) //big curve
        //CGContextAddArc(context, firstPoint(x,y), radius, startAngle, endAngle, int clockwise);
        //func addArc(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, radius: CGFloat)
        context?.addArc(center: CGPoint(x: 0, y: 0), radius: startSpot + length, startAngle: 0, endAngle: CGFloat(M_PI) / 2, clockwise: false)
        context?.move(to: CGPoint(x: startSpot + length, y: 0))                        //bottom line
        context?.addLine(to: CGPoint(x: startSpot, y: 0))
        
        
        //CGContextAddArc(context, 0, 0, startSpot, 0, CGFloat(M_PI) / 2, 0)          //little curve
        context?.addArc(center: CGPoint(x: 0, y: 0), radius: startSpot, startAngle: 0, endAngle: CGFloat(M_PI) / 2, clockwise: false)
        context?.move(to: CGPoint(x: 0, y: startSpot))                                 //left line
        context?.addLine(to: CGPoint(x: 0, y: startSpot + length))
        context?.strokePath()
        
    }
    
    func makeLeftCurve(_ context: CGContext?, startSpot: CGFloat, length: CGFloat, rect: NSRect)
    {
        //CGContextAddArc(context, rect.width, 0, startSpot + length, 0, CGFloat(M_PI) / 2, 1) //big curve
        context?.addArc(center: CGPoint(x: rect.width, y: 0), radius: startSpot + length, startAngle: 0, endAngle: CGFloat(M_PI) / 2, clockwise: true)
        context?.move(to: CGPoint(x: rect.width - (startSpot + length), y: 0))                  //bottom line
        context?.addLine(to: CGPoint(x: rect.width - startSpot, y: 0))
        context?.strokePath()
        
        //CGContextAddArc(context, rect.width, 0, startSpot, 0, CGFloat(M_PI) / 2, 1)          //little curve
        context?.addArc(center: CGPoint(x: rect.width, y: 0), radius: startSpot, startAngle: 0, endAngle: CGFloat(M_PI) / 2, clockwise: true)
        context?.move(to: CGPoint(x: rect.width, y: startSpot))
        context?.addLine(to: CGPoint(x: rect.width, y: startSpot + length))                     //left line
        context?.strokePath()
    }
    
    
    override func rightMouseDown(with theEvent : NSEvent) {
        let theMenu = NSMenu(title: "Contextual menu")
        theMenu.addItem(withTitle: "Remove View", action: #selector(CurveView.remove(_:)), keyEquivalent: "")
        
        for item: AnyObject in theMenu.items {
            if let menuItem = item as? NSMenuItem {
                menuItem.target = self
            }
        }
        
        NSMenu.popUpContextMenu(theMenu, with: theEvent, for: self)
    }
    
    func remove(_ sender: AnyObject?)
    {
        self.removeFromSuperview()
    }

}
