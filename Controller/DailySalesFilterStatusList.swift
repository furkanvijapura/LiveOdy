//
//  DailySalesFilterStatusList.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 10/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var statusId = String()
var statusValue = String()

class DailySalesFilterStatusList: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate
{
    var FilterStatus : [SalesListModel] = SalesListModel.generateSOFilterModelArray()
    
    var ModelFilter : [SalesListModel] = SalesListModel.generateSOFilterModelArray()
    
    @IBOutlet var searchStatus: UISearchBar!
    @IBOutlet var tbl_StatusList: UITableView!
    
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
        let cellBuyer = self.tbl_StatusList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = ModelFilter[indexPath.row]
        cellBuyer.textLabel?.text = model.value
        return cellBuyer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = ModelFilter[indexPath.row]
        print(model.id)
        
        statusId = model.id
        statusValue = model.value
        
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
        self.searchStatus.inputAccessoryView = keyboardToolbar
    }
    
    func doneButtonAction()
    {
        self.searchStatus.resignFirstResponder()
    }
    
    //MARK:- Cancel Button
    
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Filter
    
    func filterTableView(text:String)
    {
        FilterStatus = SalesListModel.generateSOFilterModelArray()
        ModelFilter = FilterStatus.filter({ (mod) -> Bool in
            return mod.value.lowercased().contains(text.lowercased())
        })
        self.tbl_StatusList.reloadData()
        
    }
    
    //MARK:- SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            ModelFilter = FilterStatus
            tbl_StatusList.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }


}
