//
//  SalesManagementDashboard.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 09/03/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

class SalesManagementDashboard: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblSalesList: UITableView!
    var tertiaryBool = Int()
    var orBool = Int()
    var soBool = Int()
    var soViewBool = Int()
    var orViewBool = Int()
    var moduelSalesName = ["Order Requisition","Sales Order","Tertiary Sales"]
    var moduleSalesImage = ["or_daskboard_gray","so_dashboard_gray","tertiary_dashboard_gray"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sales Management"
         self.setNavigationBarItem()
        orBool = (objInfo.permision.value(forKey: "CRM_ORDERREQUISITION") as? Int)!
        soBool = (objInfo.permision.value(forKey: "CRM_SALESORDER") as? Int)!
        tertiaryBool = (objInfo.permision.value(forKey: "CRM_TERTIARY") as? Int)!
        addUpdateSales = (objInfo.permision.value(forKey: "CRM_SALESORDER_ADDUPDATE") as? Int)!
        if Reachability.isConnectedToNetwork(){
        if orBool==1
        {
            getORListing()
        }
        if soBool==1
        {
            getSOListing()
        }
        if tertiaryBool==1
        {
            //getCompanyLists()
        }
        if orBool==0 && soBool==0 && tertiaryBool==0 {
           // displayAlertMessage(messageToDisplay: "Permission denied")
            ShowAlertForPermission()
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
       // self.setNavigationBarItem()
       // self.navigationController?.setNavigationBarHidden(false, animated: animated)
        getSOListing()
        if orBool==0 && soBool==0 && tertiaryBool==0 {
           // displayAlertMessage(messageToDisplay: "Permission denied")
            ShowAlertForPermission()
           // ShowAlert()
        }
    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if orBool==0 && soBool==0 && tertiaryBool==0 {
           // displayAlertMessage(messageToDisplay: "Permission denied")
            ShowAlertForPermission()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblSalesList.dequeueReusableCell(withIdentifier: "cell") as! SalesManagementDashboardCell
        cell.lblSAlesModuleName.text=moduelSalesName[indexPath.row]
        cell.imgSalesModule.image = UIImage(named: moduleSalesImage[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row==0{
            if soBool==1{
                return 70
            }
            else{
                return 0
            }
        }
        else if indexPath.row==1
        {
            if orBool==1{
                return 70
            }
            else{
                return 0
            }
        }
        else if indexPath.row==2
        {
            if tertiaryBool==1{
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
        if indexPath.row==1
        {
            if soBool==1{
                soViewBool = (objInfo.permision.value(forKey: "CRM_SALESORDER_VIEWPROFILE") as? Int)!
                if soViewBool==1{
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
                    objReg.isBoolCompanyProfile=false
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
                else{
                    ShowAlertForPermission()
                }
            }
        }
        else if indexPath.row==0
        {
            if orBool==1{
                orViewBool = (objInfo.permision.value(forKey: "CRM_ORDERREQUISITION_VIEW") as? Int)!
                if orViewBool==1{
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier:"ORListScreen") as! ORListScreen
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
                else{
                    ShowAlertForPermission()
                }
            }
        }
        else if indexPath.row==2
        {
            let objReg=self.storyboard?.instantiateViewController(withIdentifier:"TertiaryDashboardScreen") as! TertiaryDashboardScreen
            self.navigationController?.pushViewController(objReg, animated: true)
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
                let status : NSNumber = response!.value(forKey: "status") as! NSNumber
                if status != 0
                {
                let orList : NSArray = response! .value(forKey: "orList") as! NSArray
                ORDicData=orList
                ORListData.removeAll()
                ORListData = ModelORList.generateORModelArray()
                print("ORDicData :: ",ORDicData)
                    if refreshiingBoooo == false
                    {
    //                    refreshControl.endRefreshing()
                    }
                    else{
                        //refreshControl.endRefreshing()
                    }
                }
                //self.tblCompanyList.reloadData()
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
         START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "saleOrder/list")
        {
            (response, permissions) in
             self.STOP_INDICATOR()
            print(("",response))
            if response != nil
            {
                let status : NSNumber = response!.value(forKey: "status") as! NSNumber
                if status != 0
                {
                let soList : NSArray = response! .value(forKey: "soList") as! NSArray
                SOMainArray = soList
                SOListData.removeAll()
                SOListData = SOModel_List.GenrateSOModelData()
                if refreshiingBoooo == false
                {
                    //refreshControl.endRefreshing()
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
    
}
