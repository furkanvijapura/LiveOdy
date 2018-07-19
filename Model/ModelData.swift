//
//  ModelData.swift
//  MultiSelectionWithSearch-Swift
//
//  Created by discusit on 06/04/18.
//  Copyright © 2018 Discus IT. All rights reserved.
//

import UIKit

//Model-Data
var DataStore = [ModelData]()
var DataStoreFilter = [ModelData]()

//T-W-ModelData
var TagDataStore = [ModelTimesheetAddworkLogTagList]()
var TagDataStoreFilter = [ModelTimesheetAddworkLogTagList]()

class ModelData: NSObject {
    var fName = String()
    var ID = Int64()
    var emailID = NSArray()

    
    init(name:String,id:Int64,email:NSArray) {
        self.ID = id
        self.fName = name
        self.emailID = email
    }
    
    class func generateModelArray() -> [ModelData]{
        var modelAry = [ModelData]()
        
        for person in 0..<PersonList.count
        {
            let id = (PersonList.object(at: person) as! NSDictionary).value(forKeyPath: "id") as! Int64
            let name = (PersonList.object(at: person) as! NSDictionary).value(forKeyPath: "firstName") as! String
            let email = (PersonList.object(at: person) as! NSDictionary).value(forKeyPath: "email") as! NSArray
            
            modelAry.append(ModelData(name: name, id: id, email: email))
        }
        return modelAry
    }

}


//Mark : Tag list Model

class ModelTimesheetAddworkLogTagList: NSObject {
    var tagName = String()
    var tagID = Int64()
    
    
    init(tag:String,id:Int64) {
        self.tagID = id
        self.tagName = tag
    }
    
    class func generateModelArray() -> [ModelTimesheetAddworkLogTagList]{
        var modelAry = [ModelTimesheetAddworkLogTagList]()
        
        for person in 0..<tagList.count
        {
            let id = (tagList.object(at: person) as! NSDictionary).value(forKeyPath: "id") as! Int64
            let name = (tagList.object(at: person) as! NSDictionary).value(forKeyPath: "text") as! String
            
            modelAry.append(ModelTimesheetAddworkLogTagList(tag: name, id: id))
        }
        return modelAry
    }
}
