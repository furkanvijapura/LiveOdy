//
//  ProductProfileScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 30/11/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class ProductProfileScreen: UIViewController,UIScrollViewDelegate
{
    @IBOutlet weak var btnPlusCount: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTag2: UILabel!
    @IBOutlet weak var lblTag1: UILabel!
    @IBOutlet weak var lblSkuNo: UILabel!
    @IBOutlet weak var lblRRPNo: UILabel!
    @IBOutlet weak var lblBarcodeNo: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var btnProductPic: UIButton!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var btnMoreInfo: UIButton!
    @IBOutlet weak var btnOpportunity: UIButton!
    @IBOutlet weak var btnSales: UIButton!
    @IBOutlet weak var btnStock: UIButton!
    @IBOutlet weak var btnConfiguration: UIButton!
    var  arrTagsList = NSArray()
    var productId = NSString()
    var strTitleProduct = String()
    
    @IBOutlet weak var lblProductType: UILabel!
    @IBOutlet weak var btnTagCount: UIButton!
    var GetValues = 0
    var Values = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getSalesListingForProduct()
        self.title="Product Profile"
        getProductProfile()
      //  getProductTagsList()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ProductProfileScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
       // btnProductPic.layer.cornerRadius = btnProductPic.frame.width / 2
        btnMoreInfo.SetShadow()
        btnOpportunity.SetShadow()
        btnSales.SetShadow()
        btnStock.SetShadow()
        btnConfiguration.SetShadow()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnTagCountTapped(_ sender: Any)
    {
    }
    func getProductProfile()
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "product/profile/" + (productId as String)) {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let productName : NSString = response! .value(forKey: "productName") as! NSString
                let productCategoryName : NSString = response! .value(forKey: "productCategoryName") as! NSString
                let price : NSNumber = response! .value(forKey: "price") as! NSNumber
                let sku : NSString = response! .value(forKey: "sku") as! NSString
                let barcode : NSString = response! .value(forKey: "barcode") as! NSString
                self.lblProductName.text=productName as String
                self.title=productName as String
                self.strTitleProduct=productName as String
                self.lblProductType.text=productCategoryName as String
                self.lblRRPNo.text=price.stringValue as String
                self.lblSkuNo.text=sku as String
                self.lblBarcodeNo.text=barcode as String
                let isActive : Bool = response! .value(forKey: "isactive") as! Bool
                if isActive == true
                {
                    //self.btnActive.setImage(UIImage(named : "radio-on-button"), for: .normal)
                }
                else{
                    ///self.btnActive.setImage(UIImage(named : "circle-outline"), for: .normal)
                }
                let favorites : Bool = response! .value(forKey: "favorites") as! Bool
                if favorites == true
                {
                    self.btnFavourite.setImage(UIImage(named : "star_contact"), for: .normal)
                }
                else{
                    self.btnFavourite.setImage(UIImage(named : "star_unselect_contact"), for: .normal)
                }
                let tagMasterProxys : NSArray = response! .value(forKey: "tagMasterProxys") as! NSArray
                self.arrTagsList=tagMasterProxys
                let tagValue1 : NSString = (self.arrTagsList.object(at: 0) as AnyObject) .value(forKey: "text") as! NSString
                self.lblTag1.text=tagValue1 as String
                if self.arrTagsList.count==1
                {
                    self.btnPlusCount.isHidden=true
                }
                else if self.arrTagsList.count==2
                {
                    self.btnPlusCount.isHidden=true
                    let tagValue2 : NSString = (self.arrTagsList.object(at: 1) as AnyObject) .value(forKey: "text") as! NSString
                    self.lblTag2.text=tagValue2 as String
                }
                else{
                    let tagValue2 : NSString = (self.arrTagsList.object(at: 1) as AnyObject) .value(forKey: "text") as! NSString
                    self.lblTag2.text=tagValue2 as String
                    let finalPriceBookArray:NSArray = self.arrTagsList as NSArray
                    let strCount = finalPriceBookArray.count
                    self.btnPlusCount.isHidden=false
                    self.Values = strCount - 2
                    let p = ("+" + "\(self.Values)")
                    //self.increment_lbl.text=p
                    self.btnPlusCount.setTitle(p, for: UIControlState.normal)
                }
                let logoName : String = response! .value(forKey: "logoName") as! String
                let logoId : Int = response! .value(forKey: "logoId") as! Int
                if logoName != ""{
                    let imgprofile  = Constant.WEBSERVICE_URLUploadImage + String(logoId) + "_" + logoName
                    let strValue:String = imgprofile + "?token=" + objInfo.Token
//                    let url = URL(string: strValue)
                    let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                    let url = URL(string: urlString!)
                    let data = try? Data(contentsOf: url!)
                    if data != nil{
                        self.imgProduct.image = UIImage(data: data!)
                    }
                    else{
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
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    func CompanyProfileFavorites()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(productId, forKey:"masterId")
        objDic .setValue("4", forKey:"favType")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "favorites/set")
        { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
        }
    }
    @IBAction func btnFavouriteTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        CompanyProfileFavorites()
        
        let img = UIImage(named: "star_contact")
            if (sender as AnyObject).imageView??.image == img
            {
                btnFavourite.setImage(UIImage(named : "star_unselect_contact"), for: .normal)
                //            but.setTitle("on", for: UIControlState.normal)
                print("Not select...")
            }
            else
            {
                btnFavourite.setImage(UIImage(named : "star_contact"), for: .normal)
                //            but.setTitle("off", for:UIControlState.normal)
                print("select...")
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnActiveTapped(_ sender: Any) {
        let img = UIImage(named: "circle-outline")
        if (sender as AnyObject).imageView??.image == img
        {
            btnActive.setImage(UIImage(named : "radio-on-button"), for: .normal)
        }
        else
        {
            btnActive.setImage(UIImage(named : "circle-outline"), for: .normal)
        }
    }
    @IBAction func btnMoreInfoTapped(_ sender: Any)
    {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "ProductMoreInfoScreen") as! ProductMoreInfoScreen
        objReg.strTitleProduct=strTitleProduct
        objReg.productMoreId=productId
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    @IBAction func btnSalesTapped(_ sender: Any) {
//        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
//        self.navigationController?.pushViewController(objReg, animated: true)
//        getSalesListingForProduct()
        self.checkMergeAPiData()
    }
    var arraysaleOrderNumber = [""]
    var arraysaleOrderNumberCheck = [""]

    func getSalesListingForProduct()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataWithRequest( withAPIName: "saleOrder/salesOrderProductListByProductForNative/" + (productId as String))
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                print(("",response))
                if response != nil
                {
                    let status : NSNumber = response!.value(forKey: "status") as! NSNumber
                    if status != 0
                    {
                        let soList : NSArray = response! .value(forKey: "soFilter") as! NSArray
                        print("soList.count==",soList.count)
                        for i in 0..<soList.count
                        {
                          let id = (soList.object(at: i) as! NSDictionary).value(forKey: "saleOrderNumber") as! String
                            self.arraysaleOrderNumber.insert(id, at: i)
                        }
                        print(self.self.arraysaleOrderNumber)
                        self.getSOListing()
                        //SOMainArray = soList
//                        SOListData.removeAll()
//                        SOListData = SOModel_List.GenrateSOModelData()
//                        if refreshiingBoooo == false
//                        {
//                            //refreshControl.endRefreshing()
//                        }
//
//                        //generateSOAPprover = false
//                        tablevaaaar.reloadData()
                      //  let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
                        //        self.navigationController?.pushViewController(objReg, animated: true)
                    }
                }
            }
        }
    }
    var arrayMainTest = NSArray()
    func getSOListing()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataWithRequest( withAPIName: "saleOrder/list")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                print(("",response))
                if response != nil
                {
                    let status : NSNumber = response!.value(forKey: "status") as! NSNumber
                    if status != 0
                    {
                        let soList : NSArray = response! .value(forKey: "soList") as! NSArray
//                        for i in 0..<soList.count
//                        {
//                            let id = (soList.object(at: i) as! NSDictionary).value(forKey: "saleOrderNumber") as! String
//                            self.arraysaleOrderNumberCheck.insert(id, at: i)
//                        }
                        print("SOMainArray.count==",SOMainArray)
                        
//                        self.checkMergeAPiData()
                        self.arrayMainTest = soList
//                        SOListData.removeAll()
//                        SOListData = SOModel_List.GenrateSOModelData()
//                        if refreshiingBoooo == false
//                        {
//                            //refreshControl.endRefreshing()
//                        }
//
//                        //generateSOAPprover = false
//                        tablevaaaar.reloadData()
                    }
                }
            }
        }
    }
    var mutableArraySalesdata = NSMutableArray()
    func checkMergeAPiData(){
        for i in 0..<arraysaleOrderNumber.count
        {
            for k in 0..<arrayMainTest.count{
                let id = self.arraysaleOrderNumber[i]
                if  id == (self.arrayMainTest[k] as AnyObject).value(forKey: "saleOrderNumber") as! String
                {
                   // SOMainArray = self.arrayMainTest[id]
                    let arrySalesOrderNo:NSDictionary = (self.arrayMainTest[k] as AnyObject) as! NSDictionary
                   mutableArraySalesdata.add(arrySalesOrderNo)
                }
            }
        }
        SOMainArray = mutableArraySalesdata as NSArray
        print("SOMainArray1=",SOMainArray)
        SOListData.removeAll()
        SOListData = SOModel_List.GenrateSOModelData()
        tablevaaaar.reloadData()
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SOListScreen") as! SOListScreen
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    @IBAction func btnOpportunityTapped(_ sender: Any) {
        ShowAlert()
    }
    @IBAction func btnStockTapped(_ sender: Any) {
        ShowAlert()
    }
    @IBAction func btnConfigurationTapped(_ sender: Any) {
        ShowAlert()
    }
}
