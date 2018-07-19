//
//  AddSalesSecondaryController.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 9/19/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
var Extradata = Int()
var arrParameterSecondaryMain : NSMutableArray = NSMutableArray()

class AddSalesSecondaryController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,MyCellDelegateSecondaryOrder {
    
    @IBOutlet var tblMainSecondarySales: UITableView!
    @IBOutlet var btnPlus: UIButton!
    @IBOutlet var lblLastOrderNo: UILabel!
    @IBOutlet var txtDate: UITextField!
    @IBOutlet var txtAmount: UITextField!
    @IBOutlet var txtOrganizationName: UITextField!
    @IBOutlet var txtCompanyName: UITextField!
    @IBOutlet var mainHeaderView: UIView!
    var arrGetSalesProduct : NSMutableArray = NSMutableArray()
    var arrGetBasicPrice : NSMutableArray = NSMutableArray()
//    var arrParameterSecondaryMain : NSMutableArray = NSMutableArray()

    var arrSku : NSMutableArray = NSMutableArray()
    
    var arrCalculateValue = NSMutableArray()
    let dateFormatter = DateFormatter()
    var distancestring = NSString()
 
    var arrNo=[0]
    var arrcartFillValue : NSMutableArray = NSMutableArray()
    var  ind = IndexPath()


    var Saller = ["one", "two", "three", "seven", "fifteen"]
    var Buyer = ["Discus", "IT", "PVT", "LTD", "Company"]
    var Pricebook = ["1000", "15000", "2000", "2500", "3000"]
    
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Add Sales Secondary Order"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(AddSalesController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        let txtOrganizationNamePrevious: String? = UserDefaults.standard.object(forKey: "salesOrgName") as? String
        let txtPersonNamePrevious: String? = UserDefaults.standard.object(forKey: "salesBuyerName") as? String
        //        let lblSalesTypeChannelPrevious: String? = UserDefaults.standard.object(forKey: "salesChannelType") as? String
        let txtPricebookSelectPrevious: String? = UserDefaults.standard.object(forKey: "salesPriceBook") as? String
        let txtDateSelectPrevious: String? = UserDefaults.standard.object(forKey: "salesOrderdate") as? String
        
//        UserDefaults.standard.setValue(strSallerId, forKey: "sallerId")
//        UserDefaults.standard.setValue(StrOrgId, forKey: "buyerId")
        
        print(("Token is", txtDateSelectPrevious))
        txtOrganizationName.text = txtOrganizationNamePrevious
        txtCompanyName.text=txtPersonNamePrevious
        txtAmount.text=txtPricebookSelectPrevious
        txtDate.text=txtDateSelectPrevious
        
        
//        dateFormatter.minimumDate = txtDateSelectPrevious
        print(" min date : \(String(describing: txtDateSelectPrevious))")
        dateFormatter.dateFormat = "dd MM yyyy hh:mm"
        let date = dateFormatter.date(from: dateFormatter.string(from: datePicker.date))
        let nowDouble = date!.timeIntervalSince1970
        let valuee = String(nowDouble*100)
        let string = valuee
        let badchar = CharacterSet(charactersIn: "\".")
        distancestring = string.components(separatedBy: badchar).joined() as NSString
        print(distancestring)
        
        getLastSalesOredrNo()
        
        pickerView.delegate = self
        
        
//        txtOrganizationName.inputView = pickerView
//        txtCompanyName.inputView = pickerView
//        txtAmount.inputView=pickerView
//        txtDate.inputView=datePicker
        
        let calendar = Calendar.current
        let minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        let minDate = calendar.date(from: minDateComponent)
        datePicker.minimumDate = minDate
        
        datePicker.datePickerMode = .date
        //        timePIcker.datePickerMode = .time
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        //        TimeFormatter.dateFormat = "hh:mm"
        
        
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        
        self.addDoneButtonOnKeyboard()
        
        
        
        //        cell.mainFooterView.layer.cornerRadius = 3.0
        //        cell.mainFooterView.layer.borderColor = UIColor.lightGray.cgColor
        //        cell.mainFooterView.layer.borderWidth = 0.1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        txtDate.text = dateFormatter.string(from: datePicker.date)
    }
    func getLastSalesOredrNo()
    {
        START_INDICATOR()
        APISession.getDataWithRequestWithToken( withAPIName: "saleOrder/lastOrderNumber") {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            let OrgName:NSArray=(response as AnyObject).value(forKey: "value") as! NSArray
            let strLastOrderNo:NSString = (OrgName.object(at: 0) as? NSString)!
            self.lblLastOrderNo.text = "Last Order:" + " " + (strLastOrderNo as String)
        }
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AddVisitScreen.doneButtonActionAdd))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.txtOrganizationName.inputAccessoryView = doneToolbar
        self.txtCompanyName.inputAccessoryView = doneToolbar
        self.txtAmount.inputAccessoryView=doneToolbar
        self.txtDate.inputAccessoryView=doneToolbar
    }
 //==================For Api calling to save order===================
    func SecondarySalesSaveOrder()
    {
        let sumedArr = arrNo.reduce(0, {$0+$1})
        print(sumedArr)
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(arrParameterSecondaryMain, forKey:"productList")
        print(arrParameterSecondaryMain)
        objDic .setValue(distancestring, forKey:"saleDate")
        objDic .setValue(UserDefaults.standard.object(forKey: "buyerId") as! String, forKey:"distributorId")
        objDic .setValue(UserDefaults.standard.object(forKey: "sallerId") as! String, forKey:"retailerId")
//        objDic .setValue("null", forKey:"totalPrice")
        objDic .setValue(sumedArr, forKey:"totalQty")
        objDic .setValue("1", forKey:"statusId")
//        UserDefaults.standard.setValue(self.Id, forKey: "PlanVisitId")
        let planVisitId: String? = UserDefaults.standard.object(forKey: "PlanVisitId") as? String
        objDic .setValue(planVisitId, forKey:"visitPlanId")
        print(("arrAllProductValue number is==",objDic))
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "distSalesOrder")
        {(response, permissions) in
            print(("delete number is==",response))
            self.STOP_INDICATOR()
            if response == nil
            {
                self.displayAlertMessage(messageToDisplay: "No sales order found")
            }
            else if let message:String=response!.value(forKey: "message") as? String
            {
                if message=="Error while creating sales order."
                {
                    let alert = UIAlertController(title:"Your sales order not completed", message:message, preferredStyle: UIAlertControllerStyle.alert)
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
                else
                {
                    let value:String=response!.value(forKey: "value") as! String
                    let alert = UIAlertController(title:"Your sales order number is:", message:value, preferredStyle: UIAlertControllerStyle.alert)
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
            }
            else
            {
            let value:String=response!.value(forKey: "value") as! String
            let alert = UIAlertController(title:"Your sales order number is:", message:value, preferredStyle: UIAlertControllerStyle.alert)
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
        }
    }
    
    func OK()
    {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SalesOrderScreen") as! SalesOrderScreen
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    
    func doneButtonActionAdd()
    {
        self.txtCompanyName.resignFirstResponder()
        self.txtOrganizationName.resignFirstResponder()
        self.txtDate.resignFirstResponder()
        self.txtAmount.resignFirstResponder()
    }
    
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        _ = navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        SecondarySalesSaveOrder()
        
//        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "MainSalesOrderSummaryScreen") as! MainSalesOrderSummaryScreen
//        objReg.arrProductName=arrGetSalesProduct
      //  print("Product data is==",objReg.arrProductName)
        //        objReg.addProductActive=true
        //self.navigationController?.pushViewController(objReg, animated: true)
    }
    @IBAction func btnPlusProductTapped(_ sender: Any)
    {
        
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailsScreen") as! SearchDetailsScreen
        objReg.arrSelectProduct=arrGetSalesProduct
        objReg.isProductMainBool=true
        print("Product data is==",objReg.arrProductSalesOrder)
        objReg.isTypeChannel=false
        self.navigationController?.pushViewController(objReg, animated: true)
        
        //        _ = navigationController?.popViewController(animated: true)
        //        self.navigationController?.popToViewController(objReg, animated: true)
    }
    // MARK: UiPickerview delegates here:
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if txtOrganizationName.isEditing
        {
            return Saller.count
        }
        else if txtCompanyName.isEditing
        {
            return Buyer.count
        }
        else if txtAmount.isEditing
        {
            return Pricebook.count
        }
        return Pricebook.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if txtOrganizationName.isEditing
        {
            return Saller[row]
        }
        else if txtCompanyName.isEditing
        {
            return Buyer[row]
        }
        else if txtAmount.isEditing
        {
            return Pricebook[row]
        }
        return Pricebook[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if txtOrganizationName.isEditing
        {
            txtOrganizationName.text = Saller[row]
        }
        else if txtCompanyName.isEditing
        {
            txtCompanyName.text = Buyer[row]
        }
        else if txtAmount.isEditing
        {
            txtAmount.text = Pricebook[row]
        }
        
        
        //        txtPersonName.text = pickOption[row]
    }
    
    // MARK: TABLEVIEW METHODE here>.....
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrGetSalesProduct.count
//        return 5
    }
    
    func btnCloseTapped(cell:AddSalesSecondaryOrderCell)
    {
        //Get the indexpath of cell where button was tapped
        //        let cell33 = tableView.dequeueReusableCell(withIdentifier: "cell") as! EditAllSecondarySalesOrderCell
        let indexPath001 = self.tblMainSecondarySales.indexPath(for: cell)
        self.arrGetSalesProduct.remove(indexPath001 as Any)
        self.arrGetSalesProduct.removeObject(at:(indexPath001?.row)!)
        
       self.tblMainSecondarySales.deleteRows(at:[indexPath001!], with: .left)
        //UITableViewCell.transition(with: cell33,duration: 0.60, animations:{ self.tableView.reloadData() })
     self.tblMainSecondarySales.reloadData()
        print(indexPath001!.row)
        
        arrParameterSecondaryMain.removeObject(at:(indexPath001?.row)!)
        print(arrParameterSecondaryMain)
    }
    
    func btnEditeTapped(cell: AddSalesSecondaryOrderCell)
    {
        //Get the indexpath of cell where button was tapped
        let indexPath1 = tblMainSecondarySales.indexPath(for: cell)
        let stroy = storyboard?.instantiateViewController(withIdentifier: "EditProductDetailController") as! EditProductDetailController
        stroy.ProducatNameArray.insert(cell.lblProductName.text as Any, at: 0)
        CartValueArray.insert(cell.txtQuantity.text as Any, at: 0)
        stroy.BarCodeArray.insert(cell.txtSku.text as Any, at: 0)
        stroy.BoxValueArray.insert(cell.txtAVAQty.text as Any, at: 0)
        tblMainSecondarySales.reloadData()
        print(indexPath1!.row)
        Extradata = (indexPath1?.row)!
        print("Extradata : ",Extradata)
        self.navigationController?.pushViewController(stroy, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        print(Extradata)
        print(arrParameterSecondaryMain)
        tblMainSecondarySales.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddSalesSecondaryOrderCell
//        cell.delegate=self as? MyCellDelegateSecondaryOrder
//
//        cell.lblProductName.text =  arrGetSalesProduct[indexPath.row] as? String
//
//        let skuValue: NSString =  (arrSku[indexPath.row] as? NSString)!
//
//        cell.lblSku.text = "SKU: " + (skuValue as String)
//        
//        let rateValue: NSNumber = (arrGetBasicPrice[indexPath.row] as! NSNumber)
//        cell.lblAVAQty.text="AVA Qty: " + rateValue.stringValue
//        
//        
////        let cartValue: NSString = (arrcartFillValue[indexPath.row] as! NSString)
////        cell.lblQuantity.text="Quantity: " + (cartValue as String)
////        ind = [indexPath.row]
//        
//        
//        let objData : NSDictionary = arrParameterSecondaryMain[indexPath.row] as! NSDictionary
//        if let salesOrgName : String = objData.value(forKey: "quantity") as? String
//        {
//            cell.lblQuantity.text = "Quantity: " +  "\(salesOrgName)"
//        }
        
//       ind = tableView.indexPath(for: cell)!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddSalesSecondaryOrderCell
        cell.lblProductName.text =  arrGetSalesProduct[indexPath.row] as? String
        
        let skuValue: NSString =  (arrSku[indexPath.row] as? NSString)!
        cell.txtSku.text =  (skuValue as String)
        cell.delegate = self
        
        
        let objData : NSDictionary = arrParameterSecondaryMain[indexPath.row] as! NSDictionary
        if let salesOrgName  = objData.value(forKey: "quantity")
        {
            cell.txtQuantity.text =  "\(salesOrgName)"
        }
        if let avalQty : String = objData.value(forKey: "avalQty") as? String
        {
            cell.txtAVAQty.text = avalQty
        }

        
        cell.viewBackData.backgroundColor = UIColor.white
        cell.viewBackData.layer.cornerRadius = 5.0
        cell.viewBackData.layer.borderColor = UIColor.gray.cgColor
        cell.viewBackData.layer.borderWidth = 0.1
        cell.viewBackData.layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
        cell.viewBackData.layer.shadowOpacity = 1.0
        cell.viewBackData.layer.shadowRadius = 5.0
        cell.viewBackData.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 115
    }
}
