//
//  OR-LinkPendin-CreateOR.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 25/05/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

class OR_LinkPendin_CreateOR: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var searchProduct: UISearchBar!
    @IBOutlet weak var tblSelectProduct: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        LinkPendinOR.SelectLinnkPendingData = LinkPendinOR.genrateLinkPendingORArray()
        self.tblSelectProduct.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return LinkPendinOR.SelectLinnkPendingData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let uncheckImage = UIImage(named:"Login_UnCheckbox")
        let unchecker = UIImageView(image: uncheckImage)
        let checkImage = UIImage(named:"Login_Checkbox")
        let checker = UIImageView(image: checkImage)
        let Model = LinkPendinOR.SelectLinnkPendingData[indexPath.row]
        let cell = self.tblSelectProduct.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Model.name
        LinkPendinOR.ProductName.removeAllObjects()
        LinkPendinOR.ProductID.removeAllObjects()
        for i in 0..<LinkPendinOR.SelectLinnkPendingData.count
        {
            let model = LinkPendinOR.SelectLinnkPendingData[i]
            if  LinkPendinOR.ProductName.count == 0
            {
                LinkPendinOR.ProductName.insert(model.name, at: 0)
                LinkPendinOR.ProductID.insert(model.id, at: 0)
            }
            else
            {
                LinkPendinOR.ProductName.add(model.name)
                LinkPendinOR.ProductID.add(model.id)
            }
        }
        if LinkPendinOR.ProductSelectName.contains(LinkPendinOR.ProductName.object(at: indexPath.row))
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
        LinkPendinOR.SelectLinnkPendingDataFilter = LinkPendinOR.genrateLinkPendingORArray()
        LinkPendinOR.SelectLinnkPendingData = LinkPendinOR.SelectLinnkPendingDataFilter.filter({ (mod) -> Bool in
            return mod.name.lowercased().contains(text.lowercased())
        })
        self.tblSelectProduct.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            LinkPendinOR.SelectLinnkPendingData = LinkPendinOR.SelectLinnkPendingDataFilter
            tblSelectProduct.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if LinkPendinOR.ProductIDSelect.contains(LinkPendinOR.ProductID.object(at: indexPath.row))
        {
            LinkPendinOR.ProductSelectName.remove(LinkPendinOR.ProductName.object(at: indexPath.row))
            LinkPendinOR.ProductIDSelect.remove(LinkPendinOR.ProductID.object(at: indexPath.row))
            
        }else{
            LinkPendinOR.ProductSelectName.add(LinkPendinOR.ProductName.object(at: indexPath.row))
            LinkPendinOR.ProductIDSelect.add(LinkPendinOR.ProductID.object(at: indexPath.row))
        }
        self.tblSelectProduct.reloadData()
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
//        LinkPendinOR.ProductIDSelect.removeAllObjects()
//        LinkPendinOR.ProductID.removeAllObjects()
//        LinkPendinOR.ProductSelectName.removeAllObjects()
//        LinkPendinOR.ProductName.removeAllObjects()
        linkpending = false
        self.dismiss(animated: true, completion: nil)
    }
    var ProductIndex = Int()
    @IBAction func btnSave(_ sender: UIButton) {
        LinkPendinOR.ProductMargArray.removeAllObjects()
        for product in 0..<LinkPendinOR.ProductIDSelect.count{
            ProductIndex = product
            getORProfileForPendingOR()
        }
        self.dismiss(animated: true, completion: nil)
    }

    func getORProfileForPendingOR()
    {
     APISession.getDataWithRequest(withAPIName: "orderRequisition/saleType/\(LinkPendinOR.salesTypeID)/profile/\(LinkPendinOR.ProductIDSelect[ProductIndex])")
        {
            (response, permissions) in
            print(("get OR Profile For PendingOR :: ->",response))
            if response != nil{
                
                let productArray : NSArray = (response?.value(forKey: "orProfile") as! NSDictionary).value(forKey: "orProductMapProxys") as! NSArray
                for f in 0..<productArray.count{
                    LinkPendinOR.ProductMargArray.add(productArray.object(at: f))
                }
                print(LinkPendinOR.ProductMargArray)
            }
        }
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
        
        self.searchProduct.inputAccessoryView = doneToolbar
    }
    func doneButtonAction()
    {
        
        if (searchProduct.text?.isEmpty)! {
            LinkPendinOR.SelectLinnkPendingDataFilter = LinkPendinOR.SelectLinnkPendingData
            tblSelectProduct.reloadData()
        }
        else
        {
            searchProduct.text = ""
            filterTableView(text: searchProduct.text!)
            if  searchProduct.text == ""{
                LinkPendinOR.SelectLinnkPendingData = LinkPendinOR.SelectLinnkPendingDataFilter
                tblSelectProduct.reloadData()
            }
        }
        self.searchProduct.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

