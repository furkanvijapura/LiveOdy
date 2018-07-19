//
//  CompanyPeopleFilterScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 27/11/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class CompanyPeopleFilterScreen: UIViewController,UIPickerViewDelegate
{
    @IBOutlet var viewContacts: UIView!
    @IBOutlet var viewStatus: UIView!
    var Contacts = ["Both","Company Only","People Only"]
    var status = ["Enabled","Disabled"]
    var contactarrayData = NSArray()
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    let pickerView = UIPickerView()
    @IBOutlet weak var txtBoth: UITextField!
    @IBOutlet weak var txtStatus: UITextField!
    @IBOutlet weak var lblContacts: UILabel!
    @IBOutlet weak var btnContacts: UIButton!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Filter"
       // btnCancel.isHidden=true
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(CompanyPeopleFilterScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        txtBoth.inputView = pickerView
        txtBoth.setDoneOnKeyboard()
        txtStatus.inputView = pickerView
        txtStatus.setDoneOnKeyboard()
        pickerView.delegate = self
        txtBoth.rightViewMode = .always
        txtBoth.rightView = UIImageView(image: UIImage(named: "down_dark_arrow"))
        txtStatus.rightViewMode = .always
        txtStatus.rightView = UIImageView(image: UIImage(named: "down_dark_arrow"))
        viewStatus.SetViewShadow()
        viewContacts.SetViewShadow()
        
        if contactFilterBoolManagerrr.contactCompanyBool == 1 && contactFilterBoolManagerrr.contactPersonBool == 0 {
            txtBoth.text = "Company Only"
            txtBoth.isUserInteractionEnabled = false
        }else if contactFilterBoolManagerrr.contactPersonBool == 1 && contactFilterBoolManagerrr.contactCompanyBool == 0{
            txtBoth.text = "People Only"
            txtBoth.isUserInteractionEnabled = false
        }
        else if contactFilterBoolManagerrr.contactPersonBool == 1 && contactFilterBoolManagerrr.contactCompanyBool == 1
        {
            txtBoth.isUserInteractionEnabled = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnContactsTapped(_ sender: Any) {
    }
    
    func getCompanyPeopleFilter()
    {
             //  INDISTART()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        
        if txtBoth.text=="Both"
        {
            objDic .setValue("4", forKey:"filterType")
            if txtStatus.text == "Enabled"
            {
                objDic .setValue("1", forKey:"filterStatus")
            }
            else if txtStatus.text == "Disabled"
            {
                objDic .setValue("2", forKey:"filterStatus")
            }
            else{
                objDic .setValue("3", forKey:"filterStatus")
            }
        }
        else if txtBoth.text=="Company Only"
        {
            objDic .setValue("1", forKey:"filterType")
            if txtStatus.text == "Enabled"
            {
                objDic .setValue("1", forKey:"filterStatus")
            }
            else if txtStatus.text == "Disabled"
            {
                objDic .setValue("2", forKey:"filterStatus")
            }
            else{
                objDic .setValue("3", forKey:"filterStatus")
            }
        }
        else{
            objDic .setValue("2", forKey:"filterType")
            if txtStatus.text == "Enabled"
            {
                objDic .setValue("1", forKey:"filterStatus")
            }
            else if txtStatus.text == "Disabled"
            {
                objDic .setValue("2", forKey:"filterStatus")
            }
            else{
                objDic .setValue("3", forKey:"filterStatus")
            }
        }
        START_INDICATOR()
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "common/contacts/filter") { (response, isVisit)
            in
            self.STOP_INDICATOR()
            if response != nil
            {
                FilterDicArry = (response)!
                print("FilterDicArry.count=",FilterDicArry.count)
                dataAryFilter = FIlterModel.generateModelFilterArray()
                
                
            }
            let story = self.storyboard?.instantiateViewController(withIdentifier:"CompanyListScreen") as! CompanyListScreen
            story.isFilterArr=true
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        let story = self.storyboard?.instantiateViewController(withIdentifier:"CompanyListScreen") as! CompanyListScreen
        story.isFilterArr = false
         _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSubmitTapped(_ sender: Any)
    {
        getCompanyPeopleFilter()
    }
    
    // MARK: UiPickerview delegates here:
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if txtBoth.isEditing
        {
            return Contacts.count
        }
        else if txtStatus.isEditing
        {
            return status.count
        }
        return Contacts.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtBoth.isEditing
        {
            return Contacts[row]
        }
        else if txtStatus.isEditing
        {
            return status[row]
        }
        return status[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if txtBoth.isEditing
        {
            txtBoth.text = Contacts[row]
        }
        else if txtStatus.isEditing
        {
            txtStatus.text = status[row]
        }
        //        txtPersonName.text = pickOption[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
