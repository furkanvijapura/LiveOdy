//
//  AddSalesController.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 8/21/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
var ExtraPrimarydata = Int()
var arrParameterPrimaryMain : NSMutableArray = NSMutableArray()

class AddSalesController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,MyCellDelegatePrimaryOrder {
    @IBOutlet var tblMainPrimarySales: UITableView!
    
    @IBOutlet var btnPlus: UIButton!
    @IBOutlet var lblLastOrderNo: UILabel!
    @IBOutlet var txtDate: UITextField!
    @IBOutlet var txtAmount: UITextField!
    @IBOutlet var txtOrganizationName: UITextField!
    @IBOutlet var txtCompanyName: UITextField!
    @IBOutlet var mainHeaderView: UIView!
    var arrGetSalesProduct : NSMutableArray = NSMutableArray()
    var arrGetPriceBook : NSMutableArray = NSMutableArray()
//    var arrParameterPrimaryMain : NSMutableArray = NSMutableArray()
    var distancestring = NSString()
    var arrNoSEC=[0]

    var orgName = String()
    var orgId = String()
    var sallerId = String()
    var productId = String()
    var percentage = String()
    var  taxAmount = Float()
    var total = Float()
    var taxAmountValue = String()
    var totalAmountValue = String()

   
    @IBOutlet var lblTotalAmountValue: UILabel!
    var arrPrice : NSMutableArray = NSMutableArray()
    var arrCartNotify : NSMutableArray = NSMutableArray()
    var arrDiscount : NSMutableArray = NSMutableArray()
    var arrTotaPrice : NSMutableArray = NSMutableArray()

    var Saller = ["one", "two", "three", "seven", "fifteen"]
    var Buyer = ["Discus", "IT", "PVT", "LTD", "Company"]
    var Pricebook = ["1000", "15000", "2000", "2500", "3000"]
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        let txtOrganizationNamePrevious: String? = UserDefaults.standard.object(forKey: "salesOrgName") as? String
        let txtPersonNamePrevious: String? = UserDefaults.standard.object(forKey: "salesBuyerName") as? String
//        let lblSalesTypeChannelPrevious: String? = UserDefaults.standard.object(forKey: "salesChannelType") as? String
        let txtPricebookSelectPrevious: String? = UserDefaults.standard.object(forKey: "salesPriceBook") as? String
        let txtDateSelectPrevious: String? = UserDefaults.standard.object(forKey: "salesOrderdate") as? String
        print(("Token is", txtDateSelectPrevious))
        txtOrganizationName.text = txtOrganizationNamePrevious
        txtCompanyName.text=txtPersonNamePrevious
        txtAmount.text=txtPricebookSelectPrevious
        txtDate.text=txtDateSelectPrevious

        let sumedArr = arrNoSEC.reduce(0, {$0+$1})
        print(sumedArr)
         orgName = (UserDefaults.standard.object(forKey: "organizationName") as? String)!
        orgId = (UserDefaults.standard.object(forKey: "organizationId") as? String)!
        sallerId = (UserDefaults.standard.object(forKey: "sallerId") as? String)!
        productId = (UserDefaults.standard.object(forKey: "ProductId") as? String)!
        percentage = (UserDefaults.standard.object(forKey: "percentage") as? String)!
        taxAmount = Float(sumedArr) * Float(percentage)!
        taxAmountValue = String(format: "%.2f", (taxAmount/100))
        total = Float(sumedArr) + Float(taxAmountValue)!
        totalAmountValue=String(format: "%.2f",total)
        lblTotalAmountValue.text="Amount: " + totalAmountValue
        
        getLastSalesOredrNo()
        self.title="Add Sales Order"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(AddSalesController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
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
        
        
        print(" min date : \(String(describing: txtDateSelectPrevious))")
        dateFormatter.dateFormat = "dd MM yyyy hh:mm"
        let date = dateFormatter.date(from: dateFormatter.string(from: datePicker.date))
        let nowDouble = date!.timeIntervalSince1970
        let valuee = String(nowDouble*100)
        let string = valuee
        let badchar = CharacterSet(charactersIn: "\".")
        distancestring = string.components(separatedBy: badchar).joined() as NSString
        print(distancestring)

        
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
    func getLastSalesOredrNo()
    {
        APISession.getDataWithRequestWithToken( withAPIName: "saleOrder/lastOrderNumber") {
            (response, permissions) in
            self.STOP_INDICATOR()
            print(("",response))
            let OrgName:NSArray=(response as AnyObject).value(forKey: "value") as! NSArray
            let strLastOrderNo:NSString = (OrgName.object(at: 0) as? NSString)!
            self.lblLastOrderNo.text = "Last Order:" + " " + (strLastOrderNo as String)
        }
    }
    func handleDatePicker(sender: UIDatePicker) {
        txtDate.text = dateFormatter.string(from: datePicker.date)
        
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
    func doneButtonActionAdd()
    {
        self.txtCompanyName.resignFirstResponder()
        self.txtOrganizationName.resignFirstResponder()
        self.txtDate.resignFirstResponder()
        self.txtAmount.resignFirstResponder()
    }
    
    func primarySalesSaveOrder()
    {
        let sumedArr = arrNoSEC.reduce(0, {$0+$1})
        print(sumedArr)
       let objDic:NSMutableDictionary=NSMutableDictionary.init()
        let taxDic:NSMutableDictionary=NSMutableDictionary.init()
        let arrAllProductTax = NSMutableArray()
        
//            taxDic .setValue("null", forKey:"taxId")
            taxDic .setValue("1 ", forKey:"id")
            taxDic .setValue("VAT", forKey:"tax")
            taxDic .setValue(percentage, forKey:"percentage")
            taxDic .setValue(taxAmountValue, forKey:"taxAmount")
            arrAllProductTax.add(taxDic)
            print(arrAllProductTax)
        
//        objDic .setValue("Primary", forKey:"saleType")
        objDic .setValue(distancestring, forKey:"saleDate")
        objDic .setValue(orgName, forKey:"organizationName")
        objDic .setValue(orgId, forKey:"organizationId")
        objDic .setValue(sallerId, forKey:"fromOrganizationId")
        objDic .setValue(productId, forKey:"priceBookId")
        objDic .setValue(arrParameterPrimaryMain, forKey:"productList")
        print(arrParameterPrimaryMain)

        objDic .setValue(sumedArr, forKey:"totalWithoutTax")
        objDic .setValue(arrAllProductTax, forKey:"taxProxy")
        objDic .setValue("4", forKey:"statusId")
        objDic .setValue("1", forKey:"saleTypeId")
        let planVisitId: String? = UserDefaults.standard.object(forKey: "PlanVisitId") as? String
        let planVisitIdInt = Int(planVisitId!)
        objDic .setValue(planVisitIdInt, forKey:"visitPlanId")
        objDic .setValue(total, forKey:"total")
        print(("arrAllProductValue number is==",objDic))

        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "saleOrder")
        {(response, permissions) in
            print(("Primary sales value is==",response))
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
//            let msg:String=(response as AnyObject).value(forKey: "message") as! String
            let value:String=(response as AnyObject).value(forKey: "value") as! String
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
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        primarySalesSaveOrder()
    }
    @IBAction func btnPlusProductTapped(_ sender: Any)
    {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailsScreen") as! SearchDetailsScreen
        objReg.arrSelectProduct=arrGetSalesProduct
        objReg.arrBasicPrice=arrGetPriceBook
        objReg.isTypeChannel=true

        print("Product data is==",objReg.arrProductSalesOrder)
        objReg.addProductActive=true
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
//        txtOrganizationName.text = Saller[row]
        }
       else if txtCompanyName.isEditing
        {
//            txtCompanyName.text = Buyer[row]
        }
        else if txtAmount.isEditing
        {
//            txtAmount.text = Pricebook[row]
        }
        
        
        //        txtPersonName.text = pickOption[row]
    }
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     //        for var i in (0..<arrGetSalesProduct.count)
     //        {
     //            perSonDIc .setValue("5", forKey:"id")
     //            perSonDIc .setValue("45", forKey:"productId")
     //            perSonDIc .setValue("5", forKey:"priceBookPrice")
     //            perSonDIc .setValue("5", forKey:"tax")
     //            perSonDIc .setValue("5", forKey:"basicPrice")
     //            perSonDIc .setValue("5", forKey:"discountAmount")
     //            perSonDIc .setValue("5", forKey:"productTotal")
     //            perSonDIc .setValue("5", forKey:"quantity")
     //            arrAllProductValue.add(perSonDIc)
     //            print(arrAllProductValue)
     

    }
    */
    
    // MARK: TABLEVIEW METHODE here>.....
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrGetSalesProduct.count
    }
    
    func btnCloseTapped(cell:AddSalesOrderCell)
    {
        //Get the indexpath of cell where button was tapped
        //        let cell33 = tableView.dequeueReusableCell(withIdentifier: "cell") as! EditAllSecondarySalesOrderCell
        let indexPath001 = self.tblMainPrimarySales.indexPath(for: cell)
        self.arrGetSalesProduct.remove(indexPath001 as Any)
        self.arrGetSalesProduct.removeObject(at:(indexPath001?.row)!)
        
        self.tblMainPrimarySales.deleteRows(at:[indexPath001!], with: .left)
        //UITableViewCell.transition(with: cell33,duration: 0.60, animations:{ self.tableView.reloadData() })
        self.tblMainPrimarySales.reloadData()
        print(indexPath001!.row)
        
        arrParameterPrimaryMain.removeObject(at:(indexPath001?.row)!)
        print(arrParameterPrimaryMain)
        
    }
    func btnEditeTapped(cell: AddSalesOrderCell)
    {
        let indexPath1 = tblMainPrimarySales.indexPath(for: cell)
        let stroy = storyboard?.instantiateViewController(withIdentifier: "EditProductPrimaryDetailController") as! EditProductPrimaryDetailController
        stroy.ProductName.insert(cell.lblProductName.text as Any, at: 0)
        QuantityArray.insert(cell.txtQuantity.text as Any, at: 0)
        AmountArray.insert(cell.txtAmount.text as Any, at: 0)
        stroy.PriceBookArray.insert(cell.txtPricebook.text as Any, at: 0)
        stroy.PriceArray.insert(cell.txtPrice.text as Any, at: 0)
        stroy.DiscountArray.insert(cell.txtDiscount.text as Any, at: 0)
        stroy.skuName.insert(cell.txtSku.text as Any, at: 0)
        
//        stroy.PriceBookArray.insert(cell.txtAVAQty.text as Any, at: 0)
        tblMainPrimarySales.reloadData()
        print(indexPath1!.row)
        ExtraPrimarydata = (indexPath1?.row)!
        print("Extradata : ",ExtraPrimarydata)
        self.navigationController?.pushViewController(stroy, animated: true)

    }
    override func viewWillAppear(_ animated: Bool)
    {
        print(ExtraPrimarydata)
        print(arrParameterPrimaryMain)
       self.tblMainPrimarySales.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
             let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddSalesOrderCell
        cell.delegate=self as? MyCellDelegatePrimaryOrder

        cell.lblProductName.text=arrGetSalesProduct[indexPath.row] as? String
//
//        let rateValue: NSNumber = (arrGetPriceBook[indexPath.row] as! NSNumber)
//        cell.lblPriceBook.text="Pricebook: " + rateValue.stringValue
        
        let objData : NSDictionary = arrParameterPrimaryMain[indexPath.row] as! NSDictionary
//        if let sku : String = objData.value(forKey: "quantity") as? String
//        {
            cell.txtSku.text = "SKU: " + "ml"
//        }
        if let priceBook : String = objData.value(forKey: "priceBookPrice") as? String
        {
            cell.txtPricebook.text = priceBook
        }
        if let amount : String = objData.value(forKey: "basicPrice") as? String
        {
            cell.txtAmount.text =  "\(amount)"

//            cell.txtAmount.text =  amount
        }
        if let discount : String = objData.value(forKey: "discountAmount") as? String
        {
            cell.txtDiscount.text =  discount
        }
        if let price : String = objData.value(forKey: "productTotal") as? String
        {
            cell.txtPrice.text =  price
        }
        if let quantity : String = objData.value(forKey: "quantity") as? String
        {
//            cell.txtDiscount.text =  quantity
            cell.txtQuantity.text =  "\(quantity)"

        }
//        let price: NSNumber = (arrPrice[indexPath.row] as! NSNumber)
//        cell.lblAmount.text="Amount: " + price.stringValue
//        
//        let cart: NSNumber = (arrCartNotify[indexPath.row] as! NSNumber)
//        cell.lblDiscount.text="Discount: " + cart.stringValue
//        
//        let discount: NSNumber = (arrDiscount[indexPath.row] as! NSNumber)
//        cell.lblPrice.text="Price: " + discount.stringValue
//        
//        let totalPrice: NSNumber = (arrTotaPrice[indexPath.row] as! NSNumber)
//        cell.lblQuantity.text="Quantity: " + totalPrice.stringValue
        
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
        return 170
    }
}
