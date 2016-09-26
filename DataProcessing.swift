//
//  DataProcessing.swift
//  Test1
//
//  Created by DEAN, JOSHUA on 9/18/15.
//  Copyright © 2015 Josh. All rights reserved.

////////////////////////////////////////////////////////////////////////////////////////
//                        Small 'library' for storing data                            //
//                                                                                    //
//  Store Functions    -> Store Data using String identifier, usually called 'name'   //
//  Retrieve Functions -> Retrieve data using previously declared String identifier   //
//  Invalid Values     -> Values Returned if no value was stored, change these to     //
//                     -  set a 'default' value for data types                        //
//  Currently Supported-> Double, String, Bool, [String], [Bool], [Double]            //
//                     -  AnyObject, [AnyObject]                                      //
//  AnyObject Methods  -> AnyObject can be used with Any Object, but requires forced  //
//                     -  casting from the return method                              //
//                     -  The other methods still exist to allow custom returns for   //
//                     -  invalid values                                              //
//                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////


import Foundation
import AppKit

//Invalid Values
let invDouble = -42.0
let invString = ""
let invBool   = false
let invObject = 0

/*
func storeCGPointArray(name: String, value: [CGPoint])
{
    defaults.setValue(value, forKey: name)
    defaults.synchronize()
}

func retrieveCGPointArray(name: String) -> [CGPoint]
{
    if let temp = defaults.valueForKey(name)
    {
        return temp
    }
    return invArray
}
*/

func storeObject(_ name: String, value: AnyObject)
{
    defaults.setValue(value, forKey: name)
    defaults.synchronize()
}

func retrieveObject(_ name: String) -> AnyObject
{
    if let temp = defaults.value(forKey: name)
    {
        return temp as AnyObject
    }
    return invObject as AnyObject
}


func storeDouble(_ name: String, value: Double)
{
    defaults.setValue(String(value), forKey: name);
    defaults.synchronize()
}

func retrieveDouble(_ name: String) -> Double?
{
    if let temp = defaults.value(forKey: name)
    {
        return (temp as AnyObject).doubleValue
    }
    return invDouble //returned if you try to retrieve a value that doesn't exist
}


func storeBool(_ name: String, value: Bool)
{
    defaults.setValue(String(value), forKey: name)
    defaults.synchronize()
}

func retrieveBool(_ name: String) -> Bool?
{
    if let tempBool = defaults.value(forKey: name)
    {
        return (tempBool as AnyObject).boolValue
    }
    return invBool //returned if you try to retrieve a value that doesn't exist
}


func storeString(_ name: String, value: String)
{
    defaults.setValue(value, forKey: name)
    defaults.synchronize()
}

func retrieveString(_ name: String) -> String?
{
    if let tempString = defaults.value(forKey: name)
    {
        return (tempString as AnyObject).string
    }
    return invString //returned if you try to retrieve a value that doesn't exist
}

func storeBoolArray(_ name: String, valArray: [Bool])
{
    storeObjectArray(name, valArray: valArray as [AnyObject])
    //defaults.setValue(valArray, forKey: name)
    //defaults.synchronize()
}
func retrieveBoolArray(_ name: String) -> [Bool]
{
    if let temp = defaults.value(forKey: name) as? [Bool]
    {return temp}
    return [] //blank array returned if not valid
}

func storeStringArray(_ name: String, valArray: [String])
{
    storeObjectArray(name, valArray: valArray as [AnyObject])
    //defaults.setValue(valArray, forKey: name)
    //defaults.synchronize()
}
func retrieveStringArray(_ name: String) -> [String]
{
    if let temp = defaults.value(forKey: name) as? [String]
    {return temp}
    return [] //blank array returned if not valid
}

func storeDoubleArray(_ name: String, valArray: [Double])
{
    storeObjectArray(name, valArray: valArray as [AnyObject])
    //defaults.setValue(valArray, forKey: name)
    //defaults.synchronize()
}
func retrieveDoubleArray(_ name: String) -> [Double]
{
    if let temp = defaults.value(forKey: name) as? [Double]
    {return temp}
    return [] //blank array returned if not valid
}

func storeObjectArray(_ name: String, valArray: [AnyObject])
{
    defaults.setValue(valArray, forKey: name)
    defaults.synchronize()
}

func retrieveObjectArray(_ name: String) -> [AnyObject] //must force unwrap when retrieving
{
    if let temp = defaults.value(forKey: name) as? [AnyObject]
    {return temp}
    return []
}

