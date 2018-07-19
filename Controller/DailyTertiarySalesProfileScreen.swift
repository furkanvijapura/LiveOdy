//
//  DailyTertiarySalesProfileScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 30/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

class DailyTertiarySalesProfileScreen: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate,UITextFieldDelegate
{
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnApprove: UIButton!
    @IBOutlet var viewFooter: UIView!
    @IBOutlet var tblDailySalesProfile: UITableView!
    var isEdit = Bool()
    var dailySalesProfile = NSDictionary()
    var strDailyProfileId = NSNumber()
    var strDailyProfileName = String()
    var strDailySalesNo = String()
    var dailySalesProductList = NSArray()
    var boolIsApproved = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Daily Sales Profile"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(DailyTertiarySalesProfileScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        viewFooter.isHidden=true
        btnSave.isHidden=true
        btnApprove.isHidden=true
        btnCancel.isHidden=true
        isEdit=false
        getDailySalesProfile()
        refreshiingBoooo = false
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.tblDailySalesProfile.addSubview(refreshControl)
        tblDailySalesProfile.reloadData()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
         getDailySalesProfile()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem)
    {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditTapped(_ sender: Any)
    {
        isEdit=true
        viewFooter.isHidden=false
        btnSave.isHidden=false
        btnApprove.isHidden=false
        btnCancel.isHidden=false
        self.tblDailySalesProfile.reloadData()
    }
    @IBAction func btnApproveTapped(_ sender: Any) {
        boolIsApproved=false
        postSaveAPICalling()
    }
    @IBAction func btnSaveTapped(_ sender: Any) {
        boolIsApproved=true
        postSaveAPICalling()
        //ShowAlert()
    }
    func postSaveAPICalling()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("64", forKey:"priceBookId")
        if boolIsApproved == true{
            objDic .setValue(false, forKey:"isEdited")
        }
        else
        {
            objDic .setValue(true, forKey:"isEdited")
        }
        //===========Array post different===========
        let arrParameter = NSMutableArray()
        for i in 0..<dailySalesProductList.count
        {
            let indexpath = IndexPath(row: i, section: 1)
            let cell = self.tblDailySalesProfile.cellForRow(at: indexpath) as! DailySalesProfileProductCell
            let taxDic = NSMutableDictionary()
            let productId =  (dailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "productId") as! Int
            let orgId =  (dailySalesProductList.object(at: i)
                as! NSDictionary).value(forKey: "orgId") as! Int
            let totalClosingStock =  (dailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalClosingStock") as! Double
            let totalOpeningStock =  (dailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalOpeningStock") as! Double
            let totalReceivedStock =  (dailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalReceivedStock") as! Double
            let price =  (dailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "price") as! Double
            let priceBookId =  (dailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "priceBookId") as! Int
            taxDic.setValue("0", forKey: "id")
            taxDic.setValue(productId, forKey: "productId")
            taxDic.setValue(orgId, forKey: "orgId")
            taxDic.setValue("", forKey: "soldStock")
            let formattedString1 = cell.txtSoldQty.text?.replacingOccurrences(of: " Sold Qty", with: "")
            print(formattedString1)
            taxDic.setValue(formattedString1, forKey: "soldQTY")
            taxDic.setValue(totalClosingStock, forKey: "totalClosingStock")
            taxDic.setValue(totalOpeningStock, forKey: "totalOpeningStock")
            taxDic.setValue(totalReceivedStock, forKey: "totalReceivedStock")
            taxDic.setValue(dailySalesProfile.value(forKey: "updateDate"), forKey: "dateStr")
            taxDic.setValue(1, forKey: "type")
            taxDic.setValue(price, forKey: "price")
            taxDic.setValue(priceBookId, forKey: "priceBookId")
            taxDic.setValue(dailySalesProfile.value(forKey: "tSalesNo"), forKey: "refNo")
            print(taxDic)
            arrParameter.add(taxDic)
        }
        print(arrParameter)
        objDic .setValue(arrParameter, forKey:"productList")
        print(("objIdc delete data is ==",objDic))
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "TertiaryInvt/dailySales/2")
        {
            (response, permissions) in
            print("response is ==",response!)
            self.STOP_INDICATOR()
            if response != nil{
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
        }
    }
    func OK()
    {
        //GetTertiaryList()
        self.navigationController?.popViewController(animated: true)
    }
    func postApprovedAPICalling()
    {
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    func getDailySalesProfile()
    {
         START_INDICATOR()
        APISession.getDataWithRequest(withAPIName: "TertiaryInvt/sales/profile/" + strDailySalesNo)
        {
            (response, permissions) in
            print(("",response))
            refreshControl.endRefreshing()
            self.STOP_INDICATOR()
            if response != nil
            {
                if let status:Int=response!.value(forKey: "status") as? Int
                {
                    if status==0
                    {
                        let alert = UIAlertController(title:"No Profile Data Available", message:"", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
                        {
                            (alert:UIAlertAction!) -> Void in
                            // self.OK()
                        })
                        alert.addAction(okAction)
                        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                        alertWindow.rootViewController = UIViewController()
                        alertWindow.windowLevel = UIWindowLevelAlert + 1;
                        alertWindow.makeKeyAndVisible()
                        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                    else{
                        self.dailySalesProfile = response! .value(forKey: "dailySalesProfile") as! NSDictionary
                        self.dailySalesProductList = self.dailySalesProfile.value(forKey: "dailySalesProductList") as! NSArray
                        self.status = self.dailySalesProfile.value(forKey: "tSaleStatus") as! NSString
                        /*
                         self.strSalesType = receiveProfile.value(forKey: "salesType") as! String
                         self.tertairyGoodsProducDetails = receiveProfile.value(forKey: "goodsReceiveProductList") as! NSArray
                         self.goodsReceiveMasterDetails = receiveProfile .value(forKey: "goodsReceiveMaster") as! NSDictionary
                         self.strProfileImage = self.goodsReceiveMasterDetails.value(forKey: "logoName") as! String
                         self.strProfileImageID = self.goodsReceiveMasterDetails.value(forKey: "logoId") as! NSNumber
                         self.strCurrencySymbol = self.goodsReceiveMasterDetails.value(forKey: "currencySymbol") as! String
                         self.totalAmount=(self.goodsReceiveMasterDetails.value(forKey: "totalAmount") as? Double)!
                         self.totalDiscount=(self.goodsReceiveMasterDetails.value(forKey: "discountAmount") as? Double)!
                         self.totalTaxes=(self.goodsReceiveMasterDetails.value(forKey: "taxAmount") as? Double)!
                         self.grandTotal=(self.goodsReceiveMasterDetails.value(forKey: "grandTotal") as? Double)!
                         self.btnTotalAmount.setTitle(self.strCurrencySymbol + " " + String(self.totalAmount), for: UIControlState.normal)
                         self.btnDiscount.setTitle(self.strCurrencySymbol + " " + String(self.totalDiscount), for: UIControlState.normal)
                         self.btnTaxes.setTitle(self.strCurrencySymbol + " " + String(self.totalTaxes), for: UIControlState.normal)
                         self.btnGrandTotal.setTitle(self.strCurrencySymbol + " " + String(self.grandTotal), for: UIControlState.normal)
                         */
                    }
                }
            }
            self.tblDailySalesProfile.reloadData()
        }
    }
    var status = NSString()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "cell") as! DailySalesProfileMainCell
            cell.lblProductName.text=dailySalesProfile.value(forKey: "organizationName") as? String
            cell.lblDailySlaesNumber.text=dailySalesProfile.value(forKey: "tSalesNo") as? String
            cell.btnCreatorDate.setTitle(dailySalesProfile.value(forKey: "updateDate") as? String, for: UIControlState.normal)
            cell.btnCreatorName.setTitle(dailySalesProfile.value(forKey: "createdBy") as? String, for: UIControlState.normal)
            //cell.btnCreatorName.setTitle(dailySalesProfile.value(forKey: "tSaleStatus") as? String, for: UIControlState.normal)
            // let strSTtaus:String=(dailySalesProfile.value(forKey: "tSaleStatus") as? String)!
            if dailySalesProfile.count != 0{
            let buyerID:NSNumber = dailySalesProfile.value(forKey: "logoId") as! NSNumber
            let buyerLogoName:NSString = dailySalesProfile.value(forKey: "logoName") as! NSString
            if buyerLogoName != ""
            {
                let imgprofile  = Constant.WEBSERVICE_URLUploadImage + buyerID.stringValue + "_" + (buyerLogoName as String)
                let strValue:String = imgprofile + "?token=" + objInfo.Token
//                let url = URL(string: strValue)
                let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: urlString!)
                let data = try? Data(contentsOf: url!)
                if data != nil{
                cell.imgProfile.image = UIImage(data: data!)
                }
            }
            }
            if status=="Draft"
            {
                cell.btnStatus.backgroundColor=UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
                cell.btnStatus.setTitle(status as String, for: UIControlState.normal)
                cell.btnEdit.isHidden=false
            }
            else
            {
                //cell.btnStatus.backgroundColor = UIColor(red: 125/255, green: 196/255, blue: 122/255, alpha: 1.0)
                cell.btnStatus.backgroundColor=UIColor(red: 44/255, green: 123/255, blue: 180/255, alpha: 1.0)
                cell.btnStatus.setTitle(status as String, for: UIControlState.normal)
                cell.btnEdit.isHidden=true
            }
            return cell
        }
        else
        {
            let cell1  = tableView.dequeueReusableCell(withIdentifier: "cell1") as! DailySalesProfileProductCell
            let objData : NSDictionary = self.dailySalesProductList[indexPath.row] as! NSDictionary
            let productName : String = (objData.value(forKey: "productName") as? String)!
            let categoryName : String = (objData.value(forKey: "categoryName") as? String)!
            let uom : String = (objData.value(forKey: "uom") as? String)!
            let sku : String = (objData.value(forKey: "sku") as? String)!
           // let avalQty : NSNumber = (objData.value(forKey: "avalQty") as? NSNumber)!
             let avalQty : Double = (objData.value(forKey: "totalClosingStock") as? Double)!
            if 0 > avalQty {
                cell1.txtSoldQty.isUserInteractionEnabled = false
                viewFooter.isHidden = true
            }
            let soldQTY : Double = (objData.value(forKey: "soldQTY") as? Double)!
            let price : Double = (objData.value(forKey: "price") as? Double)!
            let currencySymbol : String = (objData.value(forKey: "currencySymbol") as? String)!
            cell1.lblProductName.text=productName
            cell1.lblCategoryName.text=categoryName
            cell1.lblUomNumber.text=uom
            cell1.lblSku.text=sku
            cell1.btnQty.setTitle((String(avalQty)) + " Qty", for: UIControlState.normal)
            cell1.txtSoldQty.text = String(soldQTY)
//                + " Sold Qty")
            //+ " Sold Qty"
            cell1.btnBasicPrice.setTitle(currencySymbol + " " + String(price), for: UIControlState.normal)
            if isEdit==false
            {
                cell1.txtSoldQty.isUserInteractionEnabled = false
            }
            else{
                cell1.txtSoldQty.isUserInteractionEnabled = true
                cell1.txtSoldQty.borderStyle = UITextBorderStyle.roundedRect
                //cell1.txtSoldQty.setDoneOnKeyboard()
            }
            
            /*
             if soProducDetails.count==0
             {
             cell4.viewBackProduct.isHidden=true
             cell4.lblNoProduct.isHidden=false
             footerTootalView.isHidden=true
             }
             
             else{
             
             cell4.viewBackProduct.isHidden=false
             cell4.lblNoProduct.isHidden=true
             footerTootalView.isHidden=false
             let objData : NSDictionary = self.soProducDetails[indexPath.row] as! NSDictionary
             //let logoName : String = (objData.value(forKey: "logoName") as? String)!
             let uom : String = (objData.value(forKey: "uom") as? String)!
             let category : String = (objData.value(forKey: "categoryName") as? String)!
             let sku : String = (objData.value(forKey: "sku") as? String)!
             let productName : String = (objData.value(forKey: "productName") as? String)!
             let priceBookPrice : NSNumber = (objData.value(forKey: "priceBookPrice") as? NSNumber)!
             let totalPrice : NSNumber = (objData.value(forKey: "productTotal") as? NSNumber)!
             let quantity : NSNumber = (objData.value(forKey: "quantity") as? NSNumber)!
             let basicPrice : NSNumber = (objData.value(forKey: "basicPrice") as? NSNumber)!
             let discount : NSNumber = (objData.value(forKey: "discountAmount") as? NSNumber)!
             let logoId : NSNumber = (objData.value(forKey: "logoId") as? NSNumber)!
             let logoName : String = (objData.value(forKey: "logoName") as? String)!
             cell4.lblSOProductName.text=productName
             cell4.lblSOCategorytName.text=category
             cell4.lblSOMesurementName.text=uom
             cell4.lblSOSkuName.text=sku
             cell4.btnPricebookPrice.setTitle((socurrencySymbol as String) + " " + priceBookPrice.stringValue, for: UIControlState.normal)
             cell4.btnDiscount.setTitle((socurrencySymbol as String) + " " + discount.stringValue, for: UIControlState.normal)
             cell4.btnOldPrice.setTitle((socurrencySymbol as String) + " " + basicPrice.stringValue, for: UIControlState.normal)
             cell4.btnTotalAmount.setTitle((socurrencySymbol as String) + " " + totalPrice.stringValue, for: UIControlState.normal)
             cell4.btnQty.setTitle(quantity.stringValue + " Qty", for: UIControlState.normal)
             if logoName != ""
             {
             let imgprofile  = Constant.WEBSERVICE_URLUploadImage + logoId.stringValue + "_" + (logoName as String)
             let strValue:String = imgprofile + "?token=" + objInfo.Token
             let url = URL(string: strValue)
             let data = try? Data(contentsOf: url!)
             cell4.imgProfilePic.image = UIImage(data: data!)
             }
             
             if status=="Draft"
             {
             cell4.btnDelete.isHidden=false
             }
             else{
             cell4.btnDelete.isHidden=true
             }
             */
            //}
            return cell1
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
            // if soProducDetails.count==0
            //{
            //   return 1
            //}
            //else{
            return dailySalesProductList.count
        // }
        default:break
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 210
        case 1:
            return 100
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
    /*
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
     {
     let pointInTable:CGPoint = textField.superview!.convert(textField.frame.origin, to:tblDailySalesProfile)
     print(pointInTable)
     
     //        var contentOffset:CGPoint = Table.contentOffset
     var contentOffset:CGPoint =  CGPoint(x: 0, y: 0)
     print(contentOffset)
     
     //        Table.contentOffset = CGPoint(x: 0, y: 10)
     
     contentOffset.y  = pointInTable.y
     if let accessoryView = textField.inputAccessoryView
     {
     contentOffset.y -= accessoryView.frame.size.height
     }
     tblDailySalesProfile.contentOffset = contentOffset
     return true;
     }
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField)
//    {
//        tblDailySalesProfile.contentOffset = CGPoint(x: 0, y: 0)
//        let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to: self.tblDailySalesProfile)
//        let indexPath = self.tblDailySalesProfile.indexPathForRow(at: buttonPosition)
//        let cell = self.tblDailySalesProfile.cellForRow(at: indexPath!) as! DailySalesProfileProductCell
//
//
//        tblDailySalesProfile.reloadData()
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var txtAfterUpdate = string
        if let text = textField.text as NSString?
        {
            txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            print(txtAfterUpdate)
        }
        let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to: self.tblDailySalesProfile)
        let indexPath = self.tblDailySalesProfile.indexPathForRow(at: buttonPosition)
        
        let objData : NSDictionary = self.dailySalesProductList[(indexPath?.row)!] as! NSDictionary
        let qvlQty : Double = (objData.value(forKey: "avalQty") as? Double)!
        print("qvlQty",qvlQty)
        //let qvlQty : Double = (self.dailySalesProductList .object(at: (indexPath?.row)!).value(forKey: "avalQty") as? Double)!
        
        let cell = self.tblDailySalesProfile.cellForRow(at: indexPath!) as! DailySalesProfileProductCell
        if txtAfterUpdate != ""
        {
            if textField == cell.txtSoldQty
            {
                //cell.txtSoldQty.text=""
                let rateValue1 = Float(qvlQty)
                let strrateValue1:String = String(format: "%.2f", rateValue1)
                let priceValue1 = Float(txtAfterUpdate)
                let strpriceValue1:String = String(format: "%.2f", priceValue1!)

                if   (strrateValue1) < (strpriceValue1)
                {
                    cell.txtSoldQty.text=""
                    print("value==",strrateValue1)
                   // cell.txtSoldQty.text=strrateValue1
                }
                else{
                    print("value==",strrateValue1)
                }
                let strTotal1 = String(rateValue1 - priceValue1!)
                        cell.btnQty.setTitle(strTotal1, for: UIControlState.normal)
                }
            else
            {
                let rateValue1 = Float(qvlQty)
                let priceValue1 = Float(txtAfterUpdate)
                
                        let strTotal1 = String(format : "%.2f",(rateValue1 - priceValue1!))
                       cell.btnQty.setTitle(strTotal1, for: UIControlState.normal)
                }
        }
        else{
            cell.btnQty.setTitle((String(format: "%.2f", qvlQty)), for: UIControlState.normal)
        }
        return true;
    }
}
