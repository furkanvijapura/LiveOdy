//
//  ReceiveGoodsProfileScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 05/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit


class ReceiveGoodsProfileScreen: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet var tblReceiveGoods: UITableView!
    @IBOutlet var lblQty: UILabel!
    @IBOutlet var btnTotalAmount: UIButton!
    @IBOutlet var btnDiscount: UIButton!
    @IBOutlet var btnTaxes: UIButton!
    @IBOutlet var btnGrandTotal: UIButton!
    var tertairyGoodsProducDetails = NSArray()
    var goodsReceiveMasterDetails = NSDictionary()
    var strSalesType = String()
    var strProfileImage = String()
    var strProfileImageID = NSNumber()
    var strCurrencySymbol = String()
    var totalAmount = Double()
    var totalTaxes = Double()
    var totalItems = Double()
    var totalDiscount = Double()
    var grandTotal = Double()
    var strProfileId = String()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Tertiary Goods Receive Profile"
        self.tblReceiveGoods.separatorStyle = UITableViewCellSeparatorStyle.none
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ORProfile.back(sender:)))
        getTertiaryGoodsReceiveProfile()
        self.navigationItem.leftBarButtonItem = backButton
        refreshiingBoooo = false
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.tblReceiveGoods.addSubview(refreshControl)
        tblReceiveGoods.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
    getTertiaryGoodsReceiveProfile()
    }
    func getTertiaryGoodsReceiveProfile()
    {
        START_INDICATOR()
        APISession.getDataWithRequest(withAPIName: "TertiaryInvt/goodReceived/profile/" + strProfileId)
        {
            (response, permissions) in
            self.STOP_INDICATOR()
            print(("",response))
            refreshControl.endRefreshing()
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
                        let receiveProfile : NSDictionary = response! .value(forKey: "goodsReceiveProfile") as! NSDictionary
                        self.strSalesType = receiveProfile.value(forKey: "salesType") as! String
                        self.tertairyGoodsProducDetails = receiveProfile.value(forKey: "goodsReceiveProductList") as! NSArray
                        self.goodsReceiveMasterDetails = receiveProfile .value(forKey: "goodsReceiveMaster") as! NSDictionary
                        self.strProfileImage = self.goodsReceiveMasterDetails.value(forKey: "logoName") as! String
                        self.strProfileImageID = self.goodsReceiveMasterDetails.value(forKey: "logoId") as! NSNumber
                        self.strCurrencySymbol = self.goodsReceiveMasterDetails.value(forKey: "currencySymbol") as! String
                        self.totalAmount=(self.goodsReceiveMasterDetails.value(forKey: "totalAmount") as? Double)!
                        self.totalDiscount=(self.goodsReceiveMasterDetails.value(forKey: "discountAmount") as? Double)!
                        self.totalTaxes=(self.goodsReceiveMasterDetails.value(forKey: "taxAmount") as? Double)!
                        self.totalItems=(self.goodsReceiveMasterDetails.value(forKey: "totalReceivedQty") as? Double)!
                        self.grandTotal=(self.goodsReceiveMasterDetails.value(forKey: "grandTotal") as? Double)!
                        self.btnTotalAmount.setTitle(self.strCurrencySymbol + " " + String(self.totalAmount), for: UIControlState.normal)
                        self.btnDiscount.setTitle(self.strCurrencySymbol + " " + String(self.totalDiscount), for: UIControlState.normal)
                        self.btnTaxes.setTitle(self.strCurrencySymbol + " " + String(self.totalTaxes), for: UIControlState.normal)
                        self.btnGrandTotal.setTitle(self.strCurrencySymbol + " " + String(self.grandTotal), for: UIControlState.normal)
                        self.lblQty.text=String(self.totalItems) + " Qty"
                    }
                }
            }
            self.tblReceiveGoods.reloadData()
        }
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReceiveGoodsProfileMainCell
            cell.lblBuyerName.text=goodsReceiveMasterDetails.value(forKey: "buyerName") as? String
            cell.lblWhereHouseName.text = goodsReceiveMasterDetails.value(forKey: "warehouseName") as? String
            cell.lblSellerName.text=goodsReceiveMasterDetails.value(forKey: "supplierName") as? String
            cell.lblTgNo.text=goodsReceiveMasterDetails.value(forKey: "tgrnNo") as? String
            cell.btnCreaterName.setTitle(goodsReceiveMasterDetails.value(forKey: "createdBy") as? String, for: UIControlState.normal)
            cell.btnCreatDate.setTitle(goodsReceiveMasterDetails.value(forKey: "createdDate") as? String, for: UIControlState.normal)
            cell.btnSlaesType.setTitle(strSalesType, for: UIControlState.normal)
            cell.lblSoNo.text=goodsReceiveMasterDetails.value(forKey: "tSalesOrderNo") as? String
            if strProfileImage != ""
            {
                let imgprofile  = Constant.WEBSERVICE_URLUploadImage + strProfileImageID.stringValue + "_" + strProfileImage
                let strValue:String = imgprofile + "?token=" + objInfo.Token
//                let url = URL(string: strValue)
                let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: urlString!)
                let data = try? Data(contentsOf: url!)
                  if data != nil{
                cell.imgProfilepic.image = UIImage(data: data!)
                }
            }
           return cell
        }
        else
        {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ReceiveGoodsProductCell
            let objData : NSDictionary = self.tertairyGoodsProducDetails[indexPath.row] as! NSDictionary
            let productName : String = (objData.value(forKey: "productName") as? String)!
            let categoryName : String = (objData.value(forKey: "categoryName") as? String)!
            let uom : String = (objData.value(forKey: "uom") as? String)!
            let sku : String = (objData.value(forKey: "sku") as? String)!
            let mgf : String = (objData.value(forKey: "manufacturingDate") as? String)!
            let exp : String = (objData.value(forKey: "expiryDate") as? String)!
            let receivedQty : NSNumber = (objData.value(forKey: "receivedQty") as? NSNumber)!
            let sellingPrice : Double = (objData.value(forKey: "sellingPrice") as? Double)!
            let currencySymbol : String = (objData.value(forKey: "currencySymbol") as? String)!

            cell.lblProductName.text=productName
            cell.lblCategoryName.text=categoryName
            cell.btnUom.setTitle(uom, for: UIControlState.normal)
            cell.lblSku.text=sku
            cell.lblMgfDate.text=mgf
            cell.lblExp.text=exp
            cell.btnReceiveQty.setTitle(receivedQty.stringValue + " Qty" , for: UIControlState.normal)
            cell.btnSellingPrice.setTitle(currencySymbol + " " + String(sellingPrice), for: UIControlState.normal)

            return cell
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
                return tertairyGoodsProducDetails.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250.0
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
    /*
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
 */
}
