//
//  MainSalesOrderSummaryScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 8/10/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class MainSalesOrderSummaryScreen: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet var tblProductList: UITableView!
    @IBOutlet var viewClassLayer: UIView!
    @IBOutlet var tblBackGroundView: UIView!
    @IBOutlet var btnRetailerName: UIButton!
    @IBOutlet var btnSalesOrderNo: UIButton!
    @IBOutlet var btnProductDetails: UIButton!
    @IBOutlet var btnUserProfile: UIButton!
    @IBOutlet var lblCompanyName: UILabel!
    @IBOutlet var mainHeaderView: UIView!
    @IBOutlet var btnSkuLeading: NSLayoutConstraint!
    
    @IBOutlet var btnSalesType: UIButton!
    @IBOutlet weak var btnProductDate: UIButton!
    @IBOutlet weak var btnTotalProductPrice: UIButton!
    @IBOutlet weak var btnMainProductPrice: UIButton!
  var strCompanyName = NSString()
    var strorgName = NSString()
    var strUpdateBy = NSString()
    var strSalesDate = NSString()
    var strSalesOrderNumber = NSString()
    var strID = NSString()
    var strTotalPrice = NSString()
    var strProductPrice = NSString()
    var isVisitSide=Bool()
    var strSalesType = NSString()
    var salesCartNumber = NSNumber ()
    @IBOutlet weak var btnEditProduct: UIButton!

    var arrProductName : NSMutableArray = NSMutableArray()
    var arrProductListFromDetailssales : NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Sales Order Summary"
        
        tblProductList.layer.cornerRadius = 1.0;
            tblProductList.layer.borderWidth = 1.0;
        tblProductList.layer.borderColor = UIColor(red: 0/255, green: 121/255, blue: 164/255, alpha: 1.0).cgColor
        btnEditProduct.isHidden = true

//                viewClassLayer.layer.cornerRadius = 3
//                viewClassLayer.layer.borderWidth=1.0
//                viewClassLayer.layer.borderColor=UIColor.blue.cgColor

//         mainHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:110)
        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(MainSalesOrderSummaryScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        lblCompanyName.text=strCompanyName as String
        btnRetailerName.setTitle(strorgName as String, for: UIControlState.normal)
        btnSalesOrderNo.setTitle(strSalesOrderNumber as String, for: UIControlState.normal)
        btnProductDetails.setTitle((strUpdateBy as String) + " " + (strSalesDate as String), for: UIControlState.normal)
        btnTotalProductPrice.setTitle(strTotalPrice as String, for: UIControlState.normal)
        btnProductDate.setTitle(strSalesDate as String, for: UIControlState.normal)
        btnMainProductPrice.setTitle(strProductPrice as String, for: UIControlState.normal)
        btnSalesType.setTitle(strSalesType as String, for: UIControlState.normal)

        if isVisitSide==true {
        }
        else{
            getSalesProductList()
        }
    
//        if strSalesType=="Primary"
//        {
//            
//        }
//        else
//        {
//            btnMainProductPrice.isHidden=true
//            btnTotalProductPrice.isHidden=true
//            let cell = tblProductList.dequeueReusableCell(withIdentifier: "cell") as! SummaryDataCell
//            cell.btnPercentage.isHidden=true
//            cell.btnRate.isHidden=true
//            cell.btncart.isHidden=true
//            cell.btnTotalSumRate.isHidden=true
//            cell.btnPriceBook.setTitle(salesCartNumber.stringValue, for: UIControlState.normal)
//            cell.btnPriceBook.setImage(UIImage(named: "cart_gray_icon"), for: UIControlState.normal)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func getSalesProductList()
    {
//        INDISTART()
        START_INDICATOR()
        APISession.getDataForVisitProfileWithRequest(withAPIName: "saleOrder/salesOrderProductList/", strOrgId:strID as (String), strUserId: "")
        {
            (response, permissions) in
            self.STOP_INDICATOR()
            print(("final response is==",response))
            self.arrProductListFromDetailssales = response!
            self.tblProductList .reloadData()
            
        }
    }
//     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        return mainHeaderView
//    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductListFromDetailssales.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SummaryDataCell
//        cell.btnSummaryProductNAme.titleLabel?.text = arrProductName[indexPath.row] as? String
        
//        cell.btnSummaryProductNAme.setTitle(arrProductName[indexPath.row] as? String, for: UIControlState.normal)
        if isVisitSide == true
        {
            cell.btnSummaryProductNAme.setTitle(arrProductListFromDetailssales[indexPath.row] as? String, for: UIControlState.normal)
//            isVisitSide=false
        }
        else{
        let objData : NSDictionary = self.arrProductListFromDetailssales[indexPath.row] as! NSDictionary
        if let salesOrgName : String = objData.value(forKey: "productName") as? String
        {
            cell.btnSummaryProductNAme.setTitle(salesOrgName, for: UIControlState.normal)
        }
        if let salesOrgName : String = objData.value(forKey: "sku") as? String
        {
            cell.btnSku.setTitle(salesOrgName, for: UIControlState.normal)
        }
        if let salesOrgName : NSNumber = objData.value(forKey: "priceBookPrice") as? NSNumber
        {
            cell.btnPriceBook.setTitle(salesOrgName.stringValue, for: UIControlState.normal)
        }
        if let salesOrgName : NSNumber = objData.value(forKey: "discountAmount") as? NSNumber
        {
            cell.btnPercentage.setTitle(salesOrgName.stringValue, for: UIControlState.normal)
        }
        if let salesOrgName : NSNumber = objData.value(forKey: "basicPrice") as? NSNumber
        {
            cell.btnRate.setTitle(salesOrgName.stringValue, for: UIControlState.normal)
        }
        if let salesOrgName : NSNumber = objData.value(forKey: "quantity") as? NSNumber
        {
            cell.btncart.setTitle(salesOrgName.stringValue, for: UIControlState.normal)
            salesCartNumber = salesOrgName
        }
        if let salesOrgName : NSNumber = objData.value(forKey: "productTotal") as? NSNumber
        {
            cell.btnTotalSumRate.setTitle(salesOrgName.stringValue, for: UIControlState.normal)
        }
        
        }

        
        //        let cell1:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
        //        arrayMainData.count
        //        cell1.selectionStyle = .none
        
        return cell
    }
    
    @IBAction func btnEditProductTapped(_ sender: Any) {
        
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"AddSalesController") as! AddSalesController
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    
//     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
//        return 110
//    }
//    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        let title = "order"
//        
//        return title
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
