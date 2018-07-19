//
//  AddVisitScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 6/29/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

var pickOption = ["one", "two", "three", "seven", "fifteen"]

let datePicker = UIDatePicker()
let timePIcker = UIDatePicker()

let dateFormatter = DateFormatter()
let TimeFormatter = DateFormatter()

class AddVisitScreen: UITableViewController,UITextFieldDelegate
{
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    var arrayOrganizationList = NSArray()
    var arrayPersonList = NSMutableArray()
    var strID = NSNumber()
    var personID = NSMutableArray()
    var personStr = String()
    
    var DateAddVisiteeee = String()
    var TimeAddVisiteeee = String()
    let calender = Calendar.current
    @IBOutlet var lblOrganization: UILabel!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var txtTimeSelect: UITextField!
    @IBOutlet var txtDateSelect: UITextField!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var txtPersonName: UITextField!
    @IBOutlet var lblPerson: UILabel!
    @IBOutlet var txtOrganizationName: UITextField!
    
    var isOrgSet = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Visit"
        txtPersonName.text = ""
        txtOrganizationName.text = ""
        PersonDataAddVisit.PersonName.removeAllObjects()
        PersonDataAddVisit.PersonID.removeAllObjects()
        PersonDataAddVisit.PersonIDSelect.removeAllObjects()
        PersonDataAddVisit.PersonNameSelect.removeAllObjects()
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        DateAddVisiteeee = dateString
        txtDateSelect.text = DateAddVisiteeee
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a"
        OrgNameModel.OrganizationName.removeAll()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(AddVisitScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
    }
    override func viewWillAppear(_ animated: Bool) {
         txtOrganizationName.text = OrgNameModel.OrganizationName
        txtPersonName.text = PersonDataAddVisit.PersonNameSelect.componentsJoined(by: ",")
    }
    @IBAction func btnCancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSelectOrg(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            let stroy = self.storyboard?.instantiateViewController(withIdentifier: "AddVisitSelectOrganization") as? AddVisitSelectOrganization
            self.present(stroy!, animated: true, completion: nil)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnSelectPerson(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            if txtOrganizationName.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please select OrganizationName first....")
            }
            else
            {
                isOrgSet = true
                let story = storyboard?.instantiateViewController(withIdentifier: "SearchPersonNameScreen") as! SearchPersonNameScreen
                self.present(story, animated: true, completion: nil)
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnSelectDate(_ sender: Any) {
        datePickerTappeddd()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
//    let calendar = Calendar.current
//    let minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
//    let minDate = calendar.date(from: minDateComponent)
//    dateFormatter.dateFormat = "dd MMM yyyy"
//    strCurrentdate = dateFormatter.string(from: minDate!)
//    print(strCurrentdate)
    //Mark : DatePicker
    func datePickerTappeddd() {
        let currentDate = Date()

        //start
        var components = DateComponents()
        components.setValue(10, for: .year)
        let date: Date = Date()
        let expirationDate = Calendar.current.date(byAdding: components, to: date)
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: false)
        datePicker.show("Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate:currentDate , maximumDate: expirationDate, datePickerMode: .date)
        {
            (date) in
            if let dt = date
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy"
                self.DateAddVisiteeee = formatter.string(from: dt)
                self.TimePickerPickerTappeddd()
            }
        }
    }
    //Mark : TimePicker
    func TimePickerPickerTappeddd() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = 12
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: false)
        datePicker.show("Select Time", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", minimumDate: threeMonthAgo, maximumDate: currentDate, datePickerMode: .time)
        {
            (date) in
            if let dt = date
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                self.TimeAddVisiteeee = formatter.string(from: dt)
                self.DateAddVisiteeee =  self.DateAddVisiteeee + " " + self.TimeAddVisiteeee
                self.txtDateSelect.text = self.DateAddVisiteeee
            }
        }
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AddVisitScreen.doneButtonActionAdd))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
      
        self.txtOrganizationName.inputAccessoryView = doneToolbar
        self.txtDateSelect.inputAccessoryView=doneToolbar
    }
    
    func doneButtonActionAdd()
    {
        self.txtOrganizationName.resignFirstResponder()
        self.txtDateSelect.resignFirstResponder()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
    }
    
    
    
    func addVisitApiCall()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary = NSMutableDictionary.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm a" //Your date format
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC +5:30") //Current time zone
        let date = dateFormatter.date(from: DateAddVisiteeee) //according to date format your date string
        print(date ?? "") //Convert String to Date
        let nowDouble = date?.timeIntervalSince1970
        let valuee = String(nowDouble!*100)
        let string = valuee
        
        let badchar = CharacterSet(charactersIn: "\".")
        let distancestring = string.components(separatedBy: badchar).joined()
        print(distancestring)
        objDic .setValue(distancestring, forKey:"datetimeOfVisit")
        objDic .setValue(OrgNameModel.OrganizationID, forKey:"organizationId")
        objDic .setValue(PersonDataAddVisit.PersonIDSelect, forKey:"personIdsList")

        APISession.postDataWithRequestwithTokenOnDictionary(objDic, withAPIName: "visitplan")
        { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            let value:String=(response as AnyObject).value(forKey: "message") as! String
            print(value)
            let alert = UIAlertController(title:"Odin App", message:value, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            {
                (alert:UIAlertAction!) -> Void in
                self.OK()
            })
            alert.addAction(okAction)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    func OK()
    {
        STOP_INDICATOR()
        self.navigationController?.popViewController(animated: true)
    }


    
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
            if txtOrganizationName.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please enter organization name....")
            }
            else if txtPersonName.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please select person name....")
            }
            else if txtDateSelect.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please select date for visit....")
            }
            else{
            addVisitApiCall()
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }


}
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    init(milliseconds:Int) {
         self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
