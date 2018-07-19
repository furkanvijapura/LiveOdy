//
//  CompanyProfileScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 21/11/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import MessageUI
var  arrTagsListCompany = NSArray()


class CompanyProfileScreen: UIViewController,UIScrollViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate
{
    @IBOutlet var btnCompanyName: UIButton!
    @IBOutlet var btnTypeName: UIButton!
    @IBOutlet var btnContactPerson: UIButton!
    @IBOutlet var btnWebSide: UIButton!
    @IBOutlet var btnPh_1: UIButton!
    @IBOutlet var img_ProfileCompany: UIImageView!
    @IBOutlet var profile_View: UIView!
    @IBOutlet weak var btnTagCount: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var PriceBook_btn: UIButton!
    @IBOutlet weak var increment_lbl: UILabel!
    @IBOutlet weak var Profile_btn: UIButton!
    @IBOutlet weak var More_Info: UIButton!
    @IBOutlet weak var Sales: UIButton!
    @IBOutlet weak var Config: UIButton!
    @IBOutlet weak var Task: UIButton!
    @IBOutlet weak var Stock: UIButton!
    @IBOutlet weak var Oppo: UIButton!
    @IBOutlet weak var Visit: UIButton!
    @IBOutlet weak var Link_btn2: UIButton!
    @IBOutlet weak var Link_btn1: UIButton!
    @IBOutlet weak var but: UIButton!
    @IBOutlet weak var Radio_but: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    var  arrCompanyProfiledata = NSArray()
    var  arrPriceBookList = NSArray()
    @IBOutlet weak var lblParentOrgName: UILabel!
    @IBOutlet weak var lblVatTinNo: UILabel!
    @IBOutlet weak var lblCastNo: UILabel!
    @IBOutlet weak var lblTypeName: UILabel!
    @IBOutlet weak var lblPriceBook: UILabel!
    @IBOutlet weak var lblTag2: UILabel!
    @IBOutlet weak var lblTag1: UILabel!
    @IBOutlet weak var lblPhone2: UILabel!
    @IBOutlet weak var lblPhone1: UILabel!
    @IBOutlet weak var lblRelationType: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    var companyId = NSString()
    var  strTitle = String()
    
    var strTinNo = String()
    var strParentOrgName = String()
    var GetValues = 0
    var Values = 0
    var attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 13.0) as Any,
                 NSUnderlineStyleAttributeName : 1 as Any]
    var attributedString1 = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")

    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.delegate = self
        self.title = "Company Profile"
        getCompanyProfile()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(CompanyProfileScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        More_Info.SetShadow()
        Sales.SetShadow()
        Visit.SetShadow()
        Stock.SetShadow()
        Task.SetShadow()
        Config.SetShadow()
        Oppo.SetShadow()
        print("companyId==",companyId)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnTagCountTapped(_ sender: Any)
    {
       // let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Custome_alert") as! Custome_alert
//        vc.resultsArray = self.resultsArray
       // self.navigationController?.pushViewController(vc, animated:true)
       // let objReg=self.storyboard?.instantiateViewController(withIdentifier: "PeopleProfileScreen") as!PeopleProfileScreen
    }
    func getCompanyProfile()
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "organization/profile/" + (companyId as String)) {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
        //    self.INDISTOP()

            if response != nil
            {
//                self.arrCompanyProfiledata = response!
                objInfo.CompanyProfileInfo(dicInfo: response!)
                arrTagsListCompany=objInfo.tagMasterProxys
                let tagValue1 : NSString = (arrTagsListCompany.object(at: 0) as AnyObject) .value(forKey: "text") as! NSString
                self.lblTag1.text=tagValue1 as String
                if arrTagsListCompany.count==1
                {
                    self.btnTagCount.isHidden=true
                }
                else if arrTagsListCompany.count==2
                {
                    self.btnTagCount.isHidden=true
                    let tagValue2 : NSString = (arrTagsListCompany.object(at: 1) as AnyObject) .value(forKey: "text") as! NSString
                    self.lblTag2.text=tagValue2 as String
                }
                else{
                    let tagValue2 : NSString = (arrTagsListCompany.object(at: 1) as AnyObject) .value(forKey: "text") as! NSString
                    self.lblTag2.text=tagValue2 as String
                    let finalPriceBookArray:NSArray = arrTagsListCompany as NSArray
                    let strCount = finalPriceBookArray.count
                    self.btnTagCount.isHidden=false
                    self.Values = strCount - 2
                    let p = ("+" + "\(self.Values)")
                    //self.increment_lbl.text=p
                    self.btnTagCount.setTitle(p, for: UIControlState.normal)
                }
                self.btnCompanyName.setTitle(objInfo.orgName as String, for:UIControlState.normal)
                self.strTitle=objInfo.orgName as String
                self.title=objInfo.orgName as String
                let webSide:String = objInfo.webSide as String
                if webSide==""
                {
                    self.btnWebSide.setTitle("NA", for: UIControlState.normal)
                }
                else{
                self.btnWebSide.setTitle(objInfo.webSide as String, for: UIControlState.normal)
                }
                let strContactName:String = objInfo.contactPerson as String
//                self.lblRelationType.text
                if strContactName==""
                {
                    self.btnContactPerson.setTitle("NA", for: UIControlState.normal)
                }
                else{
                    self.btnContactPerson.setTitle(strContactName, for: UIControlState.normal)
                }
                let arr1:NSArray = objInfo.companyContacts as NSArray
                if arr1.count==0
                {
                    self.btnPh_1.setTitle("NA", for: UIControlState.normal)
                    //self.btnPh_1.setTitle("NA", for: UIControlState.normal)
                }
                else if arr1.count==1
                {
                    let strarr1 = arr1.object(at: 0) as? String
                    if strarr1 == ""
                    {
                        self.btnPh_1.setTitle("NA", for: UIControlState.normal)
                    }
                    else{
                    //self.lblPhone1.text = arr1.object(at: 0) as? String
                        self.btnPh_1.setTitle(arr1.object(at: 0) as? String, for: UIControlState.normal)

                    }
                   // self.lblPhone2.text = "NA"
                }
              else if arr1.count==2
                {
                //self.lblPhone1.text = arr1.object(at: 0) as? String
                self.btnPh_1.setTitle((arr1.object(at: 0) as? String)! + "/" + (arr1.object(at: 1) as? String)!, for: UIControlState.normal)

                    
                //self.lblPhone2.text = arr1.object(at: 1) as? String
                }
                let arrEmail:NSArray = objInfo.companyEmails as NSArray
                if arrEmail.count==0
                {
                    self.Link_btn1.setTitle("NA", for: UIControlState.normal)
                    self.Link_btn2.setTitle("NA", for: UIControlState.normal)
                }
                else if arrEmail.count==1
                {
                    let strEmail1 = arrEmail.object(at: 0) as? String
                    if strEmail1 == ""
                    {
                        self.Link_btn1.setTitle("NA", for: UIControlState.normal)
                    }
                    else
                    {
                   self.Link_btn1.setTitle(arrEmail.object(at: 0) as? String, for: UIControlState.normal)
                    }
                   self.Link_btn2.setTitle("NA", for: UIControlState.normal)
                }
                else if arrEmail.count==2
                {
                    self.Link_btn1.setTitle(arrEmail.object(at: 0) as? String, for: UIControlState.normal)
                    self.Link_btn2.setTitle(arrEmail.object(at: 1) as? String, for: UIControlState.normal)
                }
                self.btnTypeName.setTitle(objInfo.typeName as String, for:UIControlState.normal)
                self.strParentOrgName = objInfo.parentOrgName as String
                self.strTinNo = objInfo.vatTinNo as String
                //if (objInfo.companyActive) == true
               // {
               //     self.Radio_but.setImage(UIImage(named : "status_green"), for: .normal)
               // }
                //else{
                 //   self.Radio_but.setImage(UIImage(named : "status_green"), for: .normal)
               // }
                if (objInfo.companyFavorites) == true
                {
                    self.but.setImage(UIImage(named : "star_contact"), for: .normal)
                }
                else{
                    self.but.setImage(UIImage(named : "star_unselect_contact"), for: .normal)
                }
                if objInfo.logoName != ""{
                    let imgprofile  = Constant.WEBSERVICE_URLUploadImage + objInfo.logoId.stringValue + "_" + objInfo.logoName
                                    let strValue:String = imgprofile + "?token=" + objInfo.Token
                    let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    let url = URL(string: urlString!)
                                   // let url = URL(string: strValue)
                                    let data = try? Data(contentsOf: url!)
                                    if data != nil{
                                        self.img_ProfileCompany.image = UIImage(data: data!)
                                    }
                                    else{
                                    }
                    }
            }
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
    @IBAction func PriceBook_act(_ sender: UIButton)
    {
    }
    @IBAction func Plus_act(_ sender: UIButton)
    {
    }
    @IBAction func Link1(_ sender: UIButton)
    {
        //            openUrl(urlStr: "http://fr.envisite.net/t5exce")
        //openUrl(urlStr: "https://www.google.co.in/")
    }
    @IBAction func Link2(_ sender: UIButton)
    {
        //            openUrl(urlStr: "http://fr.envisite.net/t5exce")
        //openUrl(urlStr: "https://www.youtube.com")
    }
    func openUrl(urlStr:String!)
    {
        if let url = NSURL(string:urlStr)
        {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    func CompanyProfileFavorites()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(companyId, forKey:"masterId")
        objDic .setValue("2", forKey:"favType")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "favorites/set")
        { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
        }
    }
    @IBAction func Star(sender: UIButton)
    {
        CompanyProfileFavorites()
        
        let img = UIImage(named: "star_contact")
        if sender.imageView?.image == img
        {
            but.setImage(UIImage(named : "star_unselect_contact"), for: .normal)
            //            but.setTitle("on", for: UIControlState.normal)
            print("Not select...")
        }
        else
        {
            but.setImage(UIImage(named : "star_contact"), for: .normal)
            //            but.setTitle("off", for:UIControlState.normal)
            print("select...")
        }
 
    }
    @IBAction func Radio(sender: UIButton)
    {
        let img = UIImage(named: "status_green")
        if sender.imageView?.image == img
        {
            Radio_but.setImage(UIImage(named : "status_green"), for: .normal)
            //            but.setTitle("on", for: UIControlState.normal)
            print("select...")
        }
        else
        {
            Radio_but.setImage(UIImage(named : "status_green"), for: .normal)
            //            but.setTitle("off", for:UIControlState.normal)
            print("Not select...")
        }
    }
    @IBAction func MoreInfo_act(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "CompanyMoreInfoScreen") as! CompanyMoreInfoScreen
            objReg.companyId=companyId
            objReg.strTitle=self.strTitle
            objReg.strTinNo=strTinNo
            objReg.strParentOrgName=strParentOrgName
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func Visit_act(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
//        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "VisitMainScreen") as! VisitMainScreen
//        objReg.isFilter=false
//        self.navigationController?.pushViewController(objReg, animated: true)
            getVisitList()
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func getVisitList()
    {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"VisitMainScreen") as! VisitMainScreen
        objReg.isFilter=false
        objReg.isCompanyProfileSide=true
        objReg.isPeopleProfileSide=false
        objReg.organizationCompanyProfileId = self.companyId
        objReg.userIdForVisitCount = Int(objInfo.UserId)
        objReg.orgIdFOrVisitCount = self.companyId
        // arrayMainListData = response!
        // print("arrayMainListData.count==",arrayMainListData.count)
        self.navigationController?.pushViewController(objReg, animated: true)
        /*
        START_INDICATOR()
        let objDataDic = NSMutableDictionary.init()
        objDataDic .setValue("",forKey:"fromDate")
        objDataDic .setValue("",forKey:"toDate")
        objDataDic .setValue("1",forKey:"personId")
        objDataDic .setValue(companyId, forKey: "organizationId")
        print(objDataDic)
        APISession.postDataWithRequestwithToken(objDataDic, withAPIName: "visitplan/getAllVisitPlan") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
//                let soList : NSArray = response! .value(forKey: "soList") as! NSArray
//                SOMainArray = soList
//                SOListData.removeAll()
//                SOListData = SOModel_List.GenrateSOModelData()
//                tablevaaaar.reloadData()
                let objReg=self.storyboard?.instantiateViewController(withIdentifier:"VisitMainScreen") as! VisitMainScreen
                objReg.isFilter=false
                objReg.isCompanyProfileSide=true
                objReg.organizationCompanyProfileId = self.companyId
               // arrayMainListData = response!
               // print("arrayMainListData.count==",arrayMainListData.count)
                self.navigationController?.pushViewController(objReg, animated: true)
            }
        }
 */
    }
    func getSalesList()
    {
        START_INDICATOR()
        let objDataDic = NSMutableDictionary.init()
        objDataDic .setValue("",forKey:"fromDateStr")
        objDataDic .setValue("",forKey:"toDateStr")
        objDataDic .setValue(companyId, forKey: "organizationId")
        print(objDataDic)
        APISession.postDataWithRequestwithTokenDelete(objDataDic, withAPIName: "saleOrder/list") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let soList : NSArray = response! .value(forKey: "soList") as! NSArray
                SOMainArray = soList
                SOListData.removeAll()
                SOListData = SOModel_List.GenrateSOModelData()
                tablevaaaar.reloadData()
                let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
                objReg.isBoolCompanyProfile = true
                self.navigationController?.pushViewController(objReg, animated: true)
            }
        }
    }
    @IBAction func Sales_act(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
            getSalesList()
//        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
//        self.navigationController?.pushViewController(objReg, animated: true)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnOpportunityTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        ShowAlert()
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnStockTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        ShowAlert()
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnTaskTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        ShowAlert()
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnConfigurationTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        ShowAlert()
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func Home(_ sender: Any)
    {
        if objInfo.contactPerson != ""{
            let url : NSURL = URL(string:objInfo.contactPerson as String)!as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
            else{
                displayAlertMessage(messageToDisplay: "Contact not found")
        }
    }
    @IBAction func Message(_ sender: Any)
    {
        if MFMessageComposeViewController.canSendText()
        {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [objInfo.contactPerson as String]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        else
        {
            print("can not sent....")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func Email(_ sender: Any)
    {
        let mailCompose = MFMailComposeViewController()
        mailCompose.mailComposeDelegate = self
        if objInfo.companyEmails.count != 0 {
               mailCompose.setToRecipients([objInfo.companyEmails.object(at: 0) as! String])
        }
        else{
            displayAlertMessage(messageToDisplay: "Email not found")
        }
     
       // mailCompose.setSubject("Testing")
       // mailCompose.setMessageBody("How are you...?", isHTML: false)
        
        if MFMailComposeViewController.canSendMail()
        {
            self.present(mailCompose, animated: true, completion: nil)
        }
        else
        {
            print("can not send mail...")
        }
    }
    
    @IBAction func Website(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
            if objInfo.webSide != ""{
            openUrl(urlStr: objInfo.webSide as String!)
            }
            displayAlertMessage(messageToDisplay: "Website not found")
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
}


