//
//  DailySalesFilter.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 27/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

class DailySalesFilter: UIViewController {

    @IBOutlet var txtCreatedBy: UITextField!
    @IBOutlet var txtStatus: ImageTextField!
    @IBOutlet var txtRetailer: ImageTextField!
    @IBOutlet var txtToDate: ImageTextField!
    @IBOutlet var txtFromDate: ImageTextField!
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let datePickerTo = UIDatePicker()
    let dateFormatterTo = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Daily Sales Filter"

        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(DailySalesFilter.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        
//        txtFromDate.setDoneOnKeyboard()
//        txtToDate.setDoneOnKeyboard()
//        txtStatus.setDoneOnKeyboard()
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        datePicker.addTarget(self, action: #selector(handleDatePickerFrom(sender:)), for: UIControlEvents.valueChanged)
        txtFromDate.inputView = datePicker
        datePicker.datePickerMode = .date
        
        dateFormatterTo.dateFormat = "dd MMM yyyy"
        datePickerTo.addTarget(self, action: #selector(handleDatePickerTo(sender:)), for: UIControlEvents.valueChanged)
        txtToDate.inputView = datePickerTo
        datePickerTo.datePickerMode = .date
        txtFromDate.setDoneOnKeyboard()
        txtToDate.setDoneOnKeyboard()
        
        getDailySalesFilterListing()
            retailerValue = ""
            createValue = ""
            statusValue = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Date Picker Function
    
    func handleDatePickerFrom(sender: UIDatePicker) {
        
        txtFromDate.text = dateFormatter.string(from: datePicker.date)
    }
    
    func handleDatePickerTo(sender: UIDatePicker)
    {
        txtToDate.text = dateFormatterTo.string(from: datePickerTo.date)
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        if txtFromDate.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select from data....")
        }
        else if txtToDate.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select to date....")
        }
//
        else{
            //            getSOFilterListing()
            PostData()
            
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
        
//        ShowAlert()
    }
    func back(sender: UIBarButtonItem)
    {
        _ = navigationController?.popViewController(animated: true)
    }

    //MARK:- View will Appear
    
    override func viewWillAppear(_ animated: Bool)
    {   print(retailerValue)
        print(createValue)
        print(statusValue)
        
        txtRetailer.text = retailerValue
        txtCreatedBy.text = createValue
        txtStatus.text = statusValue
    }
    
    @IBAction func btnCreaterByTapped(_ sender: Any)
    {
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "DailySalesFilterCreaterNameList") as? DailySalesFilterCreaterNameList
        self.present(destination1!, animated: false, completion: nil)
    }
    @IBAction func btnRetailerTapped(_ sender: Any)
    {
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "DailySalesFilterRetailerNameList") as? DailySalesFilterRetailerNameList
        self.present(destination1!, animated: false, completion: nil)
    }
    @IBAction func btnStatusTapped(_ sender: Any)
    {
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "DailySalesFilterStatusList") as? DailySalesFilterStatusList
        self.present(destination1!, animated: false, completion: nil)
    }
        @IBAction func btnCancelTapped(_ sender: Any)
    {
        _ = navigationController?.popViewController(animated: true)
    }
    //MARK:- get So Filter Listing
    func getDailySalesFilterListing()
    {
         START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "TertiaryInvt/sales/filter")
        {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
            let FilterList : NSDictionary = response!.value(forKey: "dailySalesFilter") as! NSDictionary
                CreatedBy = FilterList.value(forKey: "createdBy") as! NSArray
                SalesListStatus = FilterList.value(forKey: "salesListStatus") as! NSArray
                Retailer = FilterList.value(forKey: "retailer") as! NSArray
            }
        }
    }
    func PostData()
    {
        START_INDICATOR()
        let objDataDic = NSMutableDictionary.init()
        objDataDic .setValue(txtFromDate.text, forKey: "fromDate")
        objDataDic .setValue(txtToDate.text, forKey: "toDate")
        objDataDic .setValue(createId, forKey: "createdById")
        objDataDic .setValue(statusId, forKey: "statusId")
        objDataDic .setValue(retailerId, forKey: "organizationId")
        print(objDataDic)
        APISession.postDataWithRequestwithTokenDelete(objDataDic, withAPIName: "TertiaryInvt/sales") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                TertiaryData.removeAll()
                TertiaryFilterData.removeAll()
                TertiaryDicData.removeAllObjects()
                let dailySale : NSArray = response! .value(forKey: "dailySales") as! NSArray
                if dailySale.count != 0
                {
                    for data in 0..<dailySale.count
                    {
                        let IndexWiseDATA = dailySale.object(at: data)
                        TertiaryDicData.add(IndexWiseDATA)
                    }
                    
                }
                
                }
                TertiaryData = ModelTetiaryList.generateTertiaryListArray()
                tableTerstiaryyyy = true
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
//}
