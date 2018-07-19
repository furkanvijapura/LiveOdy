//
//  Receive_Goods_Filter.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 12/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var GoodsID = String()
var GoodsValue = String()

class Receive_Goods_Filter: UIViewController {

    var FilterSo : [SOFilterSalesTypeModel] = SOFilterSalesTypeModel.generateSOFilterModelArray()
    
    var SOModel : [SOFilterSalesTypeModel] = SOFilterSalesTypeModel.generateSOFilterModelArray()
    
    @IBOutlet weak var fromDate : UITextField!
    @IBOutlet weak var toData : UITextField!
    @IBOutlet weak var txt_BuyerName : UITextField!
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let datePickerTo = UIDatePicker()
    let dateFormatterTo = DateFormatter()
    
    //MARK:- view Did Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Receive Good Filter"
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(OR_Filter.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        datePicker.addTarget(self, action: #selector(handleDatePickerFrom(sender:)), for: UIControlEvents.valueChanged)
        datePicker.datePickerMode = .date
        fromDate.inputView = datePicker
        
        dateFormatterTo.dateFormat = "dd MMM yyyy"
        datePickerTo.addTarget(self, action: #selector(handleDatePickerTo(sender:)), for: UIControlEvents.valueChanged)
        datePickerTo.datePickerMode = .date
        toData.inputView = datePickerTo
        
        fromDate.setDoneOnKeyboard()
        toData.setDoneOnKeyboard()
        
        ReceiveBuyerId = ""
        ReceiveBuyerValue = ""
    
        getRecevieGoodsFilterListing()
    }
    
    //MARK:- Date Picker Function
    
    func handleDatePickerFrom(sender: UIDatePicker) {
        
        fromDate.text = dateFormatter.string(from: datePicker.date)
    }
    
    func handleDatePickerTo(sender: UIDatePicker)
    {
        toData.text = dateFormatterTo.string(from: datePickerTo.date)
    }
    
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Buyer Name Action
    
    @IBAction func BuyerName_Action(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        let buyer = self.storyboard?.instantiateViewController(withIdentifier: "ReceiveGoodFilterBuyerNameList") as? ReceiveGoodFilterBuyerNameList
        
//        let navBar = UINavigationController(rootViewController: buyer!)
        
        self.present(buyer!, animated: true, completion: nil)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        if fromDate.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select from data....")
        }
        else if toData.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select to date....")
        }
//        else if txt_BuyerName.text == ""
//        {
//            displayAlertMessage(messageToDisplay: "Please select people name....")
//        }
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
        
    }
    
    //MARK:- View will Appear
    
    override func viewWillAppear(_ animated: Bool)
    {
        print(ReceiveBuyerValue)
        print(ReceiveBuyerId)
        
        txt_BuyerName.text = ReceiveBuyerValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }
    //MARK:- get So Filter Listing 
    func getRecevieGoodsFilterListing()
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "TertiaryInvt/goodReceived/filter")
        {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let FilterList : NSDictionary = response! .value(forKey: "goodReceivedFilter") as! NSDictionary
                BuyerNameList = FilterList.value(forKey: "buyerName") as! NSArray
            }
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    func PostData()
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        let objDataDic = NSMutableDictionary.init()
        objDataDic .setValue(fromDate.text, forKey: "fromDate")
        objDataDic .setValue(toData.text, forKey: "toDate")
        print(objDataDic)
        APISession.postDataWithRequestwithTokenDelete(objDataDic, withAPIName: "TertiaryInvt/goodReceived") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let dailySale : NSArray = response! .value(forKey: "receiveGoods") as! NSArray
                print(("dailySale is......",dailySale))
                ReceiveGoodsDicData = dailySale
                ReceiveGoodsData = ModelReceiveGoodsList.generateReceiveGoodArray()
                TableReceiveGoods.reloadData()
                self.navigationController?.popViewController(animated: true)
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
