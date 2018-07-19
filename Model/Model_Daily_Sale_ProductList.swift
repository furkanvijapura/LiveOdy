  //
//  Model_Daily_Sale_ProductList.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 13/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var DailySalesProductList = NSArray()

class Model_Daily_Sale_ProductList: NSObject {
    
    var id: String = ""
    var productId: String = ""
    var orgId: String = ""
    var productName: String = ""
    var sku: String = ""
    var productCatName: String = ""
    var site_id: String = ""
    var avalQty: String = ""
    var currentQTY: String = ""
    var price: String = ""
    var priceBookId : String = ""
    var totalOpeningStock : String = ""
    var totalReceivedStock : String = ""
    var totalClosingStock : String = ""
    
    init(id:String,productId:String,orgId:String,price:String,productName:String,sku:String,productCatName:String,site_id:String,avalQty:String,currentQTY:String,PriceBookId:String,totalOpeningStock:String,totalReceivedStock:String,totalClosingStock:String)
    {
//        self.value = productValue
        self.id = id
        self.productId = productId
        self.orgId = orgId
        self.price = price
        self.productName = productName
        self.sku = sku
        self.productCatName = productCatName
        self.site_id = site_id
        self.avalQty = avalQty
        self.currentQTY = currentQTY
        self.priceBookId = PriceBookId
        self.totalOpeningStock = totalOpeningStock
        self.totalReceivedStock = totalReceivedStock
        self.totalClosingStock = totalClosingStock
    }
    class func generateModelArray() -> [Model_Daily_Sale_ProductList]{
        var ProductName = [Model_Daily_Sale_ProductList]()
        for i in 0..<DailySalesProductList.count
        {
  
            let Id = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
            let productId =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "productId") as! Int
            let orgId =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "orgId") as! Int
            let price =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "price") as! Double
            let productName =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "productName") as! String
            let sku =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "sku") as! String
            let productCatName =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "productCatName") as! String
            let site_id =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "siteId") as! Int
            let avalQty =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "avalQty") as! Double
            let currentQTY =  (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "currentQTY") as! Double
            let priceBookId = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "pricebookId") as! Int
            let totalOpeningStock = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalOpeningStock") as! Double
            let totalReceivingStock = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalReceivedStock") as! Double
            let totalClosingStock = (DailySalesProductList.object(at: i) as! NSDictionary).value(forKey: "totalClosingStock") as! Double
            
            print("ID :: ",Id,"productId :: ",productId,"productName ::",productName)
            
            ProductName.append(Model_Daily_Sale_ProductList.init(id: String(Id), productId: String(productId), orgId: String(orgId), price: String(price), productName: productName, sku: sku, productCatName: productCatName, site_id: String(site_id), avalQty: String(avalQty), currentQTY: String(currentQTY), PriceBookId: String(priceBookId), totalOpeningStock: String(totalOpeningStock), totalReceivedStock: String(totalReceivingStock), totalClosingStock: String(totalClosingStock)))
        }
        return ProductName
    }
}
