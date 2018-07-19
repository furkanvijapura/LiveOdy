import UIKit
var boolORUpdate = Bool()
var arrEditFinalORProduct : NSMutableArray = NSMutableArray()
var strTotalAmountEdit = String()
var strTotalQTy = String()


class EditOR_SummeryTableViewController: UITableViewController,EditORSummaryCellProductDelegate {
    var buyerName = NSString()
    var sellerName = NSString()
    var creatorDate = NSString()
    var shipAddress = NSString()
    var saleType = NSString()
    var orProducDetails = NSArray()
    var orSalesTypeIdEdit = NSString()
    var totalAmount = String()
    var totalItems = String()
    var orIDEdit = NSNumber()
    var pricebookNameEdit = NSString()
    var pricebookIdEdit = NSNumber()
    var orNumberEdit = NSString()
    var orcurrencySymbolEdit = NSString()
    var arrEditBasicPrice : NSMutableArray = NSMutableArray()
    var arrEditSku : NSMutableArray = NSMutableArray()
    var arrEditMaserment : NSMutableArray = NSMutableArray()
    var arrEditCurrency : NSMutableArray = NSMutableArray()
    var arrEditTotalCellAmount : NSMutableArray = NSMutableArray()
    var arrEditSelectProduct : NSMutableArray = NSMutableArray()
    var arrEditCategoryName : NSMutableArray = NSMutableArray()
    
    // @IBOutlet var lblTotalAmountCurrency: UILabel!
    
    @IBOutlet weak var lblTotalItems: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet var FooterView: UIView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Update OR"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(EditOR_SummeryTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        if boolORUpdate == true {
            lblTotalPrice.text =  (ProductCurrencyNameArray.object(at: 0) as? String)! + " " + totalAmount
            lblTotalItems.text = strTotalQTy
        }
        else{
            lblTotalPrice.text = (orcurrencySymbolEdit as String) + " " + totalAmount
            lblTotalItems.text=totalItems
        }
        print("orProducDetails==",orProducDetails)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        default:
            if boolORUpdate == true
            {
                return arrEditFinalORProduct.count
            }
            else{
                return orProducDetails.count
            }
        }
    }
    @IBAction func btnAddProductTapped(_ sender: Any)
    {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SelectProduct") as! SelectProduct
        orPricebookIDMain=pricebookIdEdit.stringValue
        objReg.orProducDetailsFromUpdate=orProducDetails
        //        ProductName.removeAllObjects()
        //        ProductID.removeAllObjects()
        
        //        ProductSelectName.add(ProductName.object(at: indexPath.row))
        //        ProductIDSelect.add(ProductID.object(at: indexPath.row))
        
        boolORUpdate = true
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveTapped(_ sender: Any) {
        APICallingToUpdateOR()
    }
    func btnCloseTapped(cell:EditORSummaryCellProduct)
    {
        /* var aarr = NSMutableArray()
         aarr = self.orProducDetails.mutableCopy() as! NSMutableArray
         
         let indexPath001 = self.tableView.indexPath(for: cell)
         aarr.remove(indexPath001 as Any)
         //(self.orProducDetails as! NSMutableArray).remove(indexPath001!)
         //(self.orProducDetails.mutableCopy() as AnyObject).remove(indexPath001 as Any)
         //(self.orProducDetails.mutableCopy() as AnyObject).removeObject(at:(indexPath001?.row)!)
         print(aarr)
         self.orProducDetails = aarr as! NSArray
         //self.arrSelectProduct.remove(indexPath001 as Any)
         //self.arrSelectProduct.removeObject(at:(indexPath001?.row)!)
         tableView.delete(indexPath001)
         //tableView.deleteRows(at: [indexPath001!], with: .none)
         //tableView.deleteRows(at:[indexPath001!], with: .left)
         // tblORproductDetail.reloadData()
         print(indexPath001!.row)
         // finalarrayTotal.removeAllObjects()
         tableView.reloadData()*/
        
        let indexPath001 = self.tableView.indexPath(for: cell)
        (self.orProducDetails.mutableCopy() as AnyObject).remove(indexPath001 as Any)
        (self.orProducDetails.mutableCopy() as AnyObject).removeObject(at:(indexPath001?.row)!)
        tableView.deleteRows(at:[indexPath001!], with: .left)
        // tblORproductDetail.reloadData()
        print(indexPath001!.row)
        tableView.reloadData()
        //finalarrayTotal.removeAllObjects()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! EditORSummarycell
            
            let buyerNameEdit: String? = UserDefaults.standard.object(forKey: "buyerName") as? String
            let sellerNameEdit: String? = UserDefaults.standard.object(forKey: "sellerName") as? String
            let saleTypeEdit: String? = UserDefaults.standard.object(forKey: "saleType") as? String
            let creatorDateEdit: String? = UserDefaults.standard.object(forKey: "creatorDate") as? String
            let shipAddressEdit: String? = UserDefaults.standard.object(forKey: "shipAddress") as? String
            let pricebookNameEditEdit: String? = UserDefaults.standard.object(forKey: "pricebookNameEdit") as? String
            
            cell.txtBuyerName.text=buyerNameEdit
            cell.txtSellerName.text=sellerNameEdit
            cell.txtSalesType.text=saleTypeEdit
            cell.txtORDate.text=creatorDateEdit
            cell.txtDiliveryAddress.text=shipAddressEdit
            cell.txtPriceBook.text=pricebookNameEditEdit
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! EditORSummaryCellProduct
            
            //================================update side data=================
            if boolORUpdate == true{
                cell.lblProductName.text = ProductNameArray[indexPath.row] as? String
                cell.lblSku.text = ProductSkuArray[indexPath.row] as? String
                cell.lblMesurement.text = ProductMeasermentNameArray[indexPath.row] as? String
                cell.lblCategoryName.text = ProductCategoryNameArray[indexPath.row] as? String
                // cell.lblTotalPrice.text=arrEditTotalCellAmount[indexPath.row] as? String
                //cell.lblTotalPrice.text=arrEditBasicPrice[indexPath.row] as? String
                let objDataTest : NSDictionary = arrEditFinalORProduct[indexPath.row] as! NSDictionary
                let strCurrency: String = (ProductCurrencyNameArray[indexPath.row] as? String)!
                if let quantity : String = objDataTest.value(forKey: "quantity") as? String
                {
                    cell.lblQty.text = quantity + "Qty"
                }
                if let totalPrice : String = objDataTest.value(forKey: "totalPrice") as? String
                {
                    cell.lblTotalPrice.text=strCurrency + " " + totalPrice
                }
                if let totalPrice : NSNumber = objDataTest.value(forKey: "priceBookPrice") as? NSNumber
                {
                    cell.lblPricebookPrice.text=strCurrency + " " + totalPrice.stringValue
                }
                
            }
                //=====================================================================
            else{
                cell.delegate=self as? EditORSummaryCellProductDelegate
                let objData : NSDictionary = self.orProducDetails[indexPath.row] as! NSDictionary
                //let logoName : String = (objData.value(forKey: "logoName") as? String)!
                let uom : String = (objData.value(forKey: "uom") as? String)!
                let category : String = (objData.value(forKey: "category") as? String)!
                let sku : String = (objData.value(forKey: "sku") as? String)!
                let productName : String = (objData.value(forKey: "productName") as? String)!
                let priceBookPrice : NSNumber = (objData.value(forKey: "priceBookPrice") as? NSNumber)!
                let totalPrice : NSNumber = (objData.value(forKey: "totalPrice") as? NSNumber)!
                let quantity : NSNumber = (objData.value(forKey: "quantity") as? NSNumber)!
                let logoId : NSNumber = (objData.value(forKey: "logoId") as? NSNumber)!
                let logoName : String = (objData.value(forKey: "logoName") as? String)!
                let currencySymbol : String = (objData.value(forKey: "currencySymbol") as? String)!
                if logoName != ""
                {
                    let imgprofile  = Constant.WEBSERVICE_URLUploadImage + logoId.stringValue + "_" + (logoName as String)
                    let strValue:String = imgprofile + "?token=" + objInfo.Token
                    let url = URL(string: strValue)
                    let data = try? Data(contentsOf: url!)
                    if data != nil{
                        cell.imgProfilePic.image = UIImage(data: data!)
                    }
                }
                cell.lblProductName.text=productName
                cell.lblCategoryName.text=category
                cell.lblQty.text=quantity.stringValue + " Qty"
                cell.lblMesurement.text=uom
                cell.lblSku.text=sku
                cell.lblPricebookPrice.text=currencySymbol + " " + priceBookPrice.stringValue
                cell.lblTotalPrice.text=currencySymbol + " " + totalPrice.stringValue
            }
            return cell
            // }
        }
    }
    var point = Int()
    var indexPathStr = String()
    var indexPathProductTotal = String()
    var docName = String()
    func buttonPressed(sender: AnyObject)
    {
        //  let pointInTable: CGPoint = sender.convert(sender.bounds.origin, toView: self.table)
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRow(at: pointInTable)
        print(cellIndexPath!)
        point = cellIndexPath!.row
        print(point)
    }
    func APICallingToDeleteProduct()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(orIDEdit, forKey:"orId")
        objDic .setValue(indexPathStr, forKey:"orProductId")
        objDic .setValue(totalAmount, forKey:"orTotal")
        objDic .setValue(indexPathProductTotal, forKey:"orProductTotal")
        print(("objIdc delete data is ==",objDic))
        //docs/deleteDocument
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "orderRequisition/saleType/" + (orSalesTypeIdEdit as String) + "/delete")
        {
            (response, permissions) in
            //            self.arrayResponse=response!
            print("response is ==",response!)
            self.STOP_INDICATOR()
            let msg:String=(response as AnyObject).value(forKey: "message") as! String
            print(msg)
            let alert = UIAlertController(title:"Message", message:msg, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            {
                (alert:UIAlertAction!) -> Void in
                //self.getORProfile()
                getORListing()
                SOListData = SOModel_List.GenrateSOModelData()
            })
            alert.addAction(okAction)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func btnDeleteProductTapped(_ sender: Any) {
        buttonPressed(sender: sender as AnyObject)
        let id:NSArray=(self.orProducDetails as AnyObject).value(forKey: "id") as! NSArray
        indexPathStr = (id[point] as AnyObject).stringValue
        
        let productTotal:NSArray=(self.orProducDetails as AnyObject).value(forKey: "totalPrice") as! NSArray
        indexPathProductTotal = (productTotal[point] as AnyObject).stringValue
        
        let alert = UIAlertController(title: "Delete Document", message:"Are you sure you want to delete this product?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
        {
            (alert:UIAlertAction!) -> Void in
            self.APICallingToDeleteProduct()
            getORListing()
            tablevaaaar.reloadData()
            // self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "No", style: .default, handler:
        {
            (alert:UIAlertAction!) -> Void in
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func APICallingToUpdateOR()
    {
        START_INDICATOR()
        let pricebookIdEditEdit: NSNumber? = UserDefaults.standard.object(forKey: "pricebookIdEdit") as? NSNumber
        let orNumberEditEdit: String? = UserDefaults.standard.object(forKey: "orNumberEdit") as? String
        let orIDEditEdit: NSNumber? = UserDefaults.standard.object(forKey: "orIDEdit") as? NSNumber
        let orSalesTypeId: NSString? = UserDefaults.standard.object(forKey: "orSalesTypeId") as? NSString
        
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(orIDEditEdit, forKey:"id")
        objDic .setValue(pricebookIdEditEdit, forKey:"pricebookId")
        objDic .setValue(totalAmount, forKey:"totalAmount")
        objDic .setValue(orNumberEditEdit, forKey:"orNumber")
        if boolORUpdate == true
        {
            objDic .setValue(arrEditFinalORProduct, forKey:"orProductMapProxys")
        }
        else{
            objDic .setValue(orProducDetails, forKey:"orProductMapProxys")
        }
        print(("objIdc delete data is ==",objDic))
        //docs/deleteDocument
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "orderRequisition/saleType/" + (orSalesTypeId! as String)  + "/update")
        {
            (response, permissions) in
            //            self.arrayResponse=response!
            print("response is ==",response!)
            self.STOP_INDICATOR()
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
                    let alert = UIAlertController(title:message, message:"", preferredStyle: UIAlertControllerStyle.alert)
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
    
    func OK()
    {
        getORListing()
        ProductIDArray.removeAllObjects()
        ProductNameArray.removeAllObjects()
        ProductPriBpriArray.removeAllObjects()
        ProductSkuArray.removeAllObjects()
        ProductCategoryNameArray.removeAllObjects()
        ProductMeasermentNameArray.removeAllObjects()
        ProductCurrencyNameArray.removeAllObjects()
        
        tableeeORListScreen.reloadData()
        let allVC = self.navigationController?.viewControllers
        let countinggg = (allVC?.count)! - 1
        if  let inventoryListVC = allVC![allVC!.count-countinggg] as? ORListScreen {
            self.navigationController!.popToViewController(inventoryListVC, animated: true)
        }
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
    
}


