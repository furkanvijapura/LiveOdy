

import UIKit

class ORProfile: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate
{
    var pricebookId = NSNumber()
    var pricebookName = NSString()
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lbltotleitem: UILabel!
    @IBOutlet var FooterViewTotal: UIView!
    @IBOutlet weak var tblORPro: UITableView!
    var orListId = NSString()
    var orSalesTypeId = NSString()
    var buyerName = NSString()
    var sellerName = NSString()
    var orNumber = NSString()
    var status = NSString()
    var crateDate = NSString()
    var creatorName = NSString()
    var requestorName = NSString()
    var orcurrencySymbol = NSString()
    var shipAddress = NSString()
    var saleType = NSString()
    var totalAmount = Double()
    var totalItems = Double()

    var oramountFormater = String()
    var orProducDetails = NSArray()
    var salesyTypeID = NSNumber()
    var buyerID = NSNumber()
    var buyerLogoName = NSString()
    var orID = NSNumber()
    var approveRejectOrder = Int()
    var Status_Id = Int()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        approveRejectOrder = (objInfo.permision.value(forKey: "CRM_ORDERREQUISITION_APPROVEREJECT") as? Int)!
        self.title = "OR Profile"
        self.tblORPro.separatorStyle = UITableViewCellSeparatorStyle.none
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ORProfile.back(sender:)))
        getORProfile()
        refreshiingBoooo = false
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.tblORPro.addSubview(refreshControl)
        self.navigationItem.leftBarButtonItem = backButton
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        getORProfile()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    var point = Int()
    var indexPathStr = String()
    var indexPathProductTotal = String()
    var docName = String()
    func buttonPressed(sender: AnyObject)
    {
        //  let pointInTable: CGPoint = sender.convert(sender.bounds.origin, toView: self.table)
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.tblORPro)
        let cellIndexPath = self.tblORPro.indexPathForRow(at: pointInTable)
        print(cellIndexPath!)
        point = cellIndexPath!.row
        print(point)
    }
    
    func APICallingToDeleteProduct()
    {
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(orID, forKey:"orId")
        objDic .setValue(indexPathStr, forKey:"orProductId")
        objDic .setValue(totalAmount, forKey:"orTotal")
        objDic .setValue(indexPathProductTotal, forKey:"orProductTotal")
        print(("objIdc delete data is ==",objDic))
        //docs/deleteDocument
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "orderRequisition/saleType/" + salesyTypeID.stringValue + "/delete")
        {
            (response, permissions) in
            self.STOP_INDICATOR()
            //            self.arrayResponse=response!
            print("response is ==",response!)
            let msg:String=(response as AnyObject).value(forKey: "message") as! String
            print(msg)
            let alert = UIAlertController(title:"Message", message:msg, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            {
                (alert:UIAlertAction!) -> Void in
                self.getORProfile()
                getORListing()
               // SOListData = SOModel_List.GenrateSOModelData()
            })
            alert.addAction(okAction)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func btnDeleteTapped(_ sender: Any)
    {
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
    var generatePedingSoDic = NSDictionary()

    func getORProfile()
    {
         START_INDICATOR()
        APISession.getDataWithRequest(withAPIName: "orderRequisition/saleType/" + (orSalesTypeId as String) + "/profile/" + (orListId as String))
        {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
               refreshControl.endRefreshing()
                if let status:Int=response!.value(forKey: "status") as? Int
                {
                if status==0
                {
                    let alert = UIAlertController(title:"No Profile Data Available", message:"", preferredStyle: UIAlertControllerStyle.alert)
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
                let orList : NSDictionary = response! .value(forKey: "orProfile") as! NSDictionary
                print("orList==",orList)
                self.generatePedingSoDic = orList
                self.buyerName = orList.value(forKey: "buyerOrganizationName") as! NSString
                self.sellerName = orList.value(forKey: "sellerOrganizationName") as! NSString
                self.orNumber = orList.value(forKey: "orNumber") as! NSString
                self.status = orList.value(forKey: "status") as! NSString
                self.crateDate = orList.value(forKey: "createdDate") as! NSString
                self.creatorName = orList.value(forKey: "creatorName") as! NSString
                self.requestorName = orList.value(forKey: "requestorName") as! NSString
                self.shipAddress = orList.value(forKey: "shipTo") as! NSString
                self.saleType = orList.value(forKey: "salesTypeName") as! NSString
                self.orID = orList.value(forKey: "id") as! NSNumber
                self.salesyTypeID = orList.value(forKey: "salesTypeId") as! NSNumber
                self.totalAmount = orList.value(forKey: "totalAmount") as! Double
                self.totalItems = orList.value(forKey: "totalQty") as! Double
                self.pricebookId = orList.value(forKey: "pricebookId") as! NSNumber
                self.pricebookName = orList.value(forKey: "pricebookName") as! NSString
                self.orcurrencySymbol = orList.value(forKey: "currencySymbol") as! NSString
                self.buyerID = orList.value(forKey: "buyerLogoId") as! NSNumber
                self.buyerLogoName = orList.value(forKey: "buyerLogoName") as! NSString
                self.orProducDetails = orList.value(forKey: "orProductMapProxys") as! NSArray
                print("orProducDetails====",self.orProducDetails)
                self.oramountFormater =  String(format:"%.1f", self.totalAmount)
                self.lblTotalPrice.text = (self.orcurrencySymbol as String) + " " + self.oramountFormater
                self.lbltotleitem.text=String(self.totalItems)
                }
                }
            }
            self.tblORPro.reloadData()
        }
    }
    func OK()
    {
//        getSOListing()
        let story = storyboard?.instantiateViewController(withIdentifier: "SOProfileScreen") as! SOProfileScreen
        story.salesyTypeID = salesyTypeID
        story.soListId = orListId
        
//        self.navigationController?.popToViewController(story, animated: true)
//        _ = navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(story, animated: true)
    }
    @IBAction func btnRejectTapped(_ sender: Any)
    {
        Status_Id = 3
        Approve()
        //ShowAlert()
    }
    @IBAction func btnProcessSOTapped(_ sender: Any) {
        PendingSOCreateAPICalling()
    }
    func PendingSOCreateAPICalling()
    {
         START_INDICATOR()
        let dicArray = NSMutableArray()
        let dic = NSMutableDictionary()
        for i in 0..<orProducDetails.count{
            let productDetail : NSDictionary = orProducDetails[i] as! NSDictionary
            dic.setValue(productDetail.value(forKey: "proId"), forKey: "productId")
            dic.setValue(productDetail.value(forKey: "productName"), forKey: "productName")
            dic.setValue(productDetail.value(forKey: "quantity"), forKey: "quantity")
            dic.setValue(productDetail.value(forKey: "priceBookPrice"), forKey: "basicPrice")
            dic.setValue(productDetail.value(forKey: "totalPrice"), forKey: "productTotal")
            dic.setValue(productDetail.value(forKey: "priceBookPrice"), forKey: "priceBookPrice")
            dic.setValue(productDetail.value(forKey: "0"), forKey: "discountAmount")
            dicArray.add(dic)
        }
        
        let buyerOrganizationId : NSNumber = (generatePedingSoDic.value(forKey: "buyerOrganizationId") as? NSNumber)!
        let salesTypeId : NSNumber = (generatePedingSoDic.value(forKey: "salesTypeId") as? NSNumber)!
        let addressId : NSNumber = (generatePedingSoDic.value(forKey: "addressId") as? NSNumber)!
        let pricebookId : NSNumber = (generatePedingSoDic.value(forKey: "pricebookId") as? NSNumber)!
        let sellerOrganizationId : NSNumber = (generatePedingSoDic.value(forKey: "sellerOrganizationId") as? NSNumber)!
        let createdDate : String = (generatePedingSoDic.value(forKey: "createdDate") as? String)!
        let buyerOrganizationName : String = (generatePedingSoDic.value(forKey: "buyerOrganizationName") as? String)!
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(buyerOrganizationId, forKey:"organizationId")
        objDic .setValue(salesTypeId, forKey:"saleTypeId")
        objDic .setValue("4", forKey:"statusId")
        objDic .setValue(addressId, forKey:"shippingAddress")
        objDic .setValue("0", forKey:"discountPercentage")
        objDic .setValue("0", forKey:"totalDiscount")
        objDic .setValue("0", forKey:"approverId")
        objDic .setValue(pricebookId, forKey:"priceBookId")
        objDic .setValue(sellerOrganizationId, forKey:"fromOrganizationId")
        objDic .setValue(createdDate, forKey:"saleDateStr")
        objDic .setValue("percentage", forKey:"discountType")
        objDic .setValue(buyerOrganizationName, forKey:"organizationName")
        objDic .setValue(totalAmount, forKey:"totalPrice")
        objDic .setValue("0", forKey:"totalWithoutTax")
        objDic .setValue(totalItems, forKey:"totalQty")
        objDic .setValue(totalAmount, forKey:"grandTotal")
        objDic .setValue(dicArray, forKey:"productList")
        objDic .setValue([orListId], forKey:"orIdList")
        print(("arrAllProductValue number is==",objDic))
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "saleOrder/create")
        {(response, permissions) in
            print(("Create SO value is==",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let status: NSNumber = (response!.value(forKey: "status") as? NSNumber)!
                if status == 1
                {
                          let soList : NSDictionary = response! .value(forKey: "soCreate") as! NSDictionary
                            let value:String = soList.value(forKey: "value") as! String
                            let alert = UIAlertController(title:"Your SO number is:", message:value, preferredStyle: UIAlertControllerStyle.alert)
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
                else if status==0
                {
                    if let message:String=response!.value(forKey: "message") as? String
                    {
                            let alert = UIAlertController(title:"", message:message, preferredStyle: UIAlertControllerStyle.alert)
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
                }
                else if status==2{
                    if let message:String=response!.value(forKey: "message") as? String
                    {
                        let alert = UIAlertController(title:"", message:message, preferredStyle: UIAlertControllerStyle.alert)
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
    @IBAction func btnApprevedTapped(_ sender: Any)
    {
        Status_Id = 4
        Approve()
        //ShowAlert()
    }
    @IBAction func btnEditSummeryTapped(_ sender: Any) {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"EditOR_SummeryTableViewController") as! EditOR_SummeryTableViewController
        objReg.buyerName=buyerName
        objReg.sellerName=sellerName
        objReg.saleType=saleType
        objReg.shipAddress=shipAddress
        objReg.creatorDate=requestorName
        objReg.orProducDetails = orProducDetails
        totalAmount = Double(Float(oramountFormater)!)
        objReg.totalAmount=oramountFormater
        objReg.totalItems=String(totalItems)
        objReg.orSalesTypeIdEdit=orSalesTypeId
        objReg.orIDEdit=orID
         totalItems = Double(Float(totalItems))
        objReg.pricebookIdEdit=pricebookId
        objReg.pricebookNameEdit=pricebookName
        objReg.orNumberEdit=orNumber
        objReg.orcurrencySymbolEdit=orcurrencySymbol
        boolORUpdate = false
        UserDefaults.standard.setValue(buyerName, forKey: "buyerName")
        UserDefaults.standard.setValue(sellerName, forKey: "sellerName")
        UserDefaults.standard.setValue(requestorName, forKey: "creatorDate")
        UserDefaults.standard.setValue(shipAddress, forKey: "shipAddress")
        UserDefaults.standard.setValue(saleType, forKey: "saleType")
        UserDefaults.standard.setValue(pricebookName, forKey: "pricebookNameEdit")
        UserDefaults.standard.setValue(orID, forKey: "orIDEdit")
        UserDefaults.standard.setValue(pricebookId, forKey: "pricebookIdEdit")
        UserDefaults.standard.setValue(orNumber, forKey: "orNumberEdit")
        UserDefaults.standard.setValue(orSalesTypeId, forKey: "orSalesTypeId")
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell1  = tableView.dequeueReusableCell(withIdentifier: "cell") as! ORProfileCell
            cell1.lblBuyerName.text=buyerName as String
            cell1.lblSellerName.text=sellerName as String
            cell1.lblSalesType.text=saleType as String
            cell1.lblOrNumber.text=orNumber as String
            cell1.lblCreateDate.text=crateDate as String
            cell1.lblCreaterName.text=creatorName as String
            cell1.lblShipToAddress.text=shipAddress as String
            if buyerLogoName != ""
            {
                let imgprofile  = Constant.WEBSERVICE_URLUploadImage + buyerID.stringValue + "_" + (buyerLogoName as String)
                let strValue:String = imgprofile + "?token=" + objInfo.Token
                let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: urlString!)
//                let url = URL(string: strValue)
                let data = try? Data(contentsOf: url!)
                  if data != nil{
                cell1.imgProfilePic.image = UIImage(data: data!)
                }
            }
            cell1.btnStatus.setTitle(status as String, for: UIControlState.normal)
            if status=="Pending SO"
            {
                cell1.btnStatus.backgroundColor=UIColor(red: 44/255, green: 123/255, blue: 180/255, alpha: 1.0)
                cell1.btnEdit.isHidden = true
                cell1.btnApprove.isHidden = true
                cell1.btnReject.isHidden = true
                cell1.btnProcessSO.isHidden=false
            }
            else if status=="Cancelled"
            {
                cell1.btnStatus.backgroundColor=UIColor(red: 218/255, green: 82/255, blue: 82/255, alpha: 1.0)
                cell1.btnEdit.isHidden = true
                cell1.btnApprove.isHidden = true
                cell1.btnReject.isHidden = true
                cell1.btnProcessSO.isHidden=true

            }
            else if status=="SO Created"
            {
                cell1.btnStatus.backgroundColor=UIColor(red: 93/255, green: 183/255, blue: 98/255, alpha: 1.0)
                cell1.btnEdit.isHidden = true
                cell1.btnApprove.isHidden = true
                cell1.btnReject.isHidden = true
                cell1.btnProcessSO.isHidden=true
            }
            else if status=="Draft"
            {
                cell1.btnStatus.backgroundColor=UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
                if approveRejectOrder == 1 && addUpdateOrder==0{
                cell1.btnEdit.isHidden = true
                cell1.btnApprove.isHidden = false
                cell1.btnReject.isHidden = false
                cell1.btnProcessSO.isHidden=true
                }
                else if addUpdateOrder == 1 && approveRejectOrder==0{
                    cell1.btnEdit.isHidden = false
                    cell1.btnApprove.isHidden = true
                    cell1.btnReject.isHidden = true
                }
                else if addUpdateOrder == 1 && approveRejectOrder == 1{
                    cell1.btnEdit.isHidden = false
                    cell1.btnApprove.isHidden = false
                    cell1.btnReject.isHidden = false
                    cell1.btnProcessSO.isHidden=true
                }
                else{
                    cell1.btnEdit.isHidden = true
                    cell1.btnApprove.isHidden = true
                    cell1.btnReject.isHidden = true
                    cell1.btnProcessSO.isHidden=true
                }
            }
            else
            {
                cell1.btnStatus.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                cell1.btnEdit.isHidden = true
                cell1.btnApprove.isHidden = true
                cell1.btnReject.isHidden = true
                cell1.btnProcessSO.isHidden=true
            }
            return cell1
        }
        else
        {
            let cell4  = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ProductCell
            if orProducDetails.count==0
            {
                cell4.viewBackMain.isHidden=true
                cell4.lblNoProduct.isHidden=false
                FooterViewTotal.isHidden=true
            }
            else{
                cell4.viewBackMain.isHidden=false
                cell4.lblNoProduct.isHidden=true
                FooterViewTotal.isHidden=false

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

            cell4.lblProductName.text=productName
            cell4.lblProductdetails.text=category
            cell4.lblQty.text=quantity.stringValue + " Qty"
            cell4.lblUcom.text=uom
            cell4.lblskuname.text=sku
            cell4.btnPriceBookprice.setTitle(currencySymbol + " " + priceBookPrice.stringValue, for: UIControlState.normal)
            cell4.lblTotalAmount.text=currencySymbol + " " + totalPrice.stringValue
            if status=="Draft"
            {
                cell4.btnDelete.isHidden=false
            }
            else{
                cell4.btnDelete.isHidden=true
            }
                /*
            if logoName != ""
            {
                let imgprofile  = Constant.WEBSERVICE_URLUploadImage + logoId.stringValue + "_" + logoName
                let strValue:String = imgprofile + "?token=" + objInfo.Token
                let url = URL(string: strValue)
                let data = try? Data(contentsOf: url!)
                cell4.imgProductProfilepic.image = UIImage(data: data!)
            }
 */
            }
            return cell4
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0:
            return 0.0
        case 1:
            return 30.0
        default:
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            return 1
        default:
            if orProducDetails.count==0
            {
                return 1
            }
            else{
            return orProducDetails.count
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300.0
        case 1:
            return 100.0
        default:
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch (section) {
        case 0: break
        default:
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.backgroundColor = UIColor.gray
            let label = UILabel(frame: CGRect(x: 15, y: 5, width: 400, height: 20));
            label.text = "Product"
            header.contentView.addSubview(label)
        }
        
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return FooterViewTotal
        default:
            return FooterViewTotal
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch (section)
        {
        case 0:
            return 0.0
        default:
            return 60.0
        }
    }
    
    //MARK:- Api Approve and Reject
    
    func Approve()
    {
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(orID, forKey:"id")
        objDic .setValue(self.orNumber, forKey:"orNumber")
        objDic .setValue(self.Status_Id, forKey:"statusId")
        print(("objIdc approve data is ==",objDic))
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "orderRequisition/saleType/" + salesyTypeID.stringValue + "/approveReject")
        {
            (response, permissions) in
            print("response.....",response!)
            self.STOP_INDICATOR()
            print(self.salesyTypeID.stringValue)
            
            if self.salesyTypeID.stringValue == "1"
            {
                let status = response?.value(forKey: "status")as! Int
                
                if status == 0
                    
                {
                    let msg = response?.value(forKey: "message")as! NSString
                    
                    self.displayAlertMessage(messageToDisplay: msg as String)
                }
                else
                {
                    let msg = response?.value(forKey: "message")as! NSString
                    
//                    let OrUpdate = response?.value(forKey: "OrUpdate")as! NSDictionary
//
//                    let id = OrUpdate.value(forKey: "value")as! NSString
//
                    let alert = UIAlertController(title:"", message: msg as String, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
                        
                        {
                            (alert:UIAlertAction!) -> Void in
                            
                            self.ok()
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
                let status = response?.value(forKey: "status")as! Int
                
                if status == 0
                {
                    let msg = response?.value(forKey: "message")as! NSString
                    self.displayAlertMessage(messageToDisplay: msg as String)
                }
                else
                {
                    
                    let msg = response?.value(forKey: "message")as! NSString
                    
//                    let distOrUpdate = response?.value(forKey: "distOrUpdate")as! NSDictionary
//
//                    let id = distOrUpdate.value(forKey: "value")as! NSString
//
                    let alert = UIAlertController(title:"", message: msg as String, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
                        {
                            (alert:UIAlertAction!) -> Void in
                            self.ok()
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
    
    func ok()
        
    {
        self.getORProfile()
        //self.navigationController?.popToRootViewController(animated: true)
       
    }
}

