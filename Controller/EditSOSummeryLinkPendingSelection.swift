//
//  EditSOSummeryLinkPendingSelection.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 11/06/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

class EditSOSummeryLinkPendingSelection: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var apiCallCount = Int()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblLinkPendingSelection: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        LinkPendinORUpdate.SelectLinnkPendingData = LinkPendinORUpdate.genrateLinkPendingORUpdateArray()
        self.tblLinkPendingSelection.reloadData()
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        START_INDICATOR()
        LinkPendinORUpdate.ProductMargArray.removeAllObjects()
        for orList in 0..<LinkPendinORUpdate.ProductProfileDataMain.count
        {
            LinkPendinORUpdate.ProductMargArray.add(LinkPendinORUpdate.ProductProfileDataMain[orList])
        }
        for product in 0..<LinkPendinORUpdate.ProductIDSelect.count{
            apiCallCount += 1
            ProductIndex = product
            getORProfileForPendingOR()
        }
        if apiCallCount == 0
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        // if LinkPendinORUpdate.LinkedFinaleArray.count == 0{
        LinkPendinORUpdate.ProductSelectName.removeAllObjects()
        LinkPendinORUpdate.ProductIDSelect.removeAllObjects()
        // }
        linkpending = false
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return LinkPendinORUpdate.SelectLinnkPendingData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let uncheckImage = UIImage(named:"Login_UnCheckbox")
        let unchecker = UIImageView(image: uncheckImage)
        let checkImage = UIImage(named:"Login_Checkbox")
        let checker = UIImageView(image: checkImage)
        let Model = LinkPendinORUpdate.SelectLinnkPendingData[indexPath.row]
        let cell = self.tblLinkPendingSelection.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Model.name
        LinkPendinORUpdate.ProductName.removeAllObjects()
        LinkPendinORUpdate.ProductID.removeAllObjects()
        for i in 0..<LinkPendinORUpdate.SelectLinnkPendingData.count
        {
            let model = LinkPendinORUpdate.SelectLinnkPendingData[i]
            if  LinkPendinORUpdate.ProductName.count == 0
            {
                LinkPendinORUpdate.ProductName.insert(model.name, at: 0)
                LinkPendinORUpdate.ProductID.insert(model.id, at: 0)
            }
            else
            {
                LinkPendinORUpdate.ProductName.add(model.name)
                LinkPendinORUpdate.ProductID.add(model.id)
            }
        }
        if LinkPendinORUpdate.ProductSelectName.contains(LinkPendinORUpdate.ProductName.object(at: indexPath.row))
        {
            cell.accessoryView = checker
        }
        else
        {
            cell.accessoryView = unchecker
        }
        return cell
    }
    func filterTableView(text:String)
    {
        LinkPendinORUpdate.SelectLinnkPendingDataFilter = LinkPendinORUpdate.genrateLinkPendingORUpdateArray()
        LinkPendinORUpdate.SelectLinnkPendingData = LinkPendinORUpdate.SelectLinnkPendingDataFilter.filter({ (mod) -> Bool in
            return mod.name.lowercased().contains(text.lowercased())
        })
        self.tblLinkPendingSelection.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            LinkPendinORUpdate.SelectLinnkPendingData = LinkPendinORUpdate.SelectLinnkPendingDataFilter
            tblLinkPendingSelection.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if LinkPendinORUpdate.ProductIDSelect.contains(LinkPendinORUpdate.ProductID.object(at: indexPath.row))
        {
            LinkPendinORUpdate.ProductSelectName.remove(LinkPendinORUpdate.ProductName.object(at: indexPath.row))
            LinkPendinORUpdate.ProductIDSelect.remove(LinkPendinORUpdate.ProductID.object(at: indexPath.row))
            
        }else{
            LinkPendinORUpdate.ProductSelectName.add(LinkPendinORUpdate.ProductName.object(at: indexPath.row))
            LinkPendinORUpdate.ProductIDSelect.add(LinkPendinORUpdate.ProductID.object(at: indexPath.row))
        }
        self.tblLinkPendingSelection.reloadData()
    }
    
    var ProductIndex = Int()
    
    func getORProfileForPendingOR()
    {
        APISession.getDataWithRequest(withAPIName: "orderRequisition/saleType/\(LinkPendinORUpdate.salesTypeID)/profile/\(LinkPendinORUpdate.ProductIDSelect[ProductIndex])")
        {
            (response, permissions) in
            print(("get OR Profile For PendingOR :: ->",response))
            self.apiCallCount -= 1
            if response != nil{
                let status = response?.value(forKey: "status") as! Int
                if status != 0 {
                    let orprofile = response!.value(forKey: "orProfile") as! NSDictionary
                    let productArray = orprofile.value(forKey: "orProductMapProxys") as! NSArray
                    if productArray.count != 0 {
                        for f in 0..<productArray.count{
                            LinkPendinORUpdate.ProductMargArray.add(productArray.object(at: f))
                        }
                        print("-------->>",LinkPendinORUpdate.ProductMargArray)
                    }
                }
            }
            self.LinkedProMarging()
        }
    }
    func LinkedProMarging()
    {
        if apiCallCount == 0{
            
            
            let DicArray = NSMutableArray()
            let tempIDsave = NSMutableArray()
            for s in 0..<LinkPendinORUpdate.ProductMargArray.count{
                let value : NSDictionary = LinkPendinORUpdate.ProductMargArray[s] as! NSDictionary
                print("---------<<.>>",value)
                var quntity = 0.0
                if tempIDsave.contains(value.value(forKey: "proId") as! Int) == false
                {
                    tempIDsave.add(value.value(forKey: "proId") as! Int)
                    let Diccc = NSMutableDictionary()
                    
                    var Discount = 0.0
                    
                    //quntity = value.value(forKey: "quantity") as! Double
                    for f in 0..<LinkPendinORUpdate.ProductMargArray.count
                    {
                        let subValue : NSDictionary = LinkPendinORUpdate.ProductMargArray[f] as! NSDictionary
                        if value.value(forKey: "proId") as! Int64 == subValue.value(forKey: "proId") as! Int64
                        {
                            
                            if let  quntityNew = subValue.value(forKey: "quantity") as? Double{
                                quntity += quntityNew
                            }else{
                                quntity +=  0
                            }
                            if let discountVal = subValue.value(forKey: "discountAmount") as? Double{
                                Discount += discountVal
                            }else{
                                Discount += 0
                            }
                            
                        }
                        print("quntity==",quntity)
                        print("Discount==",Discount)
                    }
                    Diccc.setValue(value.value(forKey: "productName"), forKey: "productName")
                    Diccc.setValue(value.value(forKey: "productMargin"), forKey: "productMargin")
                    Diccc.setValue(value.value(forKey: "proId"), forKey: "productId")
                    Diccc.setValue(value.value(forKey: "proId"), forKey: "proId")
                    if let categoryyy : String = value.value(forKey: "categoryName") as? String
                    {
                        Diccc.setValue(categoryyy, forKey: "categoryName")
                        Diccc.setValue(categoryyy, forKey: "productCategoryName")
                    }
                    else if let categooory : String = value.value(forKey: "category") as? String
                    {
                        Diccc.setValue(categooory, forKey: "categoryName")
                        Diccc.setValue(categooory, forKey: "productCategoryName")
                    }
                    else
                    {
                        Diccc.setValue("NA", forKey: "categoryName")
                        Diccc.setValue("NA", forKey: "productCategoryName")
                    }
                    Diccc.setValue(value.value(forKey: "measurementName"), forKey: "measurementName")
                    Diccc.setValue(value.value(forKey: "id"), forKey: "id")
                    Diccc.setValue(value.value(forKey: "currencySymbol"), forKey: "currencySymbol")
                    Diccc.setValue(value.value(forKey: "barcode"), forKey: "barcode")
                    Diccc.setValue(value.value(forKey: "uom"), forKey: "uom")
                    Diccc.setValue(value.value(forKey: "logoId"), forKey: "logoId")
                    Diccc.setValue(value.value(forKey: "logoName"), forKey: "logoName")
                    Diccc.setValue(value.value(forKey: "priceBookPrice"), forKey: "priceBookPrice")
                    Diccc.setValue(value.value(forKey: "priceBookPrice"), forKey: "basicPrices")
                    Diccc.setValue(value.value(forKey: "priceBookPrice"), forKey: "basicPrice")
                    Diccc.setValue(Discount, forKey: "discountAmount")
                    Diccc.setValue(value.value(forKey: "sku"), forKey: "sku")
                    Diccc.setValue(quntity, forKey: "quantity")
                    var basicPricess : Double = value.value(forKey: "priceBookPrice") as! Double
                    basicPricess = basicPricess - Discount
                    let totalValue = (quntity * basicPricess)
                    Diccc.setValue(totalValue, forKey: "productTotal")
                    DicArray.add(Diccc)
                    print("- -- - - --- -- ->",DicArray)
                    
                }
            }
            tempIDsave.removeAllObjects()
            // 1. Final Json Adding in Array
            LinkPendinORUpdate.LinkedFinaleArray = DicArray
            print("All over datasss==>>> ",LinkPendinORUpdate.LinkedFinaleArray)
            self.dismiss(animated: true, completion: nil)
        }
        STOP_INDICATOR()
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(LoginScreen.doneButtonAction))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.searchBar.inputAccessoryView = doneToolbar
    }
    func doneButtonAction()
    {
        //searchBar.text = ""
        if (searchBar.text?.isEmpty)! {
            LinkPendinORUpdate.SelectLinnkPendingDataFilter = LinkPendinORUpdate.SelectLinnkPendingData
            tblLinkPendingSelection.reloadData()
        }
        else
        {
            filterTableView(text: searchBar.text!)
        }
        self.searchBar.resignFirstResponder()
    }
    
}
