 //
//  Create_SO.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 28/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
//link pending OR bool
var linkpending = Bool()
class Create_SO: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var btnSOApproverOL: UIButton!
    @IBOutlet var txtLinkPendingOR: ImageTextField!
    @IBOutlet var txtStatus: UITextField!
    @IBOutlet weak var txtSORequestorName: ImageTextField!
    @IBOutlet weak var txtSOProductList: ImageTextField!
    @IBOutlet weak var txtSDiliveryAddress: ImageTextField!
    @IBOutlet weak var txtSOORDate: ImageTextField!
    @IBOutlet weak var txtSSOalesType: ImageTextField!
    @IBOutlet weak var txtSOPriceBook: ImageTextField!
    @IBOutlet weak var txtSOFromOrgNameName: ImageTextField!
    @IBOutlet weak var txtSOOrgName: ImageTextField!
    var priceBookIdSO = NSString()
    var approverIdSO = NSString()
  var arrytest =  NSMutableArray()
    var arrayOrganizationList = NSArray()
    var arrayFromOrganizationList = NSArray()
    var arraySOProductList = NSArray()
    var arraySODiliveryAddressList = NSArray()
    var arraySOPriceBookList = NSArray()
    var arraySOApproverNameList = NSArray()
    var arraySOLinkPendingList = NSArray()
    var strSOBuyerId = NSString()
    var strSOSellerId = NSString()
    var salesSOTypeId = NSString()
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
   
    
    @IBOutlet var scrolling: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectOranizationName()
        pickerView.delegate = self
        scrolling.delegate=self
        txtSOORDate.inputView=datePicker

       // txtSORequestorName.inputView = pickerView
       // txtSOOrgName.setDoneOnKeyboard()
        //txtSOFromOrgNameName.setDoneOnKeyboard()
        //txtSORequestorName.setDoneOnKeyboard()
        //txtSOPriceBook.setDoneOnKeyboard()
        txtSOORDate.setDoneOnKeyboard()
        txtLinkPendingOR.setDoneOnKeyboard()
        txtStatus.setDoneOnKeyboard()

        let calendar = Calendar.current
        let minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        let minDate = calendar.date(from: minDateComponent)
        datePicker.minimumDate = minDate
        print(" min date : \(String(describing: minDate))")
        dateFormatter.dateFormat = "dd MMM yyyy"
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        txtSOORDate.text = dateFormatter.string(from: datePicker.date)
        UserDefaults.standard.setValue(self.txtSOORDate.text, forKey: "SOsalesDateName")
        txtStatus.text="Draft"
        txtSDiliveryAddress.text=soaddressNameLable as String
        self.title = "Create SO"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(Create_OR.back(sender:)))
          scrolling.contentSize = CGSize(width: scrolling.frame.size.width, height: scrolling.frame.size.height+500)
        self.navigationItem.leftBarButtonItem = backButton
        SOBuyerNameMain=""
        soApproverName=""
        soSellerNameMain=""
        soPricebookNameMain=""
        
        scrolling.isScrollEnabled = true
        scrolling.contentOffset = CGPoint(x: 0, y: 0)
        scrolling.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
        scrolling.alwaysBounceHorizontal = false
        scrolling.showsVerticalScrollIndicator = false
        scrolling.alwaysBounceVertical = false
        
        //LinkPendingOR Clear Data
        LinkPendinOR.ProductSelectName.removeAllObjects()
        LinkPendinOR.ProductIDSelect.removeAllObjects()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleDatePicker(sender: UIDatePicker) {
        
        txtSOORDate.text = dateFormatter.string(from: datePicker.date)
        UserDefaults.standard.setValue(self.txtSOORDate.text, forKey: "SOsalesDateName")
    }
    

    //=======================For pickerview dselegate=================
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if txtSOOrgName.isEditing
        {
            return arrayOrganizationList.count
        }
        else if txtSOFromOrgNameName.isEditing
        {
            return arrayFromOrganizationList.count
        }
        else if txtSOPriceBook.isEditing
        {
            return arraySOPriceBookList.count
        }
        else if txtSORequestorName.isEditing
        {
            return arraySOApproverNameList.count
        }
        return arrayFromOrganizationList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtSOOrgName.isEditing
        {
            let buyerName:NSArray=(self.arrayOrganizationList as AnyObject).value(forKey: "value") as! NSArray
            let strbuyerName:String = (buyerName[row] as? String)!
            return strbuyerName
        }
        else if txtSOFromOrgNameName.isEditing
        {
            let sellerName:NSArray=(self.arrayFromOrganizationList as AnyObject).value(forKey: "value") as! NSArray
            let strsellerName:String = (sellerName[row] as? String)!
            return strsellerName
        }
        else if txtSOPriceBook.isEditing
        {
            let priceBookName:NSArray=(self.arraySOPriceBookList as AnyObject).value(forKey: "value") as! NSArray
            let strPriceBook:String = (priceBookName[row] as? String)!
            return strPriceBook
        }
        else if txtSORequestorName.isEditing
        {
            let priceBookName:NSArray=(self.arraySOApproverNameList as AnyObject).value(forKey: "value") as! NSArray
            let strPriceBook:String = (priceBookName[row] as? String)!
            return strPriceBook
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if txtSOOrgName.isEditing
        {
            let BuyerName:NSArray=(self.arrayOrganizationList as AnyObject).value(forKey: "value") as! NSArray
            let strBuyerName:String = (BuyerName[row] as? String)!
            txtSOOrgName.text = strBuyerName
            UserDefaults.standard.setValue(strBuyerName, forKey: "SOorgName")
            
            let strBuyerid:NSArray=(self.arrayOrganizationList as AnyObject).value(forKey: "id") as! NSArray
            let BuyerId:NSNumber =  (strBuyerid[row] as? NSNumber)! as NSNumber
            strSOBuyerId = BuyerId.stringValue as NSString
            selectFromOrganizationName()
            UserDefaults.standard.setValue(strSOBuyerId, forKey: "SOorgID")
            // UserDefaults.standard.setValue(StrOrgId, forKey: "buyerId")
        }
        else if txtSOFromOrgNameName.isEditing
        {
            //txtSOOrgName.dismissKeyboard()
            let sellerName:NSArray=(self.arrayFromOrganizationList as AnyObject).value(forKey: "value") as! NSArray
            let strsellerName:String = (sellerName[row] as? String)!
            txtSOFromOrgNameName.text = strsellerName
            UserDefaults.standard.setValue(strsellerName, forKey: "SOfronOrgName")
            
            let strsellerID:NSArray=(self.arrayFromOrganizationList as AnyObject).value(forKey: "id") as! NSArray
            let sellerID:NSNumber =  (strsellerID[row] as? NSNumber)! as NSNumber
            strSOSellerId = sellerID.stringValue as NSString
            createSOAPIcalling()
            UserDefaults.standard.setValue(strSOSellerId, forKey: "SOfronOrgID")
        }
        else if txtSOPriceBook.isEditing
        {
            let priceBook:NSArray=(self.arraySOPriceBookList as AnyObject).value(forKey: "value") as! NSArray
            let strPriceBook:String = (priceBook[row] as? String)!
            txtSOPriceBook.text = strPriceBook
            UserDefaults.standard.setValue(strPriceBook, forKey: "SOpriceBook")
            
            let priceBookId:NSArray=(self.arraySOPriceBookList as AnyObject).value(forKey: "id") as! NSArray
            let priceID:NSNumber =  (priceBookId[row] as? NSNumber)! as NSNumber
            priceBookIdSO = priceID.stringValue as NSString
            UserDefaults.standard.setValue(priceBookIdSO, forKey: "SOPriceBookId")

            //priceBookIdMain  =  (priceBookId[row] as? NSNumber)! as NSNumber
            //UserDefaults.standard(priceBookIdSO, forKey: "SOpriceBookIDForOr")
            self.createSoPriceBookORAPIcalling()
        }
        else if txtSORequestorName.isEditing
        {
            let priceBook:NSArray=(self.arraySOApproverNameList as AnyObject).value(forKey: "value") as! NSArray
            let strPriceBook:String = (priceBook[row] as? String)!
            txtSORequestorName.text = strPriceBook
            UserDefaults.standard.setValue(strPriceBook, forKey: "SOApproverName")
            
            let priceBookId:NSArray=(self.arraySOApproverNameList as AnyObject).value(forKey: "id") as! NSArray
            let priceID:NSNumber =  (priceBookId[row] as? NSNumber)! as NSNumber
            approverIdSO = priceID.stringValue as NSString
            //priceBookIdMain  =  (priceBookId[row] as? NSNumber)! as NSNumber
            UserDefaults.standard.setValue(approverIdSO, forKey: "SOApproverId")
            
            self.createSoPriceBookORAPIcalling()
        }
        //        txtPersonName.text = pickOption[row]
    }
    
    //========================
    
    @IBAction func btnSOBuyerNameTapped(_ sender: Any) {
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SOSelectBuyerNameList") as? SOSelectBuyerNameList
        self.present(destination1!, animated: false, completion: nil)
    }
    
    @IBAction func btnSOSellerNameTapped(_ sender: Any) {
        if txtSOOrgName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else{
            //selectSellerName()
            let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SOSelectSellerNameList") as? SOSelectSellerNameList
            self.present(destination1!, animated: false, completion: nil)
        }
        
    }
    @IBAction func btnSoPricebookTapped(_ sender: Any)
    {
        if txtSOOrgName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else if txtSOFromOrgNameName.text==""
        {
            displayAlertMessage(messageToDisplay: "Please select saller name....")
        }
        else
        {
            //createSoPriceBookORAPIcalling()
            let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SOPricebookList") as? SOPricebookList
            self.present(destination1!, animated: false, completion: nil)
        }
    }
    @IBAction func btnSoApproverTapped(_ sender: Any)
    {
        if txtSOOrgName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else if txtSOFromOrgNameName.text==""
        {
            displayAlertMessage(messageToDisplay: "Please select saller name....")
        }
        else if txtSOPriceBook.text==""
        {
            displayAlertMessage(messageToDisplay: "Please select pricebook....")
        }
        else{
            if self.salesSOTypeId != "1"{
               self.displayAlertMessage(messageToDisplay: "Approver name is not available.")
            }else{
                if LinkPendinOR.PendinORList.count == 0 {
                    self.displayAlertMessage(messageToDisplay: "Approver name is not available")
                }
                else
                {
                    let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SOApproverList") as? SOApproverList
                    self.present(destination1!, animated: false, completion: nil)
                }
            }
        }
    }
    @IBAction func btnPendingOrTapped(_ sender: Any) {
        if  LinkPendinOR.PendinORList.count != 0 {
            linkpending = true
        let story = storyboard?.instantiateViewController(withIdentifier: "OR_LinkPendin_CreateOR") as! OR_LinkPendin_CreateOR
        self.present(story, animated: true, completion: nil)
        }else{
            linkpending = false
            self.displayAlertMessage(messageToDisplay: "Linked Pending OR Not Available")
        }
    }
    func selectOranizationName()
    {
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("organizationForFromSO", forKey:"value")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "data?all=false") {
            (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil{
            self.arrayOrganizationList=response!
            SOBuyerNameList=(response)!
            if self.arrayOrganizationList.count==1
            {
                // let objData : NSDictionary = self.arraySellerList[indexPath.row] as! NSDictionary
                let buyerName : String = (self.arrayOrganizationList.object(at: 0) as AnyObject) .value(forKey: "value") as! String
                self.txtSOOrgName.text=buyerName
                SOBuyerNameMain=buyerName
                let soBUyerId:NSNumber  = (self.arrayOrganizationList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                SoBuyerIDMain = soBUyerId.stringValue
                self.selectFromOrganizationName()
                }
            }
            
            // selectSellerName()
        }
    }
    
    func selectFromOrganizationName()
    {
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("organizationForToSO", forKey:"value")
        objDic .setValue(SOBuyerTypeMain, forKey:"type")
        objDic .setValue(SoBuyerIDMain, forKey:"id")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list?all=false") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                self.arrayFromOrganizationList = response! .value(forKey: "data") as! NSArray
                SOSellerNameList =  self.arrayFromOrganizationList
                if self.arrayFromOrganizationList.count==1
                {
                    // let objData : NSDictionary = self.arraySellerList[indexPath.row] as! NSDictionary
                    let sellerName : String = (self.arrayFromOrganizationList.object(at: 0) as AnyObject) .value(forKey: "value") as! String
                    self.txtSOFromOrgNameName.text=sellerName
                    soSellerNameMain=sellerName
                    let orSellerId:NSNumber  = (self.arrayFromOrganizationList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                    soSellerIDMain = orSellerId.stringValue
                    self.createSOAPIcalling()
                }
            }
        }
    }
    func createSoPriceBookORAPIcalling()
    {
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("productFromPricebook", forKey:"value")
        objDic .setValue(soPricebookIDMain, forKey:"id")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                self.arraySOProductList = response!.value(forKey: "products") as! NSArray
            }
        }
    }
    
    func createSOAPIcalling()
    {
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("sellerDetailsFromBuyerForSO", forKey:"value")
        objDic .setValue(soSellerIDMain, forKey:"sellerId")
        objDic .setValue(SoBuyerIDMain, forKey:"buyerId")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list?all=false") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let allsellerDetails : NSDictionary = response! .value(forKey: "sellerDetails") as! NSDictionary
                print("orList==",allsellerDetails)
                
                self.txtSSOalesType.text = allsellerDetails.value(forKey: "salesTypeValue") as! NSString as String
                UserDefaults.standard.setValue(self.txtSSOalesType.text, forKey: "SOsalesTypeName")
                
                let salesID:NSNumber = allsellerDetails.value(forKey: "salesTypeId") as! NSNumber
                self.salesSOTypeId = salesID.stringValue as NSString
                
                UserDefaults.standard.setValue(self.salesSOTypeId, forKey: "SOsalesType")
                self.arraySODiliveryAddressList = allsellerDetails.value(forKey: "shippingAddress") as! NSArray
                //MARK:- Link Pending OR
                var LinkPendingORList = NSArray()
                //Sales Type ID
                LinkPendinOR.salesTypeID = allsellerDetails.value(forKey: "salesTypeId") as! Int
                LinkPendingORList = allsellerDetails.value(forKey: "linkPendingOR") as! NSArray
                
                if LinkPendingORList.count != 0{
                    LinkPendinOR.PendinORList = LinkPendingORList
                }
                
                if self.arraySODiliveryAddressList.count==1
                {
                    let shippingAddress : String = (self.arraySODiliveryAddressList.object(at: 0) as AnyObject) .value(forKey: "labelAs") as! String
                    self.txtSDiliveryAddress.text=shippingAddress
                    soaddressNameLable=shippingAddress as NSString
                    let addressID:NSNumber  = (self.arraySODiliveryAddressList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                    sodiliveryidNUmber = addressID
                }
                
                self.arraySOPriceBookList = allsellerDetails.value(forKey: "priceBook") as! NSArray
                SOPricebookListarr = self.arraySOPriceBookList
                
                if self.arraySOPriceBookList.count==1
                {
                    let pricebook : String = (self.arraySOPriceBookList.object(at: 0) as AnyObject) .value(forKey: "value") as! String
                    self.txtSOPriceBook.text=pricebook
                    soPricebookNameMain=pricebook
                    let pricebookId:NSNumber  = (self.arraySOPriceBookList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                    soPricebookIDMain = pricebookId.stringValue
                }
                
                
                self.arraySOApproverNameList = allsellerDetails.value(forKey: "approversName") as! NSArray
                SOApproverListarr = self.arraySOApproverNameList
                
                if self.arraySOApproverNameList.count==1
                {
                    let approverName : String = (self.arraySOApproverNameList.object(at: 0) as AnyObject) .value(forKey: "value") as! String
                    self.txtSORequestorName.text=approverName
                    soApproverName=approverName
                    let approverNameId:NSNumber  = (self.arraySOApproverNameList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                    soApproverID = approverNameId.stringValue
                }
                
                self.arraySOLinkPendingList = allsellerDetails.value(forKey: "linkPendingOR") as! NSArray
                SOPendingListarr = self.arraySOLinkPendingList
                print("arrayDiliveryAddressList==",self.arraySODiliveryAddressList)
                print("arrayPriceBookList==",self.arraySOPriceBookList)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        txtSDiliveryAddress.text=soaddressNameLable as String
        txtSOOrgName.text=SOBuyerNameMain
        txtSOFromOrgNameName.text=soSellerNameMain
        txtSOPriceBook.text=soPricebookNameMain
        txtSORequestorName.text=soApproverName

        if txtSOOrgName.text != ""
        {
            selectFromOrganizationName()
        }
        if txtSOFromOrgNameName.text != ""
        {
            createSOAPIcalling()
        }
        if txtSOPriceBook.text != ""
        {
            createSoPriceBookORAPIcalling()
        }
        txtLinkPendingOR.text = LinkPendinOR.ProductSelectName.componentsJoined(by: ", ")
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {

        if txtSOOrgName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select Company name....")
        }
        else if txtSOFromOrgNameName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select seller name....")
        }
        else if txtSOPriceBook.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select pricebook name....")
        }
        else if txtSORequestorName.text == ""
        {
            if salesSOTypeId != "1" {
                displayAlertMessage(messageToDisplay: "Please add Approver name....")
            }
        }
        else if txtSDiliveryAddress.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select Delivery Address....")
        }
        else{
            displayAlertMessage(messageToDisplay: "Please select products first....")
        }
    }
    @IBAction func btnProductTapped(_ sender: Any)
    {
        if txtSOOrgName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select Company name....")
        }
        else if txtSOFromOrgNameName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select seller name....")
        }
        else if txtSOPriceBook.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select pricebook name....")
        }
         else if txtSDiliveryAddress.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select Delivery Address....")
        }
        else
        {
            if txtSORequestorName.text == ""
            {
                if salesSOTypeId != "1"
                {
                    displayAlertMessage(messageToDisplay: "Please add Approver name....")
                }
            }
           // let DicccTest = NSMutableDictionary()
            if linkpending == true {
            let DicArray = NSMutableArray()
            let tempIDsave = NSMutableArray()
            for s in 0..<LinkPendinOR.ProductMargArray.count
            {
                let value : NSDictionary = LinkPendinOR.ProductMargArray[s] as! NSDictionary
                if tempIDsave.contains(value.value(forKey: "proId") as! Int) == false
                {
                    tempIDsave.add(value.value(forKey: "proId") as! Int)
                    let Diccc = NSMutableDictionary()
                    var quntity = Double()
                    for f in 0..<LinkPendinOR.ProductMargArray.count
                    {
                        let subValue : NSDictionary = LinkPendinOR.ProductMargArray[f] as! NSDictionary
                        if value.value(forKey: "proId") as! Int == subValue.value(forKey: "proId") as! Int
                        {
                            quntity += subValue.value(forKey: "quantity") as! Double
                        }
                        print("quntity==",quntity)
                    }
                    Diccc.setValue(value.value(forKey: "productName"), forKey: "productName")
                    Diccc.setValue(value.value(forKey: "productMargin"), forKey: "productMargin")
                    Diccc.setValue(value.value(forKey: "proId"), forKey: "productId")
                    Diccc.setValue(value.value(forKey: "category"), forKey: "productCategoryName")
                    Diccc.setValue(value.value(forKey: "measurementName"), forKey: "uom")
                    Diccc.setValue(value.value(forKey: "id"), forKey: "id")
                    Diccc.setValue(value.value(forKey: "currencySymbol"), forKey: "currencySymbol")
                    Diccc.setValue(value.value(forKey: "priceBookPrice"), forKey: "basicPrices")
                    Diccc.setValue(value.value(forKey: "barcode"), forKey: "barcode")
                    Diccc.setValue(value.value(forKey: "uom"), forKey: "uom")
                    Diccc.setValue(quntity, forKey: "quantity")
                    var totalValue = 0.00
                    if let basicPric = value.value(forKey: "priceBookPrice") as? Double{
                        totalValue = (quntity * basicPric)
                    }else{
                        totalValue = (quntity * 0.00)
                    }
                    
                    let totalToDuble = String(format: "%.2f", totalValue)
                    Diccc.setValue(Double(totalToDuble), forKey: "productTotal")
                    DicArray.add(Diccc)
                    print("----------->",DicArray)
                }
            }
            // Final Json Adding in Array
            LinkPendinOR.LinkedFinaleArray = DicArray 
            }
            
            let objReg = self.storyboard?.instantiateViewController(withIdentifier:"SOSelectProduct") as! SOSelectProduct
            objReg.soarrayProductLists = arraySOProductList
            boolSOUpdate = false
            self.navigationController?.pushViewController(objReg, animated: true)
         
        }
    }
    
   
    @IBAction func btnDeliveryTapped(_ sender: Any)
    {
        if txtSOOrgName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select Company name....")
        }
        else if txtSOFromOrgNameName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select seller name....")
        }
        else if txtSOPriceBook.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select pricebook name....")
        }
//        else if txtSORequestorName.text == ""
//        {
//            displayAlertMessage(messageToDisplay: "Please add Approver name....")
//        }
        else{
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SODilevryAdressPopUp") as? SODilevryAdressPopUp
        destination1?.arraySoDiliveryAddress=arraySODiliveryAddressList
        self.present(destination1!, animated: false, completion: nil)
        }
    }
   
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
        if textField == txtSORequestorName
        {
            scrolling.contentOffset = CGPoint(x: 0, y: 50)
        }
        if textField == txtSOORDate
        {
            scrolling.contentOffset = CGPoint(x: 0, y: 50)
        }
        if textField == txtSDiliveryAddress
        {
            scrolling.contentOffset = CGPoint(x: 0, y: 50)
        }
        if textField == txtSOProductList
        {
            scrolling.contentOffset = CGPoint(x: 0, y: 50)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
          if(textField == txtSOORDate)
            {
                scrolling.contentOffset = CGPoint(x:0 , y:50)
            }
            else
            {
                scrolling.contentOffset = CGPoint(x:0 , y:-100)
            }
        
        return false
        
    }
}
