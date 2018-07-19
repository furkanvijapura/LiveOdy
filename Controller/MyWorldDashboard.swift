//
//  MyWorldDashboard.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 07/03/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
import GooglePlaces

struct contactFilterBoolManagerrr {
   static var contactCompanyBool = Int()
   static var contactPersonBool = Int()
    static var productBool = Int()
}
class MyWorldDashboard: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var tblMyWorldList: UITableView!
    @IBOutlet weak var lblModuleName: UILabel!
    var visitBool = Int()
    
    var productViewBool = Int()
    
    var moduelName = ["Visits","Contacts","Product"]
    var moduleImage = ["visit_dashboard_gray","contact_daskboard_gray","product_daskboard_gray"]
    var count = Int()
    var appd:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        getVisitCount()
        let dicPermission: NSDictionary = objInfo.permision as NSDictionary
        print(dicPermission)
         visitBool = (objInfo.permision.value(forKey: "CRM_VISITPLAN") as? Int)!
        contactFilterBoolManagerrr.productBool = (objInfo.permision.value(forKey: "CRM_PRODUCT") as? Int)!
        contactFilterBoolManagerrr.contactCompanyBool = (objInfo.permision.value(forKey: "CRM_ORG") as? Int)!
        contactFilterBoolManagerrr.contactPersonBool = (objInfo.permision.value(forKey: "CRM_PERSON") as? Int)!
       // contactBool=1
        if visitBool==1
        {
        }
         if contactFilterBoolManagerrr.productBool==1
        {
            getProductLists()
        }
        if contactFilterBoolManagerrr.contactCompanyBool == 1 && contactFilterBoolManagerrr.contactPersonBool == 1
        {
            // picker editable
            getCompanyLists()
        }
        else if contactFilterBoolManagerrr.contactCompanyBool == 1 && contactFilterBoolManagerrr.contactPersonBool == 0
        {
            getCompanyFinalLists()
        }
        else  if contactFilterBoolManagerrr.contactCompanyBool == 0 && contactFilterBoolManagerrr.contactPersonBool == 1
        {
            getPersonFinalLists()
        }
        else{
            
        }
        if LoginBoooool == false
        {
            let appDelegateee = UIApplication.shared.delegate as! AppDelegate
            appDelegateee.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        }
        self.navigationItem.title = "My World"
        self.setNavigationBarItem()
        if let myImage = UIImage(named: "Gradient")
        {
            UINavigationBar.appearance().setBackgroundImage(myImage, for: .default)
            // UINavigationBar.appearance().backgroundColor=UIColor(red: 24, green: 71, blue: 127, alpha: 1.0)
            //            self.title = "Dashboard"
            self.navigationController?.navigationBar.barTintColor = UIColor.white
        }
        
        self.STOP_INDICATOR()

    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        if visitBool==0 && contactFilterBoolManagerrr.productBool==0 && contactFilterBoolManagerrr.contactCompanyBool==0 && contactFilterBoolManagerrr.contactPersonBool==0 {
             //displayAlertMessage(messageToDisplay: "Permission denied")
            ShowAlertForPermission()
        }
        if visitBool==1
        {
        }
        if contactFilterBoolManagerrr.productBool==1
        {
            getProductLists()
        }
        getVisitCount()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblMyWorldList.dequeueReusableCell(withIdentifier: "cell") as! MyWorldDashboardCell
        if moduelName[indexPath.row] == "Visits"{
            if Reachability.isConnectedToNetwork(){
                cell.lblCoutValue.text = "\(count)"
            }else{
                cell.imgCount.isHidden = true
                cell.lblCoutValue.isHidden = true
            }
            
        }else{
            cell.imgCount.isHidden = true
            cell.lblCoutValue.isHidden = true
        }
        cell.lblModuleName.text = moduelName[indexPath.row]
        cell.imgModule.image = UIImage(named: moduleImage[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row==0{
            if visitBool==1{
                return 70
            }
            else{
                return 0
            }
        }
        else if indexPath.row==1
        {
            if (contactFilterBoolManagerrr.contactCompanyBool==1 && contactFilterBoolManagerrr.contactPersonBool==1) || (contactFilterBoolManagerrr.contactCompanyBool==1 && contactFilterBoolManagerrr.contactPersonBool==0) || (contactFilterBoolManagerrr.contactCompanyBool==0 && contactFilterBoolManagerrr.contactPersonBool==1)
            {
                return 70
            }
            else
            {
                return 0
            }
        }
        else if indexPath.row==2
        {
            if contactFilterBoolManagerrr.productBool==1{
                return 70
            }
            else{
                return 0
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if Reachability.isConnectedToNetwork(){
            if indexPath.row==0
            {
                let objReg=self.storyboard?.instantiateViewController(withIdentifier: "VisitMainScreen") as! VisitMainScreen
                objReg.isFilter=false
                objReg.isCompanyProfileSide=false
                objReg.isPeopleProfileSide=false
                self.navigationController?.pushViewController(objReg, animated: true)
            }
            else if indexPath.row==1
            {
                let objReg=self.storyboard?.instantiateViewController(withIdentifier:"CompanyListScreen") as! CompanyListScreen
                objReg.isFilterArr=false
                self.navigationController?.pushViewController(objReg, animated: true)
            }
            else if indexPath.row==2
            {
                if contactFilterBoolManagerrr.productBool==1{
                    productViewBool = (objInfo.permision.value(forKey: "CRM_PRODUCT_VIEWPROFILE") as? Int)!
                    if productViewBool==1{
                        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"ProductListScreen") as! ProductListScreen
                        objReg.isFilterProduct=false
                        self.navigationController?.pushViewController(objReg, animated: true)
                    }
                    else{
                        ShowAlertForPermission()
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
    func getCompanyLists()
    {
        if Reachability.isConnectedToNetwork(){
                START_INDICATOR()
            APISession.getDataWithRequestWithToken( withAPIName:"common/contacts" )
            {
                (response, permissions) in
                 self.STOP_INDICATOR()
                print(("",response))
                if response != nil
                {
                    DicData = (response)!
                    ModelContact.removeAll()
                    ModelContact = Model.generateModelArray()
                    ModelContactFilterfilter.removeAll()
                    ModelContactFilterfilter = Model.generateModelArray()
                }
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func getCompanyFinalLists()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
               let objDic:NSMutableDictionary=NSMutableDictionary.init()
            objDic .setValue("1", forKey:"filterType")
            objDic .setValue("1", forKey:"filterStatus")
             APISession.postDataWithRequestwithToken(objDic, withAPIName: "common/contacts/filter")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                print(("",response))
                if response != nil
                {
                    DicData = (response)!
                    ModelContact.removeAll()
                    ModelContact = Model.generateModelArray()
                    ModelContactFilterfilter.removeAll()
                    ModelContactFilterfilter = Model.generateModelArray()
                }
            }
        }
        else
        {
            //            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func getPersonFinalLists()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            let objDic:NSMutableDictionary=NSMutableDictionary.init()
            objDic .setValue("2", forKey:"filterType")
            objDic .setValue("1", forKey:"filterStatus")
             APISession.postDataWithRequestwithToken(objDic, withAPIName: "common/contacts/filter")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                print(("",response))
                if response != nil
                {
                    DicData = (response)!
                    ModelContact.removeAll()
                    ModelContact = Model.generateModelArray()
                    ModelContactFilterfilter.removeAll()
                    ModelContactFilterfilter = Model.generateModelArray()
                }
            }
        }
        else
        {
            //            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func getProductLists()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataWithRequestWithToken( withAPIName: "product/getAllMinifiedProducts") {
                (response, permissions) in
                 self.STOP_INDICATOR()
                print(("",response))
                if response != nil
                {
                  DicDataProductList=(response)!
                    ModelProductlist1.removeAll()
                    ModelProductlistfilter.removeAll()
                    ModelProductlist1 = ModelProductlist.generateModelArray()
                    ModelProductlistfilter = ModelProductlist.generateModelArray()
                }
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    func getORListing()
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "orderRequisition/list")
        {
            (response, permissions) in
             self.STOP_INDICATOR()
            print(("",response))
            if response != nil
            {
                
                let status = response?.value(forKey: "status") as! Int
                if status != 0{
                    
                    let orList : NSArray = response! .value(forKey: "orList") as! NSArray
                    ORDicData=orList
                    ORListData.removeAll()
                    ORListData = ModelORList.generateORModelArray()
                    print("ORDicData :: ",ORDicData)
                    if refreshiingBoooo == false
                    {
                        refreshControl.endRefreshing()
                    }
                    else{
                        //refreshControl.endRefreshing()
                    }
                    tableeeORListScreen.reloadData()
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
    func getSOListing()
    {
        if Reachability.isConnectedToNetwork(){
        APISession.getDataWithRequest( withAPIName: "saleOrder/list")
        {
            (response, permissions) in
             self.STOP_INDICATOR()
            print(("",response))
            if response != nil
            {
                let status = response?.value(forKey: "status") as! Int
                if status != 0{
                    let soList : NSArray = response! .value(forKey: "soList") as! NSArray
                    SOMainArray = soList
                    SOListData.removeAll()
                    SOListData = SOModel_List.GenrateSOModelData()
                    if refreshiingBoooo == false
                    {
                        refreshControl.endRefreshing()
                    }
                    //generateSOAPprover = false
                    tablevaaaar.reloadData()
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
    func getVisitCount()
    {
        if Reachability.isConnectedToNetwork(){
            APISession.getDataWithRequest( withAPIName: "dashboard/visitsCounts/0/0/0")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                print(("",response))
                if response != nil
                {
                    self.count = response?.value(forKey: "todayPendingCounts") as! Int
                    if self.count != 0{
                        self.tblMyWorldList.reloadData()
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
}
