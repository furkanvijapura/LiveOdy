//
//  PeopleMoreInfoScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 06/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class PeopleMoreInfoScreen: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var viewCompanyPeople: UIView!
    @IBOutlet var viewInfosetPeople: UIView!
    @IBOutlet var viewKeyInfoPeople: UIView!
    @IBOutlet weak var tblPeopleMoreInfo: UITableView!
    var companyId = NSString()
    var strBillingAddress = NSString()
    var strShippingAddress = NSString()
    var strLine1 = String()
    var strLine2 = String()
    var strCityName = String()
    var strStateName = String()
    var strCountryName = String()
    var strLine3 = String()
    var strLine1Shipping = String()
    var strLine2Shipping  = String()
    var strCityNameShipping  = String()
    var strStateNameShipping  = String()
    var strCountryNameShipping  = String()
    var strLine3Shipping  = String()
    var strTinNo  = String()
    var strDefaultPriceBook  = String()
    var arrayCompanyKeyInfo = NSArray()
    var arrayCompanyInfoset = NSArray()
    var arrayPeopleDetails = NSArray()
    var  arrPriceBookList = NSArray()
    var strParentOrgName  = String()
    var strCount  = String()
    var strTitlePeople = String()
    
    @IBOutlet weak var textViewBilingAdd: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title=strTitlePeople
        tblPeopleMoreInfo.delegate=self
        tblPeopleMoreInfo.dataSource=self
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(PeopleMoreInfoScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        print("0companyId==",companyId)
        self.tblPeopleMoreInfo.separatorStyle = UITableViewCellSeparatorStyle.none
        getPeopleMoreInfo()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnPricebookPlusTapped(_ sender: Any) {
    }
        var  companyArray = NSArray()
    var  keyInfoArray = NSArray()
    var  infoSetArray = NSArray()
    func getPeopleMoreInfo()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataWithRequest( withAPIName: "person/more/" + (companyId as String)) {
                (response, permissions) in
                print(("",response))
                self.STOP_INDICATOR()
                if response != nil
                {
                    let company : NSArray = response! .value(forKey: "company") as! NSArray
                    self.companyArray=company
                    let keyInfo : NSArray = response! .value(forKey: "keyInfo") as! NSArray
                    self.keyInfoArray=keyInfo
                    let infoSet : NSArray = response! .value(forKey: "infoSet") as! NSArray
                    self.infoSetArray=infoSet
                }
                self.tblPeopleMoreInfo .reloadData()
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0
        {
            let cell1  = tableView.dequeueReusableCell(withIdentifier: "cell1") as! KeyInfoSetCellPeople
            if  keyInfoArray.count==0
            {
                cell1.lblKeyInfoValue.text="NA"
                cell1.lblKeyInfoName.text="NA"
            }
            else{
            
            let objData : NSDictionary = self.keyInfoArray[indexPath.row] as! NSDictionary
            if let name : String = objData.value(forKey: "keyInfoValue") as? String
            {
                cell1.lblKeyInfoValue.text=name
            }
            if let lable : String = objData.value(forKey: "keyInfoLabel") as? String
            {
                cell1.lblKeyInfoName.text=lable
            }
            }
            return cell1
        }
        else if indexPath.section == 1
        {
            let cell2  = tableView.dequeueReusableCell(withIdentifier: "cell2") as! InfoSetCellPeople
            if infoSetArray.count==0
            {
                cell2.lblInfosetName.text="NA"
                cell2.lblInfosetDetails.text="NA"
            }
            else{
            let objData : NSDictionary = self.infoSetArray[indexPath.row] as! NSDictionary
            if let personName : String = objData.value(forKey: "personTypeName") as? String
            {
                cell2.lblInfosetName.text=personName
                cell2.lblInfosetDetails.text="NA"
                
            }
                if let detailsLbl : String = objData.value(forKey: "infoSetMoreLabel") as? String
                {
                    if detailsLbl == ""
                    {
                        cell2.lblInfosetDetails.text="NA"
                    }
                    else{
                        cell2.lblInfosetDetails.text=detailsLbl
                    }
                }
                if let detailsValue : String = objData.value(forKey: "infoSetMoreValue") as? String
                {
                    if detailsValue == ""
                    {
                        cell2.lblInfisetValueDetails.text="NA"
                    }
                    else{
                        cell2.lblInfisetValueDetails.text=detailsValue
                    }
                }
            }
            return cell2
        }
        else
        {
            let cell3  = tableView.dequeueReusableCell(withIdentifier: "cell3") as! CompanyCellPeople
            if companyArray.count==0
            {
                cell3.lblCompanyName.text="NA"
                cell3.btnWebSite.setTitle("NA", for: UIControlState.normal)
                cell3.btnPhoneNo.setTitle("NA",for: UIControlState.normal)
                cell3.btnEmail.setTitle("NA",for: UIControlState.normal)
            }
            else{
           let objData : NSDictionary = self.companyArray[indexPath.row] as! NSDictionary
            let orgName : String = (objData.value(forKey: "organizationName") as? String)!
            cell3.lblCompanyName.text=orgName
            let webSite : String = (objData.value(forKey: "webSite") as? String)!
            if webSite==""
            {
                cell3.btnWebSite.setTitle("NA", for: UIControlState.normal)
            }else{
            cell3.btnWebSite.setTitle(webSite, for: UIControlState.normal)
            }
            let arr1:NSArray = (objData.value(forKey: "contacts") as? NSArray)!
            if arr1.count==0
            {
                cell3.btnPhoneNo.setTitle("NA",for: UIControlState.normal)
            }
            else{
                if (arr1.object(at: 0)as? String)==""
                {
                    cell3.btnPhoneNo.setTitle("NA",for: UIControlState.normal)
                }
                else{
                    cell3.btnPhoneNo.setTitle(arr1.object(at: 0)as? String,for: UIControlState.normal)
                }
                }
            let email:NSArray = (objData.value(forKey: "emails") as? NSArray)!
            if email.count==0
            {
                cell3.btnEmail.setTitle("NA",for: UIControlState.normal)
            }
           else
           {
            if (email.object(at: 0)as? String)==""
            {
                cell3.btnEmail.setTitle("NA",for: UIControlState.normal)
            }
            else{
            cell3.btnEmail.setTitle(email.object(at: 0)as? String,for: UIControlState.normal)
            }
        }
            }
            return cell3
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0:
            return 40.0
        case 1:
            return 40.0
        case 2:
            return 40.0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            if keyInfoArray.count==0
            {
                return 1
            }
            else
            {
            return keyInfoArray.count
            }
        case 1:
            if infoSetArray.count==0
            {
                return 1
            }
            else{
            return infoSetArray.count
            }
        case 2:
            if companyArray.count==0
            {
                return 1
            }
            else{
            return companyArray.count
            }
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 40.0
        }
        if indexPath.section == 1
        {
            return 60.0
        }
        else
        {
            return 150.0
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch (section) {
        case 0:
            let header1: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header1.contentView.addSubview(viewKeyInfoPeople)
        case 1:
            let header2: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header2.contentView.addSubview(viewInfosetPeople)
        case 2:
            let header4: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header4.contentView.addSubview(viewCompanyPeople)
        default:  break
        }
    }
    
}
