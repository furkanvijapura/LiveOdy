

import UIKit

class Create_OR: UIViewController,UIPickerViewDelegate
{
    var arrayByerList = NSArray()
    var arraySellerList = NSArray()
    var arrayProductList = NSArray()
    var arrayDiliveryAddressList = NSArray()
    var arrayPriceBookList = NSArray()
    var strBuyerId = NSString()
    var strSellerId = NSString()
    var salesTypeId = NSString()
    let pickerView = UIPickerView()
    var visitId = NSNumber()
    var BooolWillAppearCall = Bool()
    @IBOutlet weak var txtRequestorName: ImageTextField!
    @IBOutlet weak var txtProductList: ImageTextField!
    @IBOutlet weak var txtDiliveryAddress: ImageTextField!
    @IBOutlet weak var txtSalesType: ImageTextField!
    @IBOutlet weak var txtPriceBook: ImageTextField!
    @IBOutlet weak var txtSellerName: ImageTextField!
    @IBOutlet weak var txtBuyerName: ImageTextField!
    @IBOutlet weak var btnBuyerNameOutlate: UIButton!
    var priceBookIdMain = NSString()
    var visitCreateOR = Bool()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Create OR"
        txtProductList.text = ""
        BooolWillAppearCall = true
        addDoneButtonOnKeyboard()
        pickerView.delegate = self
        addressNameLable = ""
        if visitCreateOR == false{
            orBuyerNameMain = ""
        }
        //Tempory-shorted-this is bug
        //12960
        if orBuyerIDMain == "\(0)"
        {
            self.displayAlertMessage(messageToDisplay: "No Seller Available...")
            self.navigationController?.popViewController(animated: true)
             orBuyerIDMain = "0"
        }
        if orBuyerNameMain == "" {
             selectBuyerName()
        }else{
           btnBuyerNameOutlate.isUserInteractionEnabled = false
           txtBuyerName.text = orBuyerNameMain
           txtBuyerName.isUserInteractionEnabled = false
           self.selectSellerName()
        }
     
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(Create_OR.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool)
    {

            txtDiliveryAddress.text = addressNameLable as String
            txtBuyerName.text = orBuyerNameMain
            txtSellerName.text = orSellerNameMain
            txtPriceBook.text = orPricebookNameMain
            if txtBuyerName.text != ""
            {
                selectSellerName()
            }
            if txtSellerName.text == ""
            {
            }
            else{
               // createORAPIcalling()
            }
            txtProductList.text = ProductSelectName.componentsJoined(by: ", ")
        
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        isBoolOrderCreateOrCancel = false
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if txtBuyerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else if txtSellerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select saller name....")
        }
        else if txtPriceBook.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select pricebook name....")
        }
        else if txtRequestorName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please add Requestor name....")
        }
        else if txtDiliveryAddress.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select Delivery Address....")
        }
        else if txtProductList.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select products first....")
        }
    }
    @IBAction func btnBuyerNameTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        BooolWillAppearCall = false
        orSellerNameMain = ""
        addressNameLable = ""
        txtSalesType.text=""
        orPricebookNameMain = ""
        txtDiliveryAddress.text = ""
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SelectBuyerNameList") as? SelectBuyerNameList
        self.present(destination1!, animated: false, completion: nil)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnSellerNameTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork() {
       addressNameLable = ""
        //txtSalesType.text=""
        orPricebookNameMain=""
        txtDiliveryAddress.text=""
        if txtBuyerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else
        {
            let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SelectSellerNameList") as? SelectSellerNameList
            self.present(destination1!, animated: false, completion: nil)
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnPricebookTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        addressNameLable = ""
        //txtSalesType.text=""
        txtDiliveryAddress.text=""
        if txtBuyerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else if txtSellerName.text==""
        {
            displayAlertMessage(messageToDisplay: "Please select saller name....")
        }
        else{
            createPriceBookORAPIcalling()
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnDiliveryAddressTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        if txtBuyerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else if txtSellerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select saller name....")
        }
        else if txtPriceBook.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select pricebook name....")
        }
        else if txtRequestorName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please add Approver name....")
        }
        else{
        
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "DilevryAdressPopUp") as? DilevryAdressPopUp
        destination1?.arrayDiliveryAddress = arrayDiliveryAddressList
        self.present(destination1!, animated: false, completion: nil)
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnProductListTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        if txtBuyerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select buyer name....")
        }
        else if txtSellerName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select saller name....")
        }
        else if txtPriceBook.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select pricebook name....")
        }
        else if txtRequestorName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please add Approver name....")
        }
        else if txtDiliveryAddress.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select Delivery Address....")
        }
        else
        {
            let objReg = self.storyboard?.instantiateViewController(withIdentifier:"SelectProduct") as! SelectProduct
            UserDefaults.standard.setValue(self.txtRequestorName.text, forKey: "requestorName")
            print("self.txtRequestorName.text==",self.txtRequestorName.text!)
            boolORUpdate = false
            objReg.visitId = visitId
           self.navigationController?.pushViewController(objReg, animated: true)
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
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
        self.txtRequestorName.inputAccessoryView = doneToolbar
        self.txtDiliveryAddress.inputAccessoryView = doneToolbar
    }
    
    func doneButtonActionAdd()
    {
        self.txtRequestorName.resignFirstResponder()
        self.txtDiliveryAddress.resignFirstResponder()
       
    }
    
    func selectBuyerName()
    {
        if Reachability.isConnectedToNetwork(){
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("organizationForFromSO", forKey:"value")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "data?all=false") {
            (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            self.arrayByerList = response!
            ORBuyerNameList = (response)!
            if self.arrayByerList.count==1
            {
                // let objData : NSDictionary = self.arraySellerList[indexPath.row] as! NSDictionary
                let buyerName : String = (self.arrayByerList.object(at: 0) as AnyObject) .value(forKey: "value") as! String
                self.txtBuyerName.text = buyerName
                orBuyerNameMain=buyerName
                let soBUyerId:NSNumber  = (self.arrayByerList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                orBuyerIDMain = soBUyerId.stringValue
                self.selectSellerName()
            }
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func selectSellerName()
    {
        if Reachability.isConnectedToNetwork(){
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("organizationForToSO", forKey:"value")
        objDic .setValue("3", forKey:"type")
        objDic .setValue(orBuyerIDMain, forKey:"id")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list?all=false") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                
                self.arraySellerList = response?.value(forKey: "data") as! NSArray
                ORSellerNameList = response? .value(forKey: "data") as! NSArray
                if (self.arraySellerList.count != 0)
                {
                    let sellerName : String = (self.arraySellerList.object(at: 0) as AnyObject) .value(forKey: "value") as! String
                    self.txtSellerName.text=sellerName
                    orSellerNameMain=sellerName
                    let orSellerId:NSNumber  = (self.arraySellerList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                    orSellerIDMain = orSellerId.stringValue
                    //temporary code
                    if self.txtBuyerName.text != "Pepsico Pvt. Ltd."{
                        self.createORAPIcalling()
                    }else{
                            self.displayAlertMessage(messageToDisplay: "Buyer  is not found.")
                    }
                }
                else{
                    self.displayAlertMessage(messageToDisplay: "No Seller Available...")
                    self.navigationController?.popViewController(animated: true)
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
    
    func createPriceBookORAPIcalling()
    {
        if Reachability.isConnectedToNetwork() {
            START_INDICATOR()
        let objDic:NSMutableDictionary = NSMutableDictionary.init()
        objDic .setValue("productFromPricebook", forKey:"value")
        objDic .setValue(orPricebookIDMain, forKey:"id")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                self.arrayProductList = response!.value(forKey: "products") as! NSArray
               // ORSellerNameList = response! .value(forKey: "data") as! NSArray
                let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SelectPricebookList") as? SelectPricebookList
                self.present(destination1!, animated: false, completion: nil)
            }
        }
        }
        else
        {
//        self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func createORAPIcalling()
    {
        if Reachability.isConnectedToNetwork(){
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("sellerDetailsFromBuyer", forKey:"value")
        objDic .setValue(orSellerIDMain, forKey:"sellerId")
        objDic .setValue(orBuyerIDMain, forKey:"buyerId")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list?all=false") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let allsellerDetails : NSDictionary = response! .value(forKey: "sellerDetails") as! NSDictionary
                print("orList==",allsellerDetails)
                self.txtSalesType.text = allsellerDetails.value(forKey: "salesTypeValue") as! NSString as String
                UserDefaults.standard.setValue(self.txtSalesType.text, forKey: "salesTypeName")
                let salesID:NSNumber = allsellerDetails.value(forKey: "salesTypeId") as! NSNumber
                self.salesTypeId = salesID.stringValue as NSString
                UserDefaults.standard.setValue(self.salesTypeId, forKey: "salesTypeForOr")
                // self.arrayProductList = allsellerDetails.value(forKey: "products") as! NSArray
                
                self.arrayDiliveryAddressList = allsellerDetails.value(forKey: "shippingAddress") as! NSArray
                self.arrayPriceBookList = allsellerDetails.value(forKey: "priceBook") as! NSArray
                ORPricebookList = self.arrayPriceBookList
                if self.arrayPriceBookList.count==1
                {
                    let pricebookName : String = (self.arrayPriceBookList.object(at: 0) as AnyObject) .value(forKey: "value") as! String
                    self.txtPriceBook.text=pricebookName
                    orPricebookNameMain=pricebookName
                    let orPricebookId:NSNumber  = (self.arrayPriceBookList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                    orPricebookIDMain = orPricebookId.stringValue
     
                }
                if self.arrayDiliveryAddressList.count==1
                {
                    let shippingAddress : String = (self.arrayDiliveryAddressList.object(at: 0) as AnyObject) .value(forKey: "labelAs") as! String
                    self.txtDiliveryAddress.text=shippingAddress
                    addressNameLable=shippingAddress as NSString
                    let deliveryId:NSNumber  = (self.arrayDiliveryAddressList.object(at: 0) as AnyObject) .value(forKey: "id") as! NSNumber
                    diliveryidNUmber = deliveryId
             
                }
                print("arrayProductList===",self.arrayProductList)
                print("arrayDiliveryAddressList==",self.arrayDiliveryAddressList)
                print("arrayPriceBookList==",self.arrayPriceBookList)
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

