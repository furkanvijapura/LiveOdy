//
//  T-WorkLogListModel.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 14/03/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
//----------------------------------------------------------------person list data---------
var WorkLogPersonListData = [TimesheetWorkLogPersonListModelll]()
var WorklogPersonListFilterData = [TimesheetWorkLogPersonListModelll]()
//----------------------------------------------------------------work log list model---------
var WorkrLogListData = [T_WorkLogListModel]()
var WorkLogListFilterData = [T_WorkLogListModel]()

class T_WorkLogListModel: NSObject {
    
    var Wid : NSNumber = NSNumber()
    var WpersonName : String = String()
    var WtaskD : String = String()
    var Wtasks : NSArray = NSArray()
    
     init(id:NSNumber,personName:String,taskDate:String,task:NSArray) {
        
        self.Wid = id
        self.WpersonName = personName
        self.WtaskD = taskDate
        self.Wtasks = task
    }
    
    class func GenrateTimesheetWorkLogListData() -> [T_WorkLogListModel]
    {
        var WorkLogListModelArray = [T_WorkLogListModel]()
        let TaskListData = WorkLogMain.value(forKey: "workLog") as! NSArray
        let count = TaskListData.count + 4
        for i in 0..<count
        {
            if i <= 3
            {

                WorkLogListModelArray.append(T_WorkLogListModel(id: 0, personName: "NA", taskDate: "NA", task: ["NA"]))
            }
            else
            {
                let id = (TaskListData.object(at: i-4) as! NSDictionary).value(forKey: "id") as! NSNumber
                let personName = (TaskListData.object(at: i-4) as! NSDictionary).value(forKey: "personName") as! String
                let TaskDate = (TaskListData.object(at: i-4) as! NSDictionary).value(forKey: "taskD") as! String
                let Task = (TaskListData.object(at: i-4) as! NSDictionary).value(forKey: "tasks") as! NSArray
                
                WorkLogListModelArray.append(T_WorkLogListModel(id: id, personName: personName, taskDate: TaskDate, task: Task))
            }
        }
        return WorkLogListModelArray
    }
}

//---------------------------------T-Work log Filter Persone list API --------


class  TimesheetWorkLogPersonListModelll : NSObject {
    
    var id : NSNumber = NSNumber()
    var personName : String = String()
    
    init(id:NSNumber,personName:String) {
        self.id = id
        self.personName = personName
    }
    
    class func GenrateTimesheetWorkLogPersonData() -> [TimesheetWorkLogPersonListModelll]
    {
        var WorkLogPersonListModelArray = [TimesheetWorkLogPersonListModelll]()
        
        let count = personListData.count
        for i in 0..<count
        {
                let id = (personListData.object(at: i) as! NSDictionary).value(forKey: "id") as! NSNumber
                let personName = (personListData.object(at: i) as! NSDictionary).value(forKey: "name") as! String
                WorkLogPersonListModelArray.append(TimesheetWorkLogPersonListModelll(id: id, personName: personName))
        }
        return WorkLogPersonListModelArray
    }
    
}


////--------------------------------------------leave log person list

var TimesheetPersonList:NSArray = NSArray()
class TimesheetPersonListModel: NSObject {
    var name: String = ""
    var personId: String = ""
    var id: String = ""
    init(Name:String,Personid:String,Id:String) {
        self.name = Name
        self.personId = Personid
        self.id = Id
    }
    class func generateORBuyerModelArray() -> [TimesheetPersonListModel]{
        var modelpersonList = [TimesheetPersonListModel]()
        for i in 0..<TimesheetPersonList.count
        {
            let mainid = (TimesheetPersonList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let namePerson =  (TimesheetPersonList.object(at: i) as! NSDictionary).value(forKey: "name") as! String
            let personid = (TimesheetPersonList.object(at: i) as! NSDictionary).value(forKey: "personId") as! Int
            print("ID :: ",mainid,"name :: ",namePerson,"type ::",personid)
            modelpersonList.append(TimesheetPersonListModel(Name: namePerson, Personid: String(personid), Id: String(mainid)))
        }
        return modelpersonList
    }
}

////////----------------------------------------Add Leave Log PesonList and LeaveTypeList --------------
// Person
var TimesheetPersonListData = [TimesheetAddLeavePersonList]()
var TimesheetPersonListFilterData = [TimesheetAddLeavePersonList]()
// LeaveType
var TimesheetLeaveListData = [TimesheetAddLeavePersonList]()
var TimesheetLeaveListFilterData = [TimesheetAddLeavePersonList]()

class TimesheetAddLeavePersonList : NSObject{
    
    var PersonName = String()
    var ID = NSNumber()
    
    var LeaveType = String()
    var LeaveID = NSNumber()
    
    init(leaveName:String,id:NSNumber) {
        self.LeaveType = leaveName
        self.LeaveID = id
    }
    init(personName : String,id : NSNumber) {
        self.ID = id
        self.PersonName = personName
    }
    class func GenratePersonList() -> [TimesheetAddLeavePersonList]{
        var modelreturnArray = [TimesheetAddLeavePersonList]()
        for i in 0..<PersonList.count
        {
            let personNameee = (PersonList.object(at: i) as! NSDictionary).value(forKey: "firstName") as! String
            let id = (PersonList.object(at: i) as! NSDictionary).value(forKey: "id") as! NSNumber
            
            modelreturnArray.append(TimesheetAddLeavePersonList(personName: personNameee, id: id))
        }
        return modelreturnArray
    }
    class func GenrateLeaveType() -> [TimesheetAddLeavePersonList]{
        var leaveReturnArray = [TimesheetAddLeavePersonList]()
        for i in 0..<LeaveTypeList.count
        {
            let leaveID = (LeaveTypeList.object(at: i) as! NSDictionary).value(forKey: "id") as! NSNumber
            let leaveTypeee = (LeaveTypeList.object(at: i) as! NSDictionary).value(forKey: "type") as! String
            
            leaveReturnArray.append(TimesheetAddLeavePersonList(leaveName: leaveTypeee, id: leaveID))
        }
        return leaveReturnArray
    }
}
////--------------------------------------------Timesheet Add WorkLeaveLog Company Model================

var TimesheetWorkCompanyList:NSArray = NSArray()
class TimesheetWorkCompanyModel: NSObject {
    var value: String = ""
    var category: String = ""
    var id: String = ""
    init(value:String,category:String,Id:String) {
        self.value = value
        self.category = category
        self.id = Id
    }
    class func generateORBuyerModelArray() -> [TimesheetWorkCompanyModel]{
        var modelpersonList = [TimesheetWorkCompanyModel]()
        for i in 0..<TimesheetWorkCompanyList.count
        {
            let mainid = (TimesheetWorkCompanyList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let value =  (TimesheetWorkCompanyList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            let category = (TimesheetWorkCompanyList.object(at: i) as! NSDictionary).value(forKey: "category") as! String
            print("ID :: ",mainid,"name :: ",value,"type ::",category)
            modelpersonList.append(TimesheetWorkCompanyModel(value: value, category: category, Id: String(mainid)))
        }
        return modelpersonList
    }
}
////--------------------------------------------Timesheet Add WorkLeaveLog TickectId Model================

var TimesheetWorkTicketList:NSArray = NSArray()
class TimesheetWorkTicketModel: NSObject {
    var value: String = ""
    var id: Int64 = Int64()
    init(value:String,Id:Int64) {
        self.value = value
        self.id = Id
    }
    class func generateORBuyerModelArray() -> [TimesheetWorkTicketModel]{
        var modelpersonList = [TimesheetWorkTicketModel]()
        for i in 0..<TimesheetWorkTicketList.count
        {
            let mainid = (TimesheetWorkTicketList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int64
            let value =  (TimesheetWorkTicketList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            print("ID :: ",mainid,"name :: ",value)
            modelpersonList.append(TimesheetWorkTicketModel(value: value, Id: mainid))
        }
        return modelpersonList
    }
}
////--------------------------------------------Timesheet Add WorkLeaveLog  project Model================

var TimesheetWorkProjectList:NSArray = NSArray()
class TimesheetWorkProjectModel: NSObject {
    var value: String = ""
    var id: String = ""
    init(value:String,Id:String) {
        self.value = value
        self.id = Id
    }
    class func generateORBuyerModelArray() -> [TimesheetWorkProjectModel]{
        var modelpersonList = [TimesheetWorkProjectModel]()
        for i in 0..<TimesheetWorkProjectList.count
        {
            let mainid = (TimesheetWorkProjectList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let value =  (TimesheetWorkProjectList.object(at: i) as! NSDictionary).value(forKey: "value") as! String
            print("ID :: ",mainid,"name :: ",value)
            modelpersonList.append(TimesheetWorkProjectModel(value: value,Id: String(mainid)))
        }
        return modelpersonList
    }
}
