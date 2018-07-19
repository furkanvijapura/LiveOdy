//
//  CompanyMoreInfoScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 01/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class CompanyMoreInfoScreen: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var viewPeople: UIView!
    @IBOutlet var viewAdditionalCompany: UIView!
    @IBOutlet var viewInfosetCompany: UIView!
    @IBOutlet var viewKeyInfoCompany: UIView!
    @IBOutlet weak var tblExpandSizing: UITableView!
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
    var strTitle  = String()
    var strDefaultPriceBook  = String()
    var arrayCompanyKeyInfo = NSArray()
    var arrayCompanyInfoset = NSArray()
    var arrayPeopleDetails = NSArray()
    var  arrPriceBookList = NSArray()
    var strParentOrgName  = String()
    var strCount  = String()
    
    @IBOutlet weak var textViewBilingAdd: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title=strTitle
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(CompanyMoreInfoScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
          print("0companyId==",companyId)
        self.tblExpandSizing.separatorStyle = UITableViewCellSeparatorStyle.none
        getCompanyMoreInfo()
        getPriceBook()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnPricebookPlusTapped(_ sender: Any)
    {
         print("self.arrPriceBookList.count......",self.arrPriceBookList.count)
         let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Custome_alert") as! Custome_alert
                vc.Data = self.arrPriceBookList
            self.present(vc, animated: true, completion: nil)
//         self.navigationController?.pushViewController(vc, animated:true)
//        self.arrayProductList = response!.value(forKey: "products") as! NSArray
//        // ORSellerNameList = response! .value(forKey: "data") as! NSArray
//        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SelectPricebookList") as? SelectPricebookList
    }
    
    func getCompanyMoreInfo()
    {
        START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "organization/more/" + (companyId as String)) {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response == nil
            {
            }
            else{
            self.arrayPeopleDetails = (response as AnyObject).value(forKey: "peopleDetails") as! NSArray
                self.arrayCompanyKeyInfo = (response as AnyObject).value(forKey: "keyInfo") as! NSArray
                self.arrayCompanyInfoset = (response as AnyObject).value(forKey: "infoSet") as! NSArray
                let objData : NSDictionary = (response as AnyObject).value(forKey: "billingAddress") as! NSDictionary
                self.strLine1 = (objData as AnyObject).value(forKey: "line1") as! String
                self.strLine2 = (objData as AnyObject).value(forKey: "line2") as! String
                self.strCityName = (objData as AnyObject).value(forKey: "cityName") as! String
                self.strStateName = (objData as AnyObject).value(forKey: "stateName") as! String
                self.strCountryName = (objData as AnyObject).value(forKey: "countryName") as! String
                self.strLine3 = (objData as AnyObject).value(forKey: "line3") as! String
                
                let objShippingAddress : NSArray = (response as AnyObject).value(forKey: "shippingAddress") as! NSArray
                self.strLine1Shipping  = ((objShippingAddress as AnyObject).object(at: 0) as AnyObject).value(forKey: "line1") as! String
                self.strLine2Shipping  = ((objShippingAddress as AnyObject).object(at: 0) as AnyObject).value(forKey: "line2") as! String
                self.strCityNameShipping  = ((objShippingAddress as AnyObject).object(at: 0) as AnyObject).value(forKey: "cityName") as! String
                self.strStateNameShipping  = ((objShippingAddress as AnyObject).object(at: 0) as AnyObject).value(forKey: "stateName") as! String
                self.strCountryNameShipping  = ((objShippingAddress as AnyObject).object(at: 0) as AnyObject).value(forKey: "countryName") as! String
                self.strLine3Shipping  = ((objShippingAddress as AnyObject).object(at: 0) as AnyObject).value(forKey: "line3") as! String
            }
            self.tblExpandSizing .reloadData()
        }
    }
//    func createSoPriceBookORAPIcalling()
//    {
//        let objDic:NSMutableDictionary=NSMutableDictionary.init()
//        objDic .setValue("productFromPricebook", forKey:"value")
//        objDic .setValue(soPricebookIDMain, forKey:"id")
//        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list") { (response, isVisit)
//            in
//            print(("Response is......",response))
//            if response != nil
//            {
//                self.arraySOProductList = response!.value(forKey: "products") as! NSArray
//            }
//        }
//    }
    var GetValues = 0
    var Values = 0
    func getPriceBook()
    {
//        APISession.getDataWithRequestWithToken (withAPIName: "pricebook") { (response, isVisit)
//            in
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("organizationPriceBook", forKey:"value")
        objDic .setValue(companyId, forKey:"id")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let status = response?.value(forKey: "status") as! NSNumber
                if status != 0
                {
                self.arrPriceBookList = response!.value(forKey: "data") as! NSArray
                if self.arrPriceBookList.count != 0{
                let priceBookValue : NSString = (self.arrPriceBookList.object(at: 0) as AnyObject) .value(forKey: "value") as! NSString
                if priceBookValue==""
                {
                    self.strDefaultPriceBook="NA"
                }
                else{
                self.strDefaultPriceBook=priceBookValue as String
                }
                if self.arrPriceBookList.count==1
                {
//                    self.PriceBook_btn.isHidden=true
                }
                else{
                    let finalPriceBookArray:NSArray = self.arrPriceBookList as NSArray
                    let strCountNo = finalPriceBookArray.count
                    // self.PriceBook_btn.isHidden=false
                    self.Values = strCountNo - 1
                    self.strCount = ("+" + "\(self.Values)")
                    //self.PriceBook_btn.setTitle(p, for: .normal)
                }
                }
                    else{
                        self.strDefaultPriceBook="NA"
                    }
                }
            }
            else{
//                self.lblPriceBook.text="NA"
//                self.PriceBook_btn.isHidden=true
            }
            self.tblExpandSizing .reloadData()
        }
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell0  = tableView.dequeueReusableCell(withIdentifier: "cell0") as! Address
            cell0.lblLine1.text = strLine1
            cell0.lblLine2.text = strLine2
            cell0.lblCityName.text = strCityName + "," + strStateName
            cell0.lblCountaryName.text = strCountryName
            cell0.lblLine3.text = strLine3
            cell0.lblLine1Shipping.text = strLine1Shipping
            cell0.lblLine2Shipping.text = strLine2Shipping
            cell0.lblCityNameShipping.text = strCityNameShipping + "," + strStateNameShipping
            cell0.lblCountryNameShipping.text = strCountryNameShipping
            cell0.lblLine3Shipping.text = strLine3Shipping
            return cell0
        }
        if indexPath.section == 1
        {
            let cell1  = tableView.dequeueReusableCell(withIdentifier: "cell1") as! expandCell
            if arrayCompanyKeyInfo.count==0
            {
                cell1.lblKeyLabletype.text="NA"
                cell1.lblKeyName.text="NA"
                
            }else
            {
            let objData : NSDictionary = self.arrayCompanyKeyInfo[indexPath.row] as! NSDictionary
            if let name : String = objData.value(forKey: "keyInfoValue") as? String
            {
                if  name==""
                {
                    cell1.lblKeyLabletype.text="NA"
                }else{
                cell1.lblKeyLabletype.text=name
                }
            }
            if let lable : String = objData.value(forKey: "keyInfoLabel") as? String
            {
                if  lable==""
                {
                    cell1.lblKeyName.text="NA"
                }else{

                cell1.lblKeyName.text=lable
                }
            }
            }
            return cell1
        }
        else if indexPath.section == 2
        {
            let cell2  = tableView.dequeueReusableCell(withIdentifier: "cell2") as! infoSet
            if arrayCompanyInfoset.count==0
            {
                cell2.lblOrgTypeName.text="NA"
                cell2.lblOrgTypeDetails.text="NA"
            }else
            {
            let objData : NSDictionary = self.arrayCompanyInfoset[indexPath.row] as! NSDictionary
            if objData.count==0
            {
                cell2.lblOrgTypeName.text="No Details Available"
            }
            if let orgname : String = objData.value(forKey: "organizationTypeName") as? String
            {
                cell2.lblOrgTypeName.text=orgname
            }
            if let detailsLbl : String = objData.value(forKey: "infoSetMoreLabel") as? String
            {
                if detailsLbl == ""
                {
                    cell2.lblOrgTypeDetails.text="NA"
                }
                else{
                cell2.lblOrgTypeDetails.text=detailsLbl
                }
            }
            if let detailsValue : String = objData.value(forKey: "infoSetMoreValue") as? String
            {
                if detailsValue == ""
                {
                    cell2.lblOrgValueDetails.text="NA"
                }
                else{
                cell2.lblOrgValueDetails.text=detailsValue
                }
            }
            }
            return cell2
        }
        else if indexPath.section == 3
        {
            let cell3  = tableView.dequeueReusableCell(withIdentifier: "cell3") as! AdditionalInfo
            if strTinNo==""
            {
                cell3.lblTinNo.text="NA"
            }
            else{
                cell3.lblTinNo.text=strTinNo

            }
            if strParentOrgName==""
            {
                cell3.lblParentOrgName.text="NA"
            }
            else{
                cell3.lblParentOrgName.text=strParentOrgName
            }
            cell3.lblDefaultPriceBook.text=strDefaultPriceBook
            cell3.btnPricebookPlus.setTitle(strCount, for: UIControlState.normal)
            cell3.btnPricebookPlus.isHidden=true

            if self.arrPriceBookList.count==1
            {
                cell3.btnPricebookPlus.isHidden=true
            }
           else if self.arrPriceBookList.count==0
            {
                cell3.btnPricebookPlus.isHidden=true
            }
            else
            {
            cell3.btnPricebookPlus.setTitle(strCount, for: UIControlState.normal)
                cell3.btnPricebookPlus.isHidden=false
            }
            return cell3
        }
        else
        {
            let cell4  = tableView.dequeueReusableCell(withIdentifier: "cell4") as! People
            if arrayPeopleDetails.count==0
            {
                cell4.lblUserName.text="NA"
                cell4.lblUserDesignation.text="NA"
                cell4.btnPh1.setTitle("NA",for: UIControlState.normal)
                cell4.btnPh2.setTitle("NA",for: UIControlState.normal)
                cell4.btnEmail.setTitle("NA",for: UIControlState.normal)

            }else
            {
            let objData : NSDictionary = self.arrayPeopleDetails[indexPath.row] as! NSDictionary
            let FN : String = (objData.value(forKey: "firstName") as? String)!
            let LN : String = (objData.value(forKey: "lastName") as? String)!
            let type : String = (objData.value(forKey: "designation") as? String)!
            cell4.lblUserName.text=FN + " " + LN
            cell4.lblUserDesignation.text=type
            
            let arr1:NSArray = (objData.value(forKey: "phone") as? NSArray)!
                  if arr1.count==0
                    {
                        cell4.btnPh1.setTitle("NA",for: UIControlState.normal)
                        cell4.btnPh2.setTitle("NA",for: UIControlState.normal)
                    }
                    else if arr1.count==1
                    {
                        let strarr1 = arr1.object(at: 0) as? String
                        if strarr1 == ""
                        {
                            cell4.btnPh1.setTitle("NA",for: UIControlState.normal)
                        }
                        else{
                            cell4.btnPh1.setTitle(arr1.object(at: 0)as? String,for: UIControlState.normal)
                        }
                        cell4.btnPh2.setTitle("NA",for: UIControlState.normal)
                    }
                    else if arr1.count==2
                    {
                         cell4.btnPh1.setTitle(arr1.object(at: 0)as? String,for: UIControlState.normal)
                        cell4.btnPh2.setTitle(arr1.object(at: 1)as? String,for: UIControlState.normal)
                    }
            
            let email:NSArray = (objData.value(forKey: "email") as? NSArray)!
            if email.count==0
            {
                cell4.btnEmail.setTitle("NA",for: UIControlState.normal)
            }
            else if email.count==1
            {
                let strEmail = email.object(at: 0) as? String
                if strEmail == ""
                {
                    cell4.btnEmail.setTitle("NA",for: UIControlState.normal)
                }
                else{
                    cell4.btnEmail.setTitle(email.object(at: 0)as? String,for: UIControlState.normal)
                }
                cell4.btnPh2.setTitle("NA",for: UIControlState.normal)
            }
            else
            {
                cell4.btnEmail.setTitle(email.object(at: 0)as? String,for: UIControlState.normal)
//                cell4.btnPh2.setTitle(email.object(at: 1)as? String,for: UIControlState.normal)
            }
            }
            return cell4
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0:
            return 0
        case 1:
            return 40.0
        case 2:
            return 40.0
        case 3:
            return 40.0
        case 4:
            return 40.0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch (section) {
        case 0:
            return 1
        case 1:
            if arrayCompanyKeyInfo.count==0
            {
                return 1
            }
            else{
            return arrayCompanyKeyInfo.count
            }
        case 2:
            if arrayCompanyInfoset.count==0
            {
                return 1
            }
            else{
                 return arrayCompanyInfoset.count
             }
           
        case 3:
            return 1
        case 4:
            if arrayPeopleDetails.count==0
            {
            return 1
            }
            else
            {
            return arrayPeopleDetails.count
            }
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 170.0
        }
        if indexPath.section == 1
        {
            return 40.0
        }
        else if indexPath.section == 2
        {
            return 60.0
        }
        else if indexPath.section == 3
        {
            return 90.0
        }
        else
        {
            return 150.0
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch (section) {
        case 0: break
        case 1:
            let header1: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header1.contentView.addSubview(viewKeyInfoCompany)
        case 2:
            let header2: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header2.contentView.addSubview(viewInfosetCompany)
        case 3:
            let header3: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header3.contentView.addSubview(viewAdditionalCompany)
        case 4:
            let header4: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header4.contentView.addSubview(viewPeople)
        default:  break
        }
    }
}
