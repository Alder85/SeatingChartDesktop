//
//  Class.swift
//  DriveSample
//
//  Created by DEAN, JOSHUA on 2/5/16.
//
//

import Foundation

class Class
{
    fileprivate var studentList: [Student] = []
    fileprivate var groups: [[Student]] = []
    fileprivate var className: String = ""
    
    init(inArray: [Student], name: String)
    {
        studentList = inArray
        className = name
    }
    
    init(inputArray: [[String]], name: String)
    {
        for x in 1...inputArray.count - 1
        {
            let temp = Student(inArray: inputArray[x], otherArray: [" "])
            studentList.append(temp)
        }
        className = name
    }
    
    func getName() -> String
    {
        return className
    }
    
    func setName(_ name: String)
    {
        className = name
    }
    
    func getStudent(_ name: String) -> Student
    {
        for x in 0...studentList.count - 1
        {
            if name == studentList[x].getName()
            {
                return studentList[x]
            }
        }
        return Student.init()
    }
    
    func addStudent(_ student: Student)
    {
        studentList.append(student)
    }
    
    func removeStudent(_ student: Student)
    {
        for x in 0...studentList.count - 1
        {
            if studentList[x] === student
            {
                studentList.remove(at: x)
            }
        }
    }
    
    func getGroup(_ count: Int) -> [Student]
    {
        return groups[count]
    }
    
    func createGroup(_ groupNumber: Int, students: [Student])
    {
        groups.append(students)
    }
    
    func addStudentToGroup(_ groupNumber: Int, student: Student)
    {
        groups[groupNumber].append(student)
    }
    
    func removeStudentFromGroup(_ groupNumber: Int, student: Student)
    {
        for x in 0...groups[groupNumber].count - 1
        {
            if groups[groupNumber][x] === student
            {
                groups[groupNumber].remove(at: x)
            }
        }
    }
    
}



















