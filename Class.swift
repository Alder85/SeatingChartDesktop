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
    private var studentList: [Student] = []
    private var groups: [[Student]] = []
    private var className: String = ""
    
    init(inArray: [Student], name: String)
    {
        studentList = inArray
        className = name
    }
    
    init(inputArray: [[String]], name: String)
    {
        for x in 1...inputArray.count - 1
        {
            let temp = Student(inArray: inputArray[x])
            studentList.append(temp)
        }
        className = name
    }
    
    func getName() -> String
    {
        return className
    }
    
    func setName(name: String)
    {
        className = name
    }
    
    func getStudent(name: String) -> Student
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
    
    func addStudent(student: Student)
    {
        studentList.append(student)
    }
    
    func removeStudent(student: Student)
    {
        for x in 0...studentList.count - 1
        {
            if studentList[x] === student
            {
                studentList.removeAtIndex(x)
            }
        }
    }
    
    func getGroup(count: Int) -> [Student]
    {
        return groups[count]
    }
    
    func createGroup(groupNumber: Int, students: [Student])
    {
        groups.append(students)
    }
    
    func addStudentToGroup(groupNumber: Int, student: Student)
    {
        groups[groupNumber].append(student)
    }
    
    func removeStudentFromGroup(groupNumber: Int, student: Student)
    {
        for x in 0...groups[groupNumber].count - 1
        {
            if groups[groupNumber][x] === student
            {
                groups[groupNumber].removeAtIndex(x)
            }
        }
    }
    
}



















