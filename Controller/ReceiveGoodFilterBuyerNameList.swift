//
//  ReceiveGoodFilterBuyerNameList.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 12/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var ReceiveBuyerId = String()
var ReceiveBuyerValue = String()

class ReceiveGoodFilterBuyerNameList: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate
{
    var FilterBuyer : [BuyerNameModel] = BuyerNameModel.generateFilterModelArray()
    
    var ModelFilter : [BuyerNameModel] = BuyerNameModel.generateFilterModelArray()
    
    @IBOutlet var searchBuyerName: UISearchBar!
    @IBOutlet var tbl_BuyerList: UITableView!
    
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
        let cellBuyer = self.tbl_BuyerList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = ModelFilter[indexPath.row]
        cellBuyer.textLabel?.text = model.value
        return cellBuyer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = ModelFilter[indexPath.row]
        print(model.id)
        
        ReceiveBuyerId = model.id
        ReceiveBuyerValue = model.value
        
        //UserDefaults.standard.setValue(model.id, forKey: "buyerIDForOr")
        //UserDefaults.standard.setValue(model.value, forKey: "buyerNameForOr")
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:-  Set on Done Button
    
    func setDoneOnKeyboard()
    {
        //let textfield = UITextField()
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.searchBuyerName.inputAccessoryView = keyboardToolbar
    }
    
    func doneButtonAction()
    {
        self.searchBuyerName.resignFirstResponder()
    }
    
    //MARK:- Cancel Button
    
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Filter
    
    func filterTableView(text:String)
    {
        FilterBuyer = BuyerNameModel.generateFilterModelArray()
        ModelFilter = FilterBuyer.filter({ (mod) -> Bool in
            return mod.value.lowercased().contains(text.lowercased())
        })
        self.tbl_BuyerList.reloadData()
        
    }
    
    //MARK:- SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            ModelFilter = FilterBuyer
            tbl_BuyerList.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }

}
