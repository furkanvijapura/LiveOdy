//
//  DailySalesSelectProduct.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 29/01/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
var arrayProductListsDailyTertiary = NSArray()
var DailySalesProductID = String()
var DailySalesProductValue = String()

class DailySalesSelectProduct: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var FilterProduct : [Model_Daily_Sale_ProductList] = Model_Daily_Sale_ProductList.generateModelArray()
    var ModelFilter : [Model_Daily_Sale_ProductList] = Model_Daily_Sale_ProductList.generateModelArray()
    var arrSelectProductDataNewSO = NSMutableArray()
    var searchActive : Bool = false
    @IBOutlet var tblDailySalesProductList: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    //MARK:- View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDoneOnKeyboard()
        tblDailySalesProductList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Save Button
    
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        CountProduct = arrSelectProductDataNewSO
        print(CountProduct)
        StockProduct = arrSelectProductDataNewSO
        print(StockProduct)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Table Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       // return ModelFilter.count
        if arrayProductListsDailyTertiary.count==0{
            return 1
        }
        else{
        return arrayProductListsDailyTertiary.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellBuyer = self.tblDailySalesProductList.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductSelectCell
       // let model = ModelFilter[indexPath.row]
        //cellBuyer.textLabel?.text = model.productName
        if arrayProductListsDailyTertiary.count==0{
            cellBuyer.lblProductName.text = "No Product(s) Found"
        }
        else{

        let orgName:NSArray=(arrayProductListsDailyTertiary as AnyObject).value(forKey: "productName") as! NSArray
        cellBuyer.lblProductName?.text = (orgName[indexPath.row] as? String)!
        
        if arrSelectProductDataNewSO.contains(arrayProductListsDailyTertiary[indexPath.row])
        {
            let checkImage = UIImage(named:"Login_Checkbox")
            let checkers = UIImageView(image: checkImage)
            cellBuyer.accessoryView = checkers
        }
        else
        {
            let checkImage = UIImage(named:"Login_UnCheckbox")
            let checkers = UIImageView(image: checkImage)
            cellBuyer.accessoryView = checkers
        }
        }
        return cellBuyer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         if arrayProductListsDailyTertiary.count != 0
        {
        if arrSelectProductDataNewSO.contains(arrayProductListsDailyTertiary[indexPath.row])
        {
            arrSelectProductDataNewSO.remove(arrayProductListsDailyTertiary[indexPath.row])
        }
        else
        {
            arrSelectProductDataNewSO.add(arrayProductListsDailyTertiary[indexPath.row])
        }
        self.tblDailySalesProductList.reloadData()
        }

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
        self.searchBar.inputAccessoryView = keyboardToolbar
    }
    
    func doneButtonAction()
    {
        self.searchBar.resignFirstResponder()
    }
    
    //MARK:- Cancel Button
    
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Filter
    
    func filterTableView(text:String)
    {
        FilterProduct = Model_Daily_Sale_ProductList.generateModelArray()
        ModelFilter = FilterProduct.filter({ (mod) -> Bool in
            return mod.productName.lowercased().contains(text.lowercased())
        })
        self.tblDailySalesProductList.reloadData()
        
    }
    
    //MARK:- SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            ModelFilter = FilterProduct
            tblDailySalesProductList.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }
}
