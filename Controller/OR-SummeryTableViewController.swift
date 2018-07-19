

import UIKit
var strTotalAmount = String()
var strTotalQTyyy = String()
class OR_SummeryTableViewController: UITableViewController,ORProductDelegateee {
    //var arrFinalORProduct : NSMutableArray = NSMutableArray()
    var arrBasicPrice : NSMutableArray = NSMutableArray()
    var arrSku : NSMutableArray = NSMutableArray()
    var arrMaserment : NSMutableArray = NSMutableArray()
    var arrCurrency : NSMutableArray = NSMutableArray()
    var arrTotalCellAmount : NSMutableArray = NSMutableArray()
    var visitId=NSNumber()

    @IBOutlet var lblTotalAmountCurrency: UILabel!
    var arrSelectProduct : NSMutableArray = NSMutableArray()
    var arrCategoryName : NSMutableArray = NSMutableArray()
    @IBOutlet var FooterView: UIView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTotalItems: UILabel!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //print("visitId==",visitId)
        self.title = "Create OR"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(OR_SummeryTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        // = String(format : "%.2f",strTotalAmount)
        lblTotalPrice.text = strTotalAmount
        let strTotal1 = Float(strTotalAmount)!
        lblTotalPrice.text = (ProductCurrencyNameArray.object(at: 0) as? String)! + String(format: "%.2f",strTotal1)
        lblTotalItems.text = strTotalQTyyy
        lblTotalAmountCurrency.text = ProductCurrencyNameArray.object(at: 0) as? String
        arrTotalCellAmount.removeAllObjects()
        for i in 0..<arrFinalORProduct.count
        {
            let objData : NSDictionary = arrFinalORProduct[i] as! NSDictionary
            let totalPricess : NSString = (objData.value(forKey: "totalPrice") as? NSString)!
             arrTotalCellAmount.add(totalPricess)
        }
       // print("blTotalPrice.text==",lblTotalPrice.text!)
    }
    override func viewWillAppear(_ animated: Bool) {
        let strTotal1 = Float(strTotalAmount)!
        lblTotalPrice.text = (ProductCurrencyNameArray.object(at: 0) as? String)! + String(format: "%.2f",strTotal1)
        lblTotalItems.text = strTotalQTyyy
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return ProductIDArray.count
        }
    }
    @IBAction func btnAddProductTapped(_ sender: Any)
    {
        let priceBookID: NSString? = UserDefaults.standard.object(forKey: "priceBookIDForOr") as? NSString
        if priceBookID != nil{
            priceBookIdMain = priceBookID!
        }else{
            priceBookIdMain = ""
        }
        let objReg = self.storyboard?.instantiateViewController(withIdentifier:"SelectProduct") as! SelectProduct
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! ORCreateFirstCell
           // let buyerName: String? = UserDefaults.standard.object(forKey: "buyerNameForOr") as? String
           // let sellername: String? = UserDefaults.standard.object(forKey: "sellerNameForOr") as? String
            let salesTypeNme: String? = UserDefaults.standard.object(forKey: "salesTypeName") as? String
           // let priceBook: String? = UserDefaults.standard.object(forKey: "priceBookForOr") as? String
            let requestorName: String? = UserDefaults.standard.object(forKey: "requestorName") as? String
            
            //let sellerId: String? = UserDefaults.standard.object(forKey: "sellerIDForOr") as? String
            cell.txtBuyerName.text=orBuyerNameMain
            cell.txtSellerName.text = orSellerNameMain
            cell.txtSalesType.text = salesTypeNme
            cell.txtPriceBook.text = orPricebookNameMain
            cell.txtRequestorName.text = requestorName
            cell.txtDeliveryAddress.text = addressNameLable as String
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ORCreateDynamicCell
            cell.lblProductName.text = ProductNameArray[indexPath.row] as? String
            cell.delegateee=self as? ORProductDelegateee
            cell.lblSku.text = ProductSkuArray[indexPath.row] as? String
            cell.lblMeasurment.text = ProductMeasermentNameArray[indexPath.row] as? String
            cell.lblCategoryName.text = ProductCategoryNameArray[indexPath.row] as? String
            cell.lblTotalPrice.text = arrTotalCellAmount[indexPath.row] as? String
            //cell.lblBasicPrice.text=arrBasicPrice[indexPath.row] as? String
            let objData : NSDictionary = arrFinalORProduct[indexPath.row] as! NSDictionary
            let strCurrency: String = (ProductCurrencyNameArray[indexPath.row] as? String)!
            if let quantity : String = objData.value(forKey: "quantity") as? String
            {
                cell.lblQty.text=quantity + "Qty"
            }
            if let totalPrice : String = objData.value(forKey: "totalPrice") as? String
            {
                cell.lblTotalPrice.text=strCurrency + " " + totalPrice
            }
            if let pbp : NSNumber = objData.value(forKey: "priceBookPrice") as? NSNumber
            {
                cell.lblBasicPrice.text=strCurrency + " " + pbp.stringValue
            }
            return cell
        }
    }
    func btnCloseTapped(cell: ORCreateDynamicCell)
    {
        let indexPath001 = self.tableView.indexPath(for: cell)
       // self.arrSelectProduct.remove(indexPath001 as Any)
        //self.arrTotalCellAmount.remove(indexPath001 as Any)
         self.arrTotalCellAmount.removeObject(at: (indexPath001!.row))
        self.arrSelectProduct.removeObject(at: (indexPath001!.row))
        //self.arrSelectProduct.removeObject(at:(indexPath001?.row)!)
        tableView.deleteRows(at:[indexPath001!], with: .left)
        // tblORproductDetail.reloadData()
        print(indexPath001!.row)
        var sum = Double()
        sum = 0.0
        for i in 0..<arrTotalCellAmount.count
        {
            sum = sum + Double(String(describing: arrTotalCellAmount[i]))!
        }
        lblTotalPrice.text = String(sum)
        tableView.reloadData()
    }
    override func tableView(_ tableView:  UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 383.0
        case 1:
            return 86.0
        default:
            return 0.0
        }
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch (section){
        case 0:
            break
        case 1:
            return FooterView
        default:
            break
        }
        return  nil
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        switch (section) {
        case 0:
            break
        case 1:
            return 100.0
        default: break
        }
        return 0.0
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        ORCreateAPialling()
    }
    //APiCalling....================
    func ORCreateAPialling()
    {
         START_INDICATOR()
       
        let salesTypeId: NSString? = UserDefaults.standard.object(forKey: "salesTypeForOr") as? NSString
        let requestorName: String? = UserDefaults.standard.object(forKey: "requestorName") as? String
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(orSellerIDMain, forKey:"sellerOrganizationId")
        objDic .setValue(orBuyerIDMain, forKey:"buyerOrganizationId")
        objDic .setValue(orPricebookIDMain, forKey:"pricebookId")
        objDic .setValue(objInfo.userName, forKey:"creatorName")
        objDic .setValue(requestorName, forKey:"requestorName")
        objDic .setValue("1", forKey:"statusId")
        objDic .setValue(salesTypeId, forKey:"salesTypeId")
        objDic .setValue(strTotalAmount, forKey:"totalAmount")
        objDic .setValue(diliveryidNUmber, forKey:"addressId")
        objDic .setValue(arrFinalORProduct, forKey:"orProductMapProxys")
        objDic .setValue(visitId, forKey:"visitPlanId")
        print(("arrAllProductValue number is==",objDic))

        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "orderRequisition/saleType/" + (salesTypeId! as String) + "/create")
        {(response, permissions) in
            print(("Create OR value is==",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                if let message:String=response!.value(forKey: "message") as? String
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
                        let orList : NSDictionary = response! .value(forKey: "orCreate") as! NSDictionary
                        let value:String = orList.value(forKey: "value") as! String
                        let alert = UIAlertController(title:"Your OR number is:", message:value, preferredStyle: UIAlertControllerStyle.alert)
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
        }
    }
    func OK()
    {
        
        let allVC = self.navigationController?.viewControllers
        let countinggg = (allVC?.count)! - 1
        if visitId == 0{
            getORListing()
            if  let inventoryListVC = allVC![allVC!.count-countinggg] as? ORListScreen {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }
        }else{
            if  let inventoryListVC = allVC![allVC!.count-5] as? VisitLocationProfileScreen {
                isBoolOrderCreateOrCancel = true
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
            }else{
                let story = self.storyboard?.instantiateViewController(withIdentifier:"VisitLocationProfileScreen") as! VisitLocationProfileScreen
                isBoolOrderCreateOrCancel = true
                //let story = self.storyboard?.instantiateViewController(withIdentifier:"VisitMainScreen") as! VisitMainScreen
                self.navigationController?.popToViewController(story, animated: true)
            }
        }
    }
}
