//
//  DailySalesRetailerNameList.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 29/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var DailySalesRetailerID = String()
var DailySalesRetailerValue = String()

class DailySalesRetailerNameList: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate
{
    var FilterRetailer : [Model_Daily_Sales_Retailer] = Model_Daily_Sales_Retailer.generateModelArray()
    
    var ModelFilter : [Model_Daily_Sales_Retailer] = Model_Daily_Sales_Retailer.generateModelArray()
    
    @IBOutlet var searchRetailerName: UISearchBar!
    @IBOutlet var tbl_RetailerName: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneOnKeyboard()
    }
    
    //MARK:- Table Delegates And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ModelFilter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellBuyer = self.tbl_RetailerName.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = ModelFilter[indexPath.row]
        cellBuyer.textLabel?.text = model.value
        return cellBuyer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = ModelFilter[indexPath.row]
        print(model.id)
        
        DailySalesRetailerID = model.id
        DailySalesRetailerValue = model.value
        
        let id = model.id
        print(id)
        
//        self.getDailySalesProductListing(Id: model.id)
        
        //UserDefaults.standard.setValue(model.id, forKey: "buyerIDForOr")
        //UserDefaults.standard.setValue(model.value, forKey: "buyerNameForOr")
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Set on Done Button
    
    func setDoneOnKeyboard()
    {
        //let textfield = UITextField()
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.searchRetailerName.inputAccessoryView = keyboardToolbar
    }
    
    func doneButtonAction()
    {
        self.searchRetailerName.resignFirstResponder()
    }
    
    //MARK:- Cancel Button
    
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Filter
    
    func filterTableView(text:String)
    {
        FilterRetailer = Model_Daily_Sales_Retailer.generateModelArray()
        ModelFilter = FilterRetailer.filter({ (mod) -> Bool in
            return mod.value.lowercased().contains(text.lowercased())
        })
        self.tbl_RetailerName.reloadData()
        
    }
    
    //MARK:- SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            ModelFilter = FilterRetailer
            tbl_RetailerName.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }
    
    //MARK:- Get Product
    
//    func getDailySalesProductListing(Id:String)
//        {
////            var ID = "\(Id)"
//  
////            let str = "TertiaryInvt/retailer/" + DailySalesRetailerID + "/products"
//            
//            //Str
//            let str = "TertiaryInvt/retailer/" + Id + "/products" + "/03 jul 2018"
//            print(str)
////            ("retailer/{retailerId}/products/{date}")
//            APISession.getDataWithRequest( withAPIName: str)
//            {
//                (response, permissions) in
//                print(("",response))
//                self.STOP_INDICATOR()
//                if response != nil
//                {
//                    DailySalesProductList = response!.value(forKey: "products") as! NSArray
//                    arrayProductListsDailyTertiary = response!.value(forKey: "products") as! NSArray
////                    self.tblDailySalesProductList.reloadData()
//                }
//            }
//    }
}
