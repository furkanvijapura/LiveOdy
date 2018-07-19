//
//  EditSOSummeryDetailsScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 16/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
var boolSOUpdate = Bool()
class EditSOSummeryDetailsScreen: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    //LinkPendinMain Array
    var LinkedMainAll = NSArray()
    // @IBOutlet weak var btndeleteOL: UIButton!
    @IBOutlet var lblTotalItems: UILabel!
    var buyerName = NSString()
    var status = NSString()
    var approverName = NSString()
    var sellerName = NSString()
    var creatorDate = NSString()
    var shipAddress = NSString()
    var saleType = NSString()
    var soProducDetails = NSArray()
    var orSalesTypeIdEdit = NSString()
    var totalAmount = String()
    var orIDEdit = NSNumber()
    var approcedIDEdit = NSNumber()
    var statusID = NSNumber()
    var soTotalEditQty = String()
    var pricebookNameEdit = NSString()
    var pricebookIdEdit = NSNumber()
    var orNumberEdit = NSString()
    var socurrencySymbolEdit = NSString()
    var arraySOApproverNameListGenerat = NSArray()
    
    @IBOutlet var lblAfterFinalAmount: UILabel!
    @IBOutlet var lblTotalDiscount: UILabel!
    @IBOutlet var lblFinalDiscount: UILabel!
    @IBOutlet var lblFinalAmount: UILabel!
    
    var arrFinalSOProduct : NSMutableArray = NSMutableArray()
    var arrBasicPrice : NSMutableArray = NSMutableArray()
    var arrSku : NSMutableArray = NSMutableArray()
    var arrMaserment : NSMutableArray = NSMutableArray()
    var arrSelectProduct : NSMutableArray = NSMutableArray()
    var arrCategoryName : NSMutableArray = NSMutableArray()
    var CurrencySymbolEdit : NSMutableArray = NSMutableArray()
    var strTotalAmount = String()
    var logoEditProfileId = NSNumber()
    var logoEditProfileName = NSString()
    var strTotalItemsEdit = String()
    
    @IBOutlet weak var tblOSSummery: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getGenerateApproverList()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(SOSummeryDetailsScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        self.title = "Update SO"
        totalHeaderCalc()
        soApproverName.removeAll()
        print("- -- -ProductProfileDataMain- -- -- ->",LinkPendinORUpdate.ProductProfileDataMain)
        
        self.soProducDetails = LinkPendinORUpdate.ProductProfileDataMain
        print("so ProducDetails datasss==>>> ",soProducDetails)
        LinkPendinORUpdate.ProductSelectName.removeAllObjects()
        LinkPendinORUpdate.ProductIDSelect.removeAllObjects()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let indexxx = IndexPath(row: 0, section: 0)
        // Linked Pendig Update OR
        if indexxx.section == 0
        {
            let cell = tblOSSummery.dequeueReusableCell(withIdentifier: "cell", for: indexxx) as! EditSOCreatMainCell
            cell.txtLinkPendingOr.text = LinkPendinORUpdate.ProductSelectName.componentsJoined(by: ", ")
            cell.txtApproverName.text = soApproverName
        }
        if LinkPendinORUpdate.LinkedFinaleArray.count != 0
        {
            if LinkPendinORUpdate.ProductIDSelect.count == 0
            {
                soProducDetails = LinkPendinORUpdate.ProductProfileDataMain
            }
            else
            {
                soProducDetails = LinkPendinORUpdate.LinkedFinaleArray
            }
        }else if LinkPendinORUpdate.ProductProfileDataMain.count != 0{
            soProducDetails = LinkPendinORUpdate.ProductProfileDataMain
        }
        totalHeaderCalc()
        // LinkedProMarging()
        tblOSSummery.reloadData()
    }
    func totalHeaderCalc(){
        
        var arrAmont  =  [0.0]
        var aarQty  = [0.0]
        var totalAmountT = Double()
        var soTotalEditQtT = Double()
        for amount in 0..<soProducDetails.count{
            let objData : NSDictionary = self.soProducDetails[amount] as! NSDictionary
            let av  = objData.value(forKey: "productTotal")
            let fdf = objData.value(forKey: "quantity")
            arrAmont.append(av as! Double)
            aarQty.append(fdf as! Double)
        }
        for a in 0..<arrAmont.count{
            totalAmountT = arrAmont[a]  + totalAmountT
            soTotalEditQtT = aarQty[a] + soTotalEditQtT
        }
        totalAmount = String(format: "%.2f", totalAmountT)//"\(totalAmountT)"
        soTotalEditQty = String(format: "%.2f", soTotalEditQtT)// "\(soTotalEditQtT)"
        lblFinalAmount.text = (socurrencySymbolEdit as String) + " " + totalAmount
        lblAfterFinalAmount.text = (socurrencySymbolEdit as String) + " " + totalAmount
        lblFinalDiscount.text = (socurrencySymbolEdit as String) + " " + "0"
        lblTotalItems.text = soTotalEditQty + " Items"
    }
    //Linked Data product Marging
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnApproverTapped(_ sender: Any) {
        if Reachability.isConnectedToNetwork(){
            let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "SOApproverList") as? SOApproverList
            self.present(destination1!, animated: false, completion: nil)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    // Link Pending OR Selection
    @IBAction func btnLinkPeding(_ sender: Any) {
        LinkPendinORUpdate.PrdocutFinalMargArray.removeAllObjects()
        if LinkPendinORUpdate.PendinORList.count != 0{
            let story = self.storyboard?.instantiateViewController(withIdentifier:"EditSOSummeryLinkPendingSelection") as! EditSOSummeryLinkPendingSelection
            self.navigationController?.present(story, animated: true, completion: nil)
        }else{
            self.displayAlertMessage(messageToDisplay: "Linked Data are not available!")
        }
    }
    @IBAction func btnAddProductTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork()
        {
            //Link peding OR \ update SO
            // LinkPendinOR.LinkedFinaleArray.removeAllObjects()
            LinkPendinOR.LinkedFinaleArray = LinkPendinORUpdate.LinkedFinaleArray
            // LinkPendinOR.ProductMargArray.removeAllObjects()
            LinkPendinOR.ProductMargArray  = LinkPendinORUpdate.LinkedFinaleArray
            
            boolSOUpdate = true
            
            let objReg = self.storyboard?.instantiateViewController(withIdentifier:"SOSelectProduct") as! SOSelectProduct
            let sopricebookIdEdit: NSNumber? = UserDefaults.standard.object(forKey: "sopricebookIdEdit") as? NSNumber
            soPricebookIDMain=(sopricebookIdEdit?.stringValue)!
            // boolSOUpdate = true
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func getGenerateApproverList()
    {
        if Reachability.isConnectedToNetwork(){
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
                    var linkpendingor = NSArray()
                    linkpendingor = (response!.value(forKey: "sellerDetails") as! NSDictionary).value(forKey: "linkPendingOR") as! NSArray
                    if linkpendingor.count != 0
                    {
                        LinkPendinORUpdate.PendinORList = linkpendingor
                    }
                    let allsellerDetails : NSDictionary = response! .value(forKey: "sellerDetails") as! NSDictionary
                    print("orList==",allsellerDetails)
                    
                    self.arraySOApproverNameListGenerat = allsellerDetails.value(forKey: "approversName") as! NSArray
                    SOApproverListarr = self.arraySOApproverNameListGenerat
                }
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return soProducDetails.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tblOSSummery.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EditSOCreatMainCell
            
            let sobuyerName: String? = UserDefaults.standard.object(forKey: "sobuyerName") as? String
            let sosellerName: String? = UserDefaults.standard.object(forKey: "sosellerName") as? String
            let socreatorDate: String? = UserDefaults.standard.object(forKey: "socreatorDate") as? String
            let soshipAddress: String? = UserDefaults.standard.object(forKey: "soshipAddress") as? String
            let sosaleType: String? = UserDefaults.standard.object(forKey: "sosaleType") as? String
            let sopricebookNameEdit: String? = UserDefaults.standard.object(forKey: "sopricebookNameEdit") as? String
            //let socreatorName: String? = UserDefaults.standard.object(forKey: "socreatorName") as? String
            let sostatus: String? = UserDefaults.standard.object(forKey: "sostatus") as? String
            
            cell.txtOrgName.text=sobuyerName
            cell.txtRetailerName.text=sosellerName
            cell.txtSalesType.text=sosaleType
            cell.txtSelectdate.text=socreatorDate
            cell.txtShippingAddress.text=soshipAddress
            cell.txtPricebookPrice.text=sopricebookNameEdit
            //cell.txtApproverName.text=socreatorName
            cell.txtStatus.text=sostatus
            return cell
        case 1:
            let cell = tblOSSummery.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! EditSOCreatProductcell
            
            //Link pending OR New Implement
            
            let objData : NSDictionary = self.soProducDetails[indexPath.row] as! NSDictionary
            //            let logoName : String = (objData.value(forKey: "logoName") as? String)!
            let uom : String = (objData.value(forKey: "uom") as! String)
            let category : String = (objData.value(forKey: "categoryName") as! String)
            let sku : String = (objData.value(forKey: "sku") as! String)
            let productName : String = (objData.value(forKey: "productName") as! String)
            let priceBookPrice : Double = objData.value(forKey: "priceBookPrice") as! Double
            let totalPrice : Double = objData.value(forKey: "productTotal") as! Double
            let quantity : Double = objData.value(forKey: "quantity") as! Double
            var basicPrice : Double = objData.value(forKey: "basicPrice") as! Double
            let discount : Double = objData.value(forKey: "discountAmount") as! Double
            let logoId : NSNumber = objData.value(forKey: "logoId") as! NSNumber
            let logoName : String = objData.value(forKey: "logoName") as! String
            let currencySymbol : String = (objData.value(forKey: "currencySymbol") as! String)
            
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
            basicPrice = basicPrice - discount
            cell.lblProductName.text=productName
            cell.lblCategoryName.text=category
            cell.lblMesurement.text=uom
            cell.lblSku.text=sku
            cell.btnPriceBookPrice.setTitle(currencySymbol + " " + String(format: "%.2f", priceBookPrice), for: UIControlState.normal)
            cell.btnDiscount.setTitle(currencySymbol + " " + String(format: "%.2f", discount), for: UIControlState.normal)
            cell.btnSellngPrice.setTitle(currencySymbol + " " + String(format: "%.2f", basicPrice), for: UIControlState.normal)
            cell.btnFinalAmount.setTitle(currencySymbol + " " + String(format: "%.2f", totalPrice), for: UIControlState.normal)
            cell.btnQTy.setTitle(String(format: "%.2f", quantity) + " Qty", for: UIControlState.normal)
            
            return cell
        default :
            let cell = tblOSSummery.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EditSOCreatAddresscell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 540.0
        case 1:
            return 86.0
        case 2:
            return 100.0
        default:break
        }
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    var point = Int()
    var indexPathStr = String()
    var indexPathProductTotal = String()
    var indexPathProductQuntity = String()
    var docName = String()
    func buttonPressed(sender: AnyObject)
    {
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.tblOSSummery)
        let cellIndexPath = self.tblOSSummery.indexPathForRow(at: pointInTable)
        print(cellIndexPath!)
        point = cellIndexPath!.row
        print(point)
    }
    
    func APICallingToDeleteProduct()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            let objDic:NSMutableDictionary=NSMutableDictionary.init()
            objDic .setValue(orIDEdit, forKey:"soId")
            objDic .setValue(indexPathStr, forKey:"soProductId")
            objDic .setValue(totalAmount, forKey:"soTotal")
            objDic .setValue(indexPathProductTotal, forKey:"soProductTotal")
            objDic .setValue(soTotalEditQty, forKey:"soTotalQuantity")
            objDic .setValue("0", forKey:"soTotalDiscount")
            objDic .setValue(indexPathProductQuntity, forKey:"soProductQuantity")
            print(("objIdc delete data is ==",objDic))
            //docs/deleteDocument
            APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "saleOrder/saleType/" + (orSalesTypeIdEdit as String) + "/delete")
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
                    // self.getSOProfile()
                    getSOListing()
                    SOListData = SOModel_List.GenrateSOModelData()
                    self.totalHeaderCalc()
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
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    @IBAction func btnDeleteSOProductTapped(_ sender: Any) {
        if Reachability.isConnectedToNetwork(){
            buttonPressed(sender: sender as AnyObject)
            let id:NSArray=(self.soProducDetails as AnyObject).value(forKey: "id") as! NSArray
            indexPathStr = (id[point] as AnyObject).stringValue
            
            let productTotal:NSArray=(self.soProducDetails as AnyObject).value(forKey: "productTotal") as! NSArray
            indexPathProductTotal = (productTotal[point] as AnyObject).stringValue
            
            let productQuantity:NSArray=(self.soProducDetails as AnyObject).value(forKey: "quantity") as! NSArray
            indexPathProductQuntity = (productQuantity[point] as AnyObject).stringValue
            
            let alert = UIAlertController(title: "Delete Document", message:"Are you sure you want to delete this product?", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
            {
                (alert:UIAlertAction!) -> Void in
                self.APICallingToDeleteProduct()
                
//                getORListing()
                getSOListing()
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
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnSaveTapped(_ sender: Any) {
        if Reachability.isConnectedToNetwork(){
            SOUpdatePialling()
            let allVC = self.navigationController?.viewControllers
            let countinggg = (allVC?.count)! - 1
            if  let inventoryListVC = allVC![allVC!.count-countinggg] as? SOListScreen {
                self.navigationController!.popToViewController(inventoryListVC, animated: true)
                self.STOP_INDICATOR()
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    func SOUpdatePialling()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            let sopricebookIdEdit: NSNumber? = UserDefaults.standard.object(forKey: "sopricebookIdEdit") as? NSNumber
            let soNumberEdit: String? = UserDefaults.standard.object(forKey: "soNumberEdit") as? String
            let soIDEdit: NSNumber? = UserDefaults.standard.object(forKey: "soIDEdit") as? NSNumber
            let soSalesTypeId: NSString? = UserDefaults.standard.object(forKey: "soSalesTypeId") as? NSString
            // let sostatusId: NSString? = UserDefaults.standard.object(forKey: "sostatusId") as? NSString
//            let approvedID: NSString? = UserDefaults.standard.object(forKey: "approvedID") as? NSString
            
            let objDic:NSMutableDictionary=NSMutableDictionary.init()
            objDic .setValue(soIDEdit, forKey:"id")
            objDic .setValue(soNumberEdit, forKey:"soNumberEdit")
            objDic .setValue(soApproverID, forKey:"approverId")
            objDic .setValue(sopricebookIdEdit, forKey:"priceBookId")
            objDic .setValue("0", forKey:"discountPercentage")
            objDic .setValue("4", forKey:"statusId")
            objDic .setValue("0", forKey:"totalWithoutTax")
            objDic .setValue("0", forKey:"totalDiscount")
            objDic .setValue("percentage", forKey:"discountType")
            objDic .setValue(totalAmount, forKey:"totalPrice")
            objDic .setValue(totalAmount, forKey:"grandTotal")
            objDic .setValue(soTotalEditQty, forKey:"totalQty")
            objDic .setValue(soProducDetails, forKey:"productList")
            //        }
            print(("objIdc delete data is ==",objDic))
            //docs/deleteDocument
            APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "saleOrder/saleType/" + (soSalesTypeId! as String) + "/update")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                //            self.arrayResponse=response!
                print("response is ==",response!)
                if response != nil
                {
                    let message = (response!.value(forKey: "message") as? String)!
                    let status = response?.value(forKey: "status") as? Int64
                    if status != nil
                    {
                        if status == 0
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
                        else if status == 1
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
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func OK()
    {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
