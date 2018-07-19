//
//  FilterScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 13/10/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
var visitFilterBool = Bool()
var isMeOrMy = Bool()
class FilterScreen: UIViewController,UIPickerViewDelegate {
    @IBOutlet var txtFromdate: UITextField!
    @IBOutlet var txtToDate: UITextField!
    let dateFormatter1 = DateFormatter()
    let dateFormatter2 = DateFormatter()
    let datePicker1 = UIDatePicker()
    let datePicker2 = UIDatePicker()
    let pickerView = UIPickerView()

    var arrayData = NSArray()
    var selectstatus = ["Pending","Completed"]
    var sTatus = ["Enabled","Disabled","Both"]

    @IBOutlet var txtStatus: UITextField!
    @IBOutlet var txtSelectStatus: UITextField!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Filter Visit"
        visitFilterBool = true
        txtFromdate.setDoneOnKeyboard()
        txtToDate.setDoneOnKeyboard()
        txtFromdate.inputView=datePicker1
        txtToDate.inputView=datePicker2
        pickerView.delegate = self
        txtSelectStatus.inputView = pickerView
        txtStatus.inputView = pickerView
        txtSelectStatus.setDoneOnKeyboard()
        txtStatus.setDoneOnKeyboard()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        datePicker1.addTarget(self, action: #selector(handleDatePicker1(sender:)), for: UIControlEvents.valueChanged)
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        datePicker2.addTarget(self, action: #selector(handleDatePicker2(sender:)), for: UIControlEvents.valueChanged)
        txtFromdate.isHidden = true
        txtToDate.isHidden = true
        txtFromdate.text = dateFormatter1.string(from: datePicker.date)
        txtToDate.text = dateFormatter1.string(from: datePicker.date)
        txtSelectStatus.text = "Pending"

        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(FilterScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
        
        if isMeOrMy == false
        {
           self.txtStatus.isHidden = true
        }
        else{
            self.txtStatus.isHidden = false
        }
    }
    func handleDatePicker1(sender: UIDatePicker) {
        
        txtFromdate.text = dateFormatter1.string(from: datePicker1.date)
    }
    func handleDatePicker2(sender: UIDatePicker) {
        
        txtToDate.text = dateFormatter2.string(from: datePicker2.date)
    }
   func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getAllVisitPlans()
    {
//        INDISTART()
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(txtFromdate.text, forKey:"fromDate")
        objDic .setValue(txtToDate.text, forKey:"toDate")
        objDic .setValue("1", forKey:"userStatus")
        if txtSelectStatus.text=="Pending"
        {
            objDic .setValue("1", forKey:"type")
        }
        else{
        objDic .setValue("2", forKey:"type")
        }
        objDic .setValue("1", forKey:"personId")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "visitplan/getAllVisitPlan") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            self.arrayData=response!
            let objReg=self.storyboard?.instantiateViewController(withIdentifier:"VisitMainScreen") as! VisitMainScreen
            arrayMainListData = [""]
            arrayMainListData=self.arrayData
            objReg.isFilter=true
            self.navigationController?.popViewController(animated: true)
        }
    }
    func getAllVisitPlansFormMyTeam()
    {
        //        INDISTART()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(txtFromdate.text, forKey:"fromDate")
        objDic .setValue(txtToDate.text, forKey:"toDate")
        if txtSelectStatus.text=="Pending"
        {
            objDic .setValue("1", forKey:"type")
            if txtStatus.text == "Enabled"
            {
                objDic .setValue("1", forKey:"userStatus")
            }
            else if txtStatus.text == "Disabled"
            {
                objDic .setValue("2", forKey:"userStatus")
            }
            else{
                objDic .setValue("3", forKey:"userStatus")
            }
        }
        else{
            objDic .setValue("2", forKey:"type")
            if txtStatus.text == "Enabled"
            {
                objDic .setValue("1", forKey:"userStatus")
            }
            else if txtStatus.text == "Disabled"
            {
                objDic .setValue("2", forKey:"userStatus")
            }
            else{
                objDic .setValue("3", forKey:"userStatus")
            }
        }
        objDic .setValue("2", forKey:"personId")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "visitplan/getAllVisitPlan") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            self.arrayData=response!
            let objReg=self.storyboard?.instantiateViewController(withIdentifier:"VisitMainScreen") as! VisitMainScreen
            arrayMainListData = [""]
            arrayMainListData=self.arrayData
            objReg.isFilter=true
            self.navigationController?.popViewController(animated: true)
        }
    }
    // MARK: UiPickerview delegates here:
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if txtSelectStatus.isEditing
        {
            return selectstatus.count
        }
        else if txtStatus.isEditing
        {
            return sTatus.count
        }
        
        return selectstatus.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtSelectStatus.isEditing
        {
            return selectstatus[row]
        }
        else if txtStatus.isEditing
        {
            return sTatus[row]
        }
        
        return selectstatus[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if txtSelectStatus.isEditing
        {
            txtSelectStatus.text = selectstatus[row]
        }
        else if txtStatus.isEditing
        {
            txtStatus.text = sTatus[row]
        }
        
        
        //        txtPersonName.text = pickOption[row]
    }
    
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if isMeOrMy == false
        {
            if txtFromdate.text == ""
            {
            displayAlertMessage(messageToDisplay: "Please enter from Date....")
            }
            else if txtToDate.text == ""
            {
            displayAlertMessage(messageToDisplay: "Please enter to Date....")
            }
            else if txtSelectStatus.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please select Visit Status....")
            }
            else
            {
                getAllVisitPlans()
            }
        }
        else{
            if txtFromdate.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please enter from Date....")
            }
            else if txtToDate.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please enter to Date....")
            }
            else if txtSelectStatus.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please select Visit Status....")
            }
            else if txtStatus.text == ""
            {
                displayAlertMessage(messageToDisplay: "Please select Status....")
            }
            else{
             getAllVisitPlansFormMyTeam()
            }
        }
    }
    
    

}
