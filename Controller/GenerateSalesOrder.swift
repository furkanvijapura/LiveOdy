//
//  GenerateSalesOrder.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 28/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
var generateSOAPprover = Bool()
class GenerateSalesOrder: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate
{
    @IBOutlet var lblTotalItems: UILabel!
    @IBOutlet var lblTOtalPrice: UILabel!
    @IBOutlet var footerTootalView: UIView!
    @IBOutlet weak var tblGeneratSO: UITableView!
     var generateSoDic = NSDictionary()
    var totalValue = Double()
    var totalItems = Double()
    var generateSoProductList = NSArray()
    var arraySOApproverNameListGenerat = NSArray()
    var processSalesOrder  = Int()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Generate Sales Order"
        self.tblGeneratSO.separatorStyle = UITableViewCellSeparatorStyle.none
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(GenerateSalesOrder.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        //processSalesOrder = (objInfo.permision.value(forKey: "CRM_SALESORDER_ADDUPDATE") as? Int)!
//        CRM_ORDERREQUISITION_PROCESS_SALESORDER
        addUpdateSales = (objInfo.permision.value(forKey: "CRM_SALESORDER_ADDUPDATE") as? Int)!
        GenerateSOAPICalling()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if addUpdateSales==1
           // && processSalesOrder==1
        {
        if self.status == 0{
        }
        else{
        SOCreateAPICalling()
        }
        }
        else{
            ShowAlertForPermission()
        }
    }
    var status = NSNumber()
    func GenerateSOAPICalling()
    {
        if Reachability.isConnectedToNetwork(){
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        print(arrGenerateSOID)
      
        objDic .setValue(arrGenerateSOID, forKey:"orIds")
        print(objDic)
        //let str:String=arrGenerateSOID.componentsJoined(by: ", ")

        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "orderRequisition/saleType/" + strGenerateSOSalesType + "/generateSO")
        { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                self.status = response! .value(forKey: "status") as! NSNumber
                if self.status == 0
                {
                    let alert = UIAlertController(title:"", message:"Error while generating Sales Order from Order Requisition.", preferredStyle: UIAlertControllerStyle.alert)
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
                else{
                self.generateSoDic = response! .value(forKey: "generateSaleOrder") as! NSDictionary
                self.generateSoProductList=self.generateSoDic.value(forKey: "orProductMapProxys") as! NSArray
                }
                /*
                let orList : NSArray = response! .value(forKey: "orList") as! NSArray
                ORDicData=orList
                ORListData.removeAll()
                ORListData = ModelORList.generateORModelArray()
                print("ORDicData :: ",ORDicData)
                tableeeORListScreen.reloadData()
                self.navigationController?.popToRootViewController(animated: true)
 */
            }
            self.tblGeneratSO.reloadData()
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func SOCreateAPICalling()
    {
        if Reachability.isConnectedToNetwork(){
        
        let buyerOrganizationId : NSNumber = (generateSoDic.value(forKey: "buyerOrganizationId") as? NSNumber)!
        let salesTypeId : NSNumber = (generateSoDic.value(forKey: "salesTypeId") as? NSNumber)!
        let addressId : NSNumber = (generateSoDic.value(forKey: "addressId") as? NSNumber)!
        let pricebookId : NSNumber = (generateSoDic.value(forKey: "pricebookId") as? NSNumber)!
        let sellerOrganizationId : NSNumber = (generateSoDic.value(forKey: "sellerOrganizationId") as? NSNumber)!
        let createdDate : String = (generateSoDic.value(forKey: "createdDate") as? String)!
        let buyerOrganizationName : String = (generateSoDic.value(forKey: "buyerOrganizationName") as? String)!
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
        objDic .setValue(totalValue, forKey:"totalPrice")
        objDic .setValue(totalValue, forKey:"totalWithoutTax")
        objDic .setValue(totalItems, forKey:"totalQty")
        objDic .setValue(totalValue, forKey:"grandTotal")
        objDic .setValue(generateSoProductList, forKey:"productList")
        objDic .setValue(arrGenerateSOID, forKey:"orIdList")

        print(("arrAllProductValue number is==",objDic))
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "saleOrder/create")
        {(response, permissions) in
            print(("Create SO value is==",response))
            self.STOP_INDICATOR()
            if response != nil
            {
               let status: NSNumber = (response!.value(forKey: "status") as? NSNumber)!
                if status != 0{
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
    var shareViewController : UIViewController!
    func OK()
    {
        getSOListing()
       // createSOAPIcalling()
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
        //generateSOAPprover = true
        objReg.isBoolCompanyProfile=false
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    func createSOAPIcalling()
    {
        if Reachability.isConnectedToNetwork(){
        let buyerOrganizationId : NSNumber = (generateSoDic.value(forKey: "buyerOrganizationId") as? NSNumber)!
        let salesTypeId : NSNumber = (generateSoDic.value(forKey: "salesTypeId") as? NSNumber)!
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("sellerDetailsFromBuyerForSO", forKey:"value")
        objDic .setValue(buyerOrganizationId, forKey:"sellerId")
        objDic .setValue(salesTypeId, forKey:"buyerId")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "data/list?all=false") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell1  = tableView.dequeueReusableCell(withIdentifier: "cell") as! GenerateProfileCell
            if generateSoProductList.count != 0
            {
            cell1.lblBuyerName.text=generateSoDic.value(forKey: "buyerOrganizationName") as? String
            cell1.lblSellerName.text=generateSoDic.value(forKey: "sellerOrganizationName") as? String
            cell1.lblShipAdd.text=generateSoDic.value(forKey: "shipTo") as? String
            cell1.btnOrNo.text=generateSoDic.value(forKey: "orNumber") as? String
            cell1.btnCreatDate.setTitle(generateSoDic.value(forKey: "createdDate") as? String, for: UIControlState.normal)
            cell1.btnCreatorName.setTitle(generateSoDic.value(forKey: "creatorName") as? String, for: UIControlState.normal)
             totalValue=(generateSoDic.value(forKey: "totalAmount") as? Double)!
             totalItems=(generateSoDic.value(forKey: "totalQty") as? Double)!
            let currencySymbol : String = (generateSoDic.value(forKey: "currencySymbol") as? String)!
            lblTOtalPrice.text=currencySymbol + " " + String(totalValue)
            lblTotalItems.text=String(totalItems)
                let buyerID:NSNumber = generateSoDic.value(forKey: "buyerLogoId") as! NSNumber
                let buyerLogoName:NSString = generateSoDic.value(forKey: "buyerLogoName") as! NSString
                if buyerLogoName != ""
                {
                    let imgprofile  = Constant.WEBSERVICE_URLUploadImage + buyerID.stringValue + "_" + (buyerLogoName as String)
                    let strValue:String = imgprofile + "?token=" + objInfo.Token
                    let url = URL(string: strValue)
                    let data = try? Data(contentsOf: url!)
                       if data != nil{
                    cell1.imgProfilePic.image = UIImage(data: data!)
                    }
                }
            }
            return cell1
        }
        else if indexPath.section == 1
        {
            let cell4  = tableView.dequeueReusableCell(withIdentifier: "cell1") as! GenerateProductCell
            let objData : NSDictionary = self.generateSoProductList[indexPath.row] as! NSDictionary
            let productName : String = (objData.value(forKey: "productName") as? String)!
            let category : String = (objData.value(forKey: "category") as? String)!
            let uom : String = (objData.value(forKey: "uom") as? String)!
            let sku : String = (objData.value(forKey: "sku") as? String)!
            let priceBookPrice : Double = (objData.value(forKey: "priceBookPrice") as? Double)!
            let quantity : Double = (objData.value(forKey: "quantity") as? Double)!
            let totalPrice : Double = (objData.value(forKey: "totalPrice") as? Double)!
            let currencySymbol : String = (objData.value(forKey: "currencySymbol") as? String)!

            cell4.lblProductName.text=productName
            cell4.lblCategory.text=category
            cell4.lblUom.text=uom
            cell4.lblSku.text=sku
            cell4.lblBasicPrice.text=currencySymbol + " " + String(priceBookPrice)
            cell4.lblQty.text=String(quantity) + " Qty"
            cell4.lblTotalAmount.text=currencySymbol + " " + String(totalPrice)
            return cell4
        }
        else
        {
            let cell5  = tableView.dequeueReusableCell(withIdentifier: "cell2") as! SOTotalPriceCell
            return cell5
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
        case 1:
            return generateSoProductList.count
        default:break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 260.0
        case 1:
            return 110
        default:break
        }
        return 0.0
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch (section) {
        case 0: break
        case 1:
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.backgroundColor = UIColor.gray
            let label = UILabel(frame: CGRect(x: 15, y: 5, width: 400, height: 20));
            label.text = "Product"
            header.contentView.addSubview(label)
        default:  break
        }
    }
    @IBAction func btnEditTapped(_ sender: Any) {
    }
}
