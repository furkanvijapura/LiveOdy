//
//  DailySalesScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 27/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
import Floaty

var tableTerstiaryyyy = Bool()
class DailySalesScreen: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate
{
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var txtEnable: UITextField!
    @IBOutlet weak var tblDailySalesList: UITableView!
    @IBOutlet weak var searchBarCompany: UISearchBar!
    var  arrDailySalesdata = NSArray()
    var  arrSelectData = NSMutableArray()
    var arrAutosearchProduct = NSArray()
    var searchActive : Bool = false
    var Booool:Bool = true
    var floaty = Floaty()
    var dailyUpdateSalesBool = Int()
    var fromIndex = 0
    let batchSize = 200
    var TotalCount = 0
    var searchpagingBooool = Bool()
    var IndicatorPaginBooool = Bool()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Daily Sales List"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(DailySalesScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        START_INDICATOR()
        TertiaryData.removeAll()
        TertiaryFilterData.removeAll()
        TertiaryDicData.removeAllObjects()
        addDoneButtonOnKeyboard()
        dailyUpdateSalesBool = (objInfo.permision.value(forKey: "CRM_TERTIARY_UPDATESALES_ADD") as? Int)!
        self.layoutFAB()
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.tblDailySalesList.addSubview(refreshControl)
        
        // For Pagination
        fromIndex = 0
        tableTerstiaryyyy = false
        refreshiingBoooo = false
        searchpagingBooool = true
        IndicatorPaginBooool = true
        GetTertiaryList(ListIndexf: IntMax(fromIndex))
        tblDailySalesList.reloadData()
    }
//     func viewWillAppear(animated: Bool) {
//
//        //super.viewWillAppear(animated)
//        //TertiaryDicData.removeAllObjects()
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
        if tableTerstiaryyyy == true {
            searchpagingBooool = false
            IndicatorPaginBooool = false
            tblDailySalesList.reloadData()
        }else{
            searchpagingBooool = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View has appeared")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        TertiaryDicData.removeAllObjects()
        IndicatorPaginBooool = true
        tableTerstiaryyyy = false
        searchpagingBooool = true
        fromIndex = 0
        GetTertiaryList(ListIndexf: IntMax(fromIndex))
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(DailySalesScreen.doneButtonAction))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        self.searchBarCompany.inputAccessoryView = doneToolbar
    }
    func doneButtonAction()
    {
        
        if searchBarCompany.text == ""
        {
           TertiaryFilterData = TertiaryData
        }
        else
        {
            searchBarCompany.text = ""
            if (searchBarCompany.text!.isEmpty) {
                TertiaryData = TertiaryFilterData
                tblDailySalesList.reloadData()
            }
            else
            {
                
                filterTableView(text: searchBarCompany.text!)
            }
        }
        self.searchBarCompany.resignFirstResponder()
    }
    func back(sender: UIBarButtonItem)
    {
        TertiaryData = TertiaryFilterData
        tblDailySalesList.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }
    //MARK: - For floting method=============================
    
    func layoutFAB()
    {
        if dailyUpdateSalesBool==1{
        floaty.addItem("Update Daily Sales", icon: UIImage(named: "create_or"))
        {
            item in
            let objReg = self.storyboard?.instantiateViewController(withIdentifier: "DailySalesSummary") as! DailySalesSummary
            //UpdateDailySalesScreen
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        }
        floaty.paddingX = 20
        floaty.paddingY = 20
        floaty.fabDelegate = self as? FloatyDelegate
        self.view.addSubview(floaty)
    }
   
    func GetTertiaryList(ListIndexf : IntMax)
    {
        if Reachability.isConnectedToNetwork(){
            //START_INDICATOR()
            //APISession.getDataWithRequest(withAPIName: "TertiaryInvt/sales")
            APISession.getDataWithRequest(withAPIName: "TertiaryInvt/sales/\(ListIndexf)/\(batchSize)")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                print((".....::",response))
                
                if response != nil
                {
                 
                    let status : NSNumber = response!.value(forKey: "status") as! NSNumber
                    if status != 0
                    {
                        self.TotalCount = response! .value(forKey: "dailySalesTotalCount") as! Int
                        let DailySalesList  = response! .value(forKey: "dailySales") as! NSArray
                        for data in 0..<DailySalesList.count
                        {
                            let IndexWiseDATA = DailySalesList.object(at: data)
                            TertiaryDicData.add(IndexWiseDATA)
                        }
                        print("TertiaryDicData=",TertiaryDicData,"DATA COUNT :",TertiaryDicData.count)
                        TertiaryData = ModelTetiaryList.generateTertiaryListArray()
                        self.tblDailySalesList.reloadData()
                    }
                }
                refreshControl.endRefreshing()
            }
        }else{
            self.displayAlertMessage(messageToDisplay: "Internet connectinon loast")
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                
                let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                spinner.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                self.tblDailySalesList.tableFooterView = spinner
                
                 if IndicatorPaginBooool == true {
                    self.tblDailySalesList.tableFooterView?.isHidden = false
                    print("IndicatorPaginBooool ==>> true")
                 }
                 else
                 {
                    print("IndicatorPaginBooool ==>> false")
                    self.tblDailySalesList.tableFooterView?.isHidden = true
                 }
            }
        
    }
    func tableView(_ tableView:  UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TertiaryData.count        // return 15
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DailySalesListCell
        let model = TertiaryData[indexPath.row]
        if searchpagingBooool == true {
            if indexPath.row == TertiaryData.count - 1 {
                if indexPath.row != TotalCount{
                    fromIndex += 1
                    GetTertiaryList(ListIndexf : IntMax(fromIndex))
                }
            }
        }
        cell.lblProductName.text = model.OutletName
        cell.btnQty.setTitle(String(model.tSaleStock) + " " + "Qty", for: .normal)
        cell.btnCreatDate.setTitle(model.tSaleDate, for: .normal)
        cell.btnTertiaryNumber.text = model.tSaleNo
        cell.btncreatorName.setTitle(model.CreatedBy, for: .normal)
        if model.tSaleStatus=="Draft"
        {
            cell.lblStatus.backgroundColor=UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
            cell.lblStatus.text = model.tSaleStatus
        }
        else
        {
            //cell.lblStatus.backgroundColor = UIColor(red: 125/255, green: 196/255, blue: 122/255, alpha: 1.0)
            cell.lblStatus.backgroundColor=UIColor(red: 44/255, green: 123/255, blue: 180/255, alpha: 1.0)
            cell.lblStatus.text = model.tSaleStatus
        }
        /*
         if model.status=="Pending SO"
         {
         cell.lblSataus.backgroundColor=UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1.0)
         }
         else if model.status=="Cancelled"
         {
         cell.lblSataus.backgroundColor=UIColor(red: 255/255, green: 88/255, blue: 98/255, alpha: 1.0)
         }
         else if model.status=="Draft"
         {
         cell.lblSataus.backgroundColor=UIColor(red: 0/255, green: 152/255, blue: 199/255, alpha: 1.0)
         }
         else
         {
         cell.lblSataus.backgroundColor=UIColor(red: 125/255, green: 196/255, blue: 122/255, alpha: 1.0)
         }*/
        
        return cell
    }
    
    func filterTableView(text:String)
    {
        
        TertiaryFilterData = ModelTetiaryList.generateTertiaryListArray()
        TertiaryData = TertiaryFilterData.filter({ (mod) -> Bool in
            return mod.OutletName.lowercased().contains(text.lowercased()) || mod.tSaleNo.lowercased().contains(text.lowercased()) || mod.CreatedBy.lowercased().contains(text.lowercased()) || mod.tSaleDate.lowercased().contains(text.lowercased()) || mod.tSaleStatus.lowercased().contains(text.lowercased())
        })
        self.tblDailySalesList.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarCompany.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        searchpagingBooool = false
         IndicatorPaginBooool = false
        if  tableTerstiaryyyy == false{
            searchpagingBooool = false
            IndicatorPaginBooool = true
        }
        if searchText.isEmpty {
            TertiaryData = TertiaryFilterData
            tblDailySalesList.reloadData()
        }
        else
        {
           
            filterTableView(text: searchText)
        }
    }
    
   
    
    @IBAction func btnFilterTapped(_ sender: Any) {
        
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"DailySalesFilter") as! DailySalesFilter
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = TertiaryData[indexPath.row]
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"DailyTertiarySalesProfileScreen") as! DailyTertiarySalesProfileScreen
        objReg.strDailySalesNo = model.tSaleNo as String
        //objReg.orSalesTypeId=model.salesTypeId as NSString
        self.navigationController?.pushViewController(objReg, animated: true)
    }
}
