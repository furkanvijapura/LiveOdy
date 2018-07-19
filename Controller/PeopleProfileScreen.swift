//
//  PeopleProfileScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 05/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import MessageUI
var  arrTagsListPeople = NSArray()



class PeopleProfileScreen: UIViewController,UIScrollViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate
{
    @IBOutlet weak var btnPlusCount: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var increment_lbl: UILabel!
    @IBOutlet weak var Profile_btn: UIButton!
    
    @IBOutlet weak var profile_imgView: UIImageView!
    @IBOutlet weak var More_Info: UIButton!
    @IBOutlet weak var Sales: UIButton!
    @IBOutlet weak var Config: UIButton!
    @IBOutlet weak var Task: UIButton!
    @IBOutlet weak var UserInfo: UIButton!
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
    @IBOutlet weak var lblPersonDesignation: UILabel!
    @IBOutlet weak var lblPriceBook: UILabel!
    @IBOutlet weak var lblTag2: UILabel!
    @IBOutlet weak var lblTag1: UILabel!
    @IBOutlet weak var lblPhone2: UILabel!
    @IBOutlet weak var lblPhone1: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblPersonName: UILabel!
    @IBOutlet weak var btnPersonDesignation: UIButton!
    @IBOutlet var btnPhone1: UIButton!
    @IBOutlet var btnPhone2: UIButton!
    @IBOutlet var btnPersonName: UIButton!
    var strTitlePeople = String()
    var idForSalesPeopleProfile = Int()
    @IBOutlet var btnCompanyName: UIButton!
    var companyId = NSString()
    
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
        getPeopleProfile()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(PeopleProfileScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        
        //profile_imgView.layer.cornerRadius = profile_imgView.frame.width / 2
        More_Info.SetShadow()
        Sales.SetShadow()
        Visit.SetShadow()
        UserInfo.SetShadow()
        Task.SetShadow()
        Config.SetShadow()
        Oppo.SetShadow()
        print("companyId==",companyId)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnTagTapped(_ sender: Any) {
    }
    func getPeopleProfile()
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "person/profile/" + (companyId as String)) {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
          //  self.INDISTOP()
            if response != nil
            {
                let FN : NSString = response! .value(forKey: "firstName") as! NSString
                let LN : NSString = response! .value(forKey: "lastName") as! NSString
                let type : NSString = response! .value(forKey: "designation") as! NSString
                self.btnPersonName.setTitle((FN as String) + " " + ((LN as String) as String), for:UIControlState.normal)
                self.idForSalesPeopleProfile = response! .value(forKey: "userId") as! Int
                self.strTitlePeople=(FN as String) + " " + ((LN as String) as String)
                self.title = (FN as String) + " " + ((LN as String) as String)
                //"People Profile"
                self.btnPersonDesignation.setTitle(type as String, for: UIControlState.normal)
//                let orgName:NSDictionary = response!.value(forKey:"organization")as! NSDictionary
                let name : NSString = response! .value(forKey: "organizationName") as! NSString
                if name == ""
                {
                   self.btnCompanyName.setTitle("NA", for: UIControlState.normal)
                }
                else{
                   // self.lblCompanyName.text=name as String
                    self.btnCompanyName.setTitle(name as String, for: UIControlState.normal)
                }
                let email:NSArray = (response!.value(forKey: "email") as? NSArray)!
                if email.count==0
                {
                    self.btnEmail.setTitle("", for: UIControlState.normal)
                }
                else{
                    self.btnEmail.setTitle(email.object(at: 0) as? String, for: UIControlState.normal)
                }
                let arr1:NSArray = (response!.value(forKey: "phone") as? NSArray)!
                if arr1.count==0
                {
                   // self.lblPhone1.text="NA"
                   // self.lblPhone2.text="NA"
                    self.btnPhone1.setTitle("NA", for: UIControlState.normal)
                    self.btnPhone2.setTitle("NA", for: UIControlState.normal)
                }
                else if arr1.count==1
                {
                    let strarr1 = arr1.object(at: 0) as? String
                    if strarr1 == ""
                    {
                        self.btnPhone1.setTitle("NA", for: UIControlState.normal)
                    }
                    else{
                       //self.lblPhone1.text=arr1.object(at: 0)as? String
                        self.btnPhone1.setTitle(arr1.object(at: 0)as? String, for: UIControlState.normal)
                        self.btnPhone2.setTitle("NA", for: UIControlState.normal)
                    }
                }
                else if arr1.count==2
                {
                   // self.lblPhone1.text=arr1.object(at: 0)as? String
                    self.btnPhone1.setTitle(arr1.object(at: 0)as? String, for: UIControlState.normal)

                   // self.lblPhone2.text=arr1.object(at: 1)as? String
                    self.btnPhone2.setTitle(arr1.object(at: 1)as? String, for: UIControlState.normal)
                }
              //  let isActive : Bool = response! .value(forKey: "isActive") as! Bool
             //   if isActive == true
              //  {
              //      self.Radio_but.setImage(UIImage(named : "radio-on-button"), for: .normal)
               // }
               // else{
                 //   self.Radio_but.setImage(UIImage(named : "circle-outline"), for: .normal)
               // }
                let isFavrouite : Bool = response! .value(forKey: "favorites") as! Bool
                if isFavrouite == true
                {
                    self.but.setImage(UIImage(named : "star_contact"), for: .normal)
                }
                 else{
                    self.but.setImage(UIImage(named : "star_unselect_contact"), for: .normal)
                }
                let tagMasterProxys : NSArray = response! .value(forKey: "tagMasterProxys") as! NSArray
                arrTagsListPeople=tagMasterProxys
                if tagMasterProxys.count==0
                {
                    self.lblTag1.text="NA"
                    self.lblTag2.text="NA"
                    self.btnPlusCount.isHidden=true
                }
                else{
                let tagValue1 : NSString = (arrTagsListPeople.object(at: 0) as AnyObject) .value(forKey: "text") as! NSString
                self.lblTag1.text=tagValue1 as String
                if arrTagsListPeople.count==1
                {
                    self.btnPlusCount.isHidden=true
                }
                else if arrTagsListPeople.count==2
                {
                    self.btnPlusCount.isHidden=true
                    let tagValue2 : NSString = (arrTagsListPeople.object(at: 1) as AnyObject) .value(forKey: "text") as! NSString
                    self.lblTag2.text=tagValue2 as String
                }
                else{
                    let tagValue2 : NSString = (arrTagsListPeople.object(at: 1) as AnyObject) .value(forKey: "text") as! NSString
                    self.lblTag2.text=tagValue2 as String
                    let finalPriceBookArray:NSArray = arrTagsListPeople as NSArray
                    let strCount = finalPriceBookArray.count
                    self.btnPlusCount.isHidden=false
                    self.Values = strCount - 2
                    let p = ("+" + "\(self.Values)")
                    self.btnPlusCount.setTitle(p, for: UIControlState.normal)
                }
                }
                let logoName : String = response! .value(forKey: "logoName") as! String
                let logoId : Int = response! .value(forKey: "logoId") as! Int
                if logoName != ""{
                    let imgprofile  = Constant.WEBSERVICE_URLUploadImage + String(logoId) + "_" + logoName
                    let strValue:String = imgprofile + "?token=" + objInfo.Token
                    let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    let url = URL(string: urlString!)
                   // let url = URL(string: strValue)
                    let data = try? Data(contentsOf: url!)
                    if data != nil{
                        self.profile_imgView.image = UIImage(data: data!)
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
        openUrl(urlStr: "https://www.google.co.in/")
    }
    @IBAction func Link2(_ sender: UIButton)
    {
        openUrl(urlStr: "https://www.youtube.com")
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
        objDic .setValue("1", forKey:"favType")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "favorites/set")
        { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
        }
    }
    @IBAction func Star(sender: UIButton)
    {
        if Reachability.isConnectedToNetwork(){
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
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
 
    }
    @IBAction func Radio(sender: UIButton)
    {
        let img = UIImage(named: "status_green")
        if sender.imageView?.image == img
        {
            Radio_but.setImage(UIImage(named : "status_green"), for: .normal)
            print("select...")
        }
        else
        {
            Radio_but.setImage(UIImage(named : "status_green"), for: .normal)
            print("Not select...")
        }
    }
    @IBAction func MoreInfo_act(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "PeopleMoreInfoScreen") as! PeopleMoreInfoScreen
       objReg.companyId=companyId
        objReg.strTitlePeople=strTitlePeople
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
              print("idForSalesPeopleProfile=",idForSalesPeopleProfile)
            if idForSalesPeopleProfile == 0{
                displayAlertMessage(messageToDisplay: "Visit not found for this Person.")
            }
            else{
                let objReg=self.storyboard?.instantiateViewController(withIdentifier: "VisitMainScreen") as! VisitMainScreen
                objReg.isFilter=false
               // objReg.isCompanyProfileSide=true
                objReg.isPeopleProfileSide=true
                objReg.organizationCompanyProfileId = String(self.idForSalesPeopleProfile) as NSString
                objReg.userIdForVisitCount = idForSalesPeopleProfile
                objReg.orgIdFOrVisitCount = "0"
                self.navigationController?.pushViewController(objReg, animated: true)
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func Sales_act(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
             print("idForSalesPeopleProfile=",self.idForSalesPeopleProfile)
            if self.idForSalesPeopleProfile == 0{
                displayAlertMessage(messageToDisplay: "Sales not found for this Person.")
            }
            else{
              PostDataSalesPeople()
            }
//        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
//        self.navigationController?.pushViewController(objReg, animated: true)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    func PostDataSalesPeople()
    {
        START_INDICATOR()
        let objDataDic = NSMutableDictionary.init()
        objDataDic .setValue("", forKey: "fromDateStr")
        objDataDic .setValue("", forKey: "toDateStr")
        objDataDic .setValue(idForSalesPeopleProfile, forKey: "createdBy")
//        objDataDic .setValue(SoOrgId, forKey: "organizationId")
        print(objDataDic)
        APISession.postDataWithRequestwithTokenDelete(objDataDic, withAPIName: "saleOrder/list") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let status : NSNumber = response! .value(forKey: "status") as! NSNumber
                if status == 0{
                    let alert = UIAlertController(title:"", message:"Error while getting Sales Order.", preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .default, handler:
                    {
                        (alert:UIAlertAction!) -> Void in
                    })
                    alert.addAction(cancelAction)
                    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                    alertWindow.rootViewController = UIViewController()
                    alertWindow.windowLevel = UIWindowLevelAlert + 1;
                    alertWindow.makeKeyAndVisible()
                    alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
                }
                else{
                    let soList : NSArray = response! .value(forKey: "soList") as! NSArray
                    SOMainArray = soList
                    SOListData.removeAll()
                    SOListData = SOModel_List.GenrateSOModelData()
                    tablevaaaar.reloadData()
                    //self.navigationController?.popToRootViewController(animated: true)
//                    self.navigationController?.popViewController(animated: true)
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
                    objReg.isBoolCompanyProfile = true
//                    if self.idForSalesPeopleProfile == 0{
//                        displayAlertMessage(messageToDisplay: "No sales available for this person.")
//                    }
//                    else{
                        self.navigationController?.pushViewController(objReg, animated: true)
                    //}
                }
            }
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
    @IBAction func btnUserInfoTapped(_ sender: Any)
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
            controller.recipients = ["123456789"]
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
        openUrl(urlStr: "https://www.google.co.in/")
    }
}
