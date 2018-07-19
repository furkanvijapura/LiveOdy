//
//  DailySalesSummary.swift
//  Odin_App_Project_Swift
//  Created by Sunil Yadav on 29/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.

import UIKit

var CountProduct = NSMutableArray()
class DailySalesSummary: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate
{
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
     let calender = Calendar.current
    var isEditProduct = Bool()
    
    var bool = Bool()
    @IBOutlet var viewFooter: UIView!

    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnApprove: UIButton!
    @IBOutlet var txtDate: ImageTextField!
    @IBOutlet var tbldailySalesSummary: UITableView!
    var Str = String()
    var DateConfigration = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd MMM yyyy"
        self.title="Daily Sales Form"
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(DailySalesSummary.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        isEditProduct=false
        viewFooter.isHidden=true
        DailySalesRetailerValue = ""
        DailySalesRetailerID = ""
        DailySalesProductValue = ""
        DailySalesProductID = ""
        let config : NSDictionary = UserDefaults.standard.value(forKey: "configurations") as! NSDictionary
        DateConfigration = config.value(forKey: "DAILY_SALES_ADDDATE") as! String
        for _ in 0..<CountProduct.count
        {
            arrInputValueQty.add("0")
        }
//        self.addDoneButtonOnKeyboard()
        getDailySalesRetailerListing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool)
    {
        for _ in 0..<CountProduct.count
        {
            arrInputValueQty.add("")
        }
        if isEditProduct==true
        {
            viewFooter.isHidden=false
            tbldailySalesSummary.reloadData()
        }
        else{
            viewFooter.isHidden=true
            tbldailySalesSummary.reloadData()
        }
    }
    func back(sender: UIBarButtonItem)
    {
        _ = navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    func handleDatePicker(sender: UIDatePicker)
    {
        let cell = tbldailySalesSummary.dequeueReusableCell(withIdentifier: "cell") as! DailySalesSummaryDetailsCell
        cell.txtDate.text = dateFormatter.string(from: datePicker.date)
        Str = dateFormatter.string(from: datePicker.date)
        tbldailySalesSummary.reloadData()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0:
            return 1
        case 1:
            if DailySalesProductList.count==0
            {
                viewFooter.isHidden=true
                return 0
            }
            else{
            if isEditProduct==true
            {
               // viewFooter.isHidden=false
                return CountProduct.count
            }
            else
            {
                return 0
            }
            }
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            return 100
        default:break
        }
        return 0
    }
    
    func getDailySalesProductListing(Id:String)
    {
        let convertStr = Str.replacingOccurrences(of: " ", with: "%20")
        let str001 = "TertiaryInvt/retailer/" + Id + "/products/" + convertStr
        print(str001)
        APISession.getDataWithRequest( withAPIName: str001)
        {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                DailySalesProductList = response!.value(forKey: "products") as! NSArray
                arrayProductListsDailyTertiary = response!.value(forKey: "products") as! NSArray
                let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "DailySalesSelectProduct") as! DailySalesSelectProduct
                self.present(destination1, animated: false, completion: nil)
            }
        }
    }
    
    //=================All button click action here:===========
    @IBAction func btnProductListTapped(_ sender: Any)
    {
        if Str  != ""{
            isEditProduct=true
            if DailySalesRetailerID == ""{
                displayAlertMessage(messageToDisplay: "Please select retailer name")
            }
            else{
                getDailySalesProductListing(Id:DailySalesRetailerID)
            
            }
        }else{
           displayAlertMessage(messageToDisplay: "Please select retailer name")
        }
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        bool = false
        self.Create_Post()

    }
    @IBAction func btnRetailerNameTapped(_ sender: Any)
    {
        isEditProduct=false
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "DailySalesRetailerNameList") as? DailySalesRetailerNameList
        self.present(destination1!, animated: false, completion: nil)
        
    }
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnApproveTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        bool = true
        self.Create_Post()
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tbldailySalesSummary.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DailySalesSummaryDetailsCell
            
            cell.txtDate.inputView = datePicker
            cell.txtDate.setDoneOnKeyboard()
            
            dateFormatter.dateFormat = "dd MMM yyyy"
            datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
            datePicker.datePickerMode = .date
            //start
            
            let mindateCompo = calender.dateComponents([.day,.month,.year], from: Date())
            print(mindateCompo.day!)
            if mindateCompo.day! <= Int(DateConfigration)!
            {
                let currentCalendar = NSCalendar.current
                let dateComponents = NSDateComponents()
                let minus = mindateCompo.day! - 1
                print(minus)
                dateComponents.month = -1
                dateComponents.day = -minus
                let oneMonthBack = currentCalendar.date(byAdding: dateComponents as DateComponents, to: NSDate() as Date)
                print(oneMonthBack!)
                let Max = calender.date(from: mindateCompo)
                print(Max!)
                self.datePicker.minimumDate = oneMonthBack
                self.datePicker.maximumDate = Max
            }
            else
            {
                let mindateCompo1 = self.calender.dateComponents([.month,.year], from: Date())
                let min1 = self.calender.date(from: mindateCompo1)
                print(min1!)
                let Max = self.calender.date(from: mindateCompo)
                print(Max!)
                self.datePicker.minimumDate = min1
                self.datePicker.maximumDate = Max
            }
            //end
            
            cell.txtDate.text = dateFormatter.string(from: datePicker.date)
            Str = dateFormatter.string(from: datePicker.date)
            cell.txtRetailer.text = DailySalesRetailerValue
//            cell.txtProductList.text = DailySalesProductValue
            print(DailySalesRetailerValue)

            return cell
        case 1:
            let cell = tbldailySalesSummary.dequeueReusableCell(withIdentifier: "Daily", for: indexPath) as! DailySalesSummaryProductsCell
            //  cell.txtSoldQty.setDoneOnKeyboard()
   
            let PName = ((CountProduct.object(at: indexPath.row)as AnyObject).value(forKey: "productName")as! String)
            print(PName)
            
            if isEditProduct == true
            {
                cell.lblProductName.text = ((CountProduct.object(at: indexPath.row)as AnyObject).value(forKey: "productName")as! String)
                cell.lblcategoryName.text = ((CountProduct.object(at: indexPath.row)as AnyObject).value(forKey: "productCatName")as! String)
                cell.lblSku.text = ((CountProduct.object(at: indexPath.row)as AnyObject).value(forKey: "sku")as! String)
                
                let quty = ((CountProduct.object(at: indexPath.row)as AnyObject).value(forKey: "avalQty")as! Double)
                if 0 > quty {
                    cell.txtSoldQty.isUserInteractionEnabled = false
                    viewFooter.isHidden = true
                }else{
                    cell.txtSoldQty.isUserInteractionEnabled = true
//                    viewFooter.isHidden = false
                }
                cell.Lbl_Qty.text = String(quty)
                //cell.btnQty.setTitle("\(quty)", for: .normal)
                cell.txtSoldQty.setDoneOnKeyboard()
                
                let strQtyValue = arrInputValueQty.object(at: indexPath.row) as? String
                
                if strQtyValue == ""
                {
                    cell.txtSoldQty.text = ""
                }
                else
                {
                    cell.txtSoldQty.text = strQtyValue
                }
            }
             return cell
        default :
            let cell = tbldailySalesSummary.dequeueReusableCell(withIdentifier: "Daily", for: indexPath) as! DailySalesSummaryDetailsCell
            return cell
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        let pointInTable:CGPoint = textField.superview!.convert(textField.frame.origin, to:tbldailySalesSummary)
        print(pointInTable)
        let cell = tbldailySalesSummary.dequeueReusableCell(withIdentifier: "Daily") as! DailySalesSummaryProductsCell
        //  cell.txtSoldQty.setDoneOnKeyboard()
        //        var contentOffset:CGPoint = Table.contentOffset
        var contentOffset:CGPoint =  CGPoint(x: 0, y: 0)
        print(contentOffset)
        //        Table.contentOffset = CGPoint(x: 0, y: 10)
        
        contentOffset.y  = pointInTable.y
        cell.txtSoldQty = textField
        if let accessoryView = textField.inputAccessoryView
        {
            contentOffset.y -= accessoryView.frame.size.height
        }
        tbldailySalesSummary.contentOffset = contentOffset
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
    var arrInputValueQty = NSMutableArray()
    func textFieldDidEndEditing(_ textField: UITextField) {
        tbldailySalesSummary.contentOffset = CGPoint(x: 0, y: 0)
        let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to: self.tbldailySalesSummary)
        let indexPath = self.tbldailySalesSummary.indexPathForRow(at: buttonPosition)
        let cell = self.tbldailySalesSummary.cellForRow(at: indexPath!) as! DailySalesSummaryProductsCell
        
        let strInputValueWithTag : String = String(format: "%@",cell.txtSoldQty.text!)
        arrInputValueQty.replaceObject(at: (indexPath?.row)!, with: strInputValueWithTag)
        print(arrInputValueQty)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        let cell = tbldailySalesSummary.dequeueReusableCell(withIdentifier: "Daily") as! DailySalesSummaryProductsCell
        print(cell.txtSoldQty.text!)
        cell.txtSoldQty = textField
        var contentOffset:CGPoint =  CGPoint(x: 0, y: 0)
        if let accessoryView = textField.inputAccessoryView
        {
            contentOffset.y -= accessoryView.frame.size.height
            tbldailySalesSummary.contentOffset = CGPoint(x:0 , y: 0)
        }
        else
        {
            tbldailySalesSummary.contentOffset = CGPoint(x:0 , y: -50)
            textField.resignFirstResponder()
        }
        self.view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string != ""
        {
            var txtAfterUpdate = string
            if let text = textField.text as NSString?
            {
                txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                print(txtAfterUpdate)
            }
            let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to: self.tbldailySalesSummary)
            let indexPath = self.tbldailySalesSummary.indexPathForRow(at: buttonPosition)
            
            let cell = tbldailySalesSummary.cellForRow(at: indexPath!) as! DailySalesSummaryProductsCell
            
            if textField == cell.txtSoldQty
            {
                if cell.txtSoldQty.text != ""
                {
                    let qty = cell.Lbl_Qty.text
                    let IntQty = Double(qty!)
                  //  print(IntQty)
                    
                    let sold = cell.txtSoldQty.text
                    let IntSold = Double(sold!)
                   // print(IntSold)
                    
                    if IntQty! < IntSold!
                    {
                         cell.txtSoldQty.text = cell.Lbl_Qty.text
                    }
                    else
                    {
                        cell.txtSoldQty.text = cell.txtSoldQty.text
                    }
                }
                else
                {
                    let qty = cell.Lbl_Qty.text
                    let IntQty = Double(qty!)
                    print(IntQty!)
                    
                    let sold = txtAfterUpdate
                    let IntSold = Double(sold)
                    print(IntSold!)
                    
                    if IntQty! > IntSold!
                    {
                    }
                    else
                    {
                        cell.txtSoldQty.text = cell.txtSoldQty.text
                    }
                }
            }
            
        }
        
        return true
        }
    func OK()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Retailer Get Api
    func getDailySalesRetailerListing()
    {
        APISession.getDataWithRequest( withAPIName: "TertiaryInvt/retailer")
        {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                DailySalesRetailers = response!.value(forKey: "retailers") as! NSArray
            }
        }
    }
   
    //MARK:- Post Api
    var pbID = Int()
    func Create_Post()
    {
        if Reachability.isConnectedToNetwork(){
        let arrParameter = NSMutableArray()
        
        for i in 0..<CountProduct.count
        {
            let taxDic = NSMutableDictionary()
            let Id = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let productId =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "productId") as! Int
            let orgId =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "orgId") as! Int
            let priceBookId = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "pricebookId") as! Int
            let totalOpeningStock = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalOpeningStock") as! Double
            let totalReceivingStock = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalReceivedStock") as! Double
            let totalClosingStock = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalClosingStock") as! Double
            let price =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "price") as! Double
            taxDic.setValue(Id, forKey: "id")
            taxDic.setValue(productId, forKey: "productId")
            taxDic.setValue(orgId, forKey: "orgId")
            taxDic.setValue("", forKey: "soldStock")
            taxDic.setValue(arrInputValueQty.object(at: i), forKey: "soldQTY")
            taxDic.setValue(priceBookId, forKey: "pricebookId")
            pbID = priceBookId
            taxDic.setValue(totalOpeningStock, forKey: "totalOpeningStock")
            taxDic.setValue(totalReceivingStock, forKey: "totalReceivingStock")
            taxDic.setValue(totalClosingStock, forKey: "totalClosingStock")
            taxDic.setValue(price, forKey: "price")
            taxDic.setValue(1, forKey: "type")
            taxDic.setValue("", forKey: "refNo")
            taxDic.setValue(Str, forKey: "dateStr")
            print(taxDic)
            arrParameter.add(taxDic)
        }
        print(arrParameter)
        self.PostApi(DicData: arrParameter)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    func PostApi(DicData:NSMutableArray)
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        let Dic = NSMutableDictionary.init()
        Dic.setValue(pbID, forKey: "priceBookId")
        Dic.setValue(bool, forKey: "isEdited")
        Dic.setValue(DicData, forKey: "productList")
        print(Dic)
            APISession.postDataWithRequestwithTokenDelete(Dic, withAPIName: "TertiaryInvt/dailySales/1")
            {
                (response, permissions) in
                print("response is ==",response!)
                self.STOP_INDICATOR()
                if response != nil{
                    let status = response?.value(forKey: "status") as! NSNumber
                    if status != 0
                    {
                    let dailySaleSave : NSDictionary = response! .value(forKey: "dailySaleSave") as! NSDictionary
                    let value:String = dailySaleSave.value(forKey: "saveUpdateDailySaleNo") as! String
                    let alert = UIAlertController(title:"save UpdateDaily SaleNo", message:value, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
                    {
                        (alert:UIAlertAction!) -> Void in
                        self.OK()
                    })
                    alert.addAction(okAction)
                    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                    alertWindow.rootViewController = UIViewController()
                    alertWindow.windowLevel = UIWindowLevelAlert + 1;
                    alertWindow.makeKeyAndVisible()
                    alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
                }
                    else{
                        let message = response?.value(forKey: "message") as! String
                        self.displayAlertMessage(messageToDisplay: message)
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
extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.day,.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    func currentOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: -11, day: -1), to: self.startOfMonth())!
    }
}
