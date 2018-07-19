//
//  DailySalesFilterCreaterNameList.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 05/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

var createId = String()
var createValue = String()

class DailySalesFilterCreaterNameList: UIViewController ,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate
{
    var FilterCreated : [CreatedByModel] = CreatedByModel.generateSOFilterModelArray()
    
    var ModelFilter : [CreatedByModel] = CreatedByModel.generateSOFilterModelArray()
    
    @IBOutlet var searchCreater: UISearchBar!
    @IBOutlet var tbl_CreaterList: UITableView!
    
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
        let cellBuyer = self.tbl_CreaterList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = ModelFilter[indexPath.row]
        cellBuyer.textLabel?.text = model.value
        return cellBuyer
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let model = ModelFilter[indexPath.row]
        print(model.id)
        
        createId = model.id
        createValue = model.value
        
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
        self.searchCreater.inputAccessoryView = keyboardToolbar
    }
    
    func doneButtonAction()
    {
        self.searchCreater.resignFirstResponder()
    }
    //MARK:- Cancel Button
    
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Filter
    
    func filterTableView(text:String)
    {
        FilterCreated = CreatedByModel.generateSOFilterModelArray()
        ModelFilter = FilterCreated.filter({ (mod) -> Bool in
            return mod.value.lowercased().contains(text.lowercased())
        })
        self.tbl_CreaterList.reloadData()
        
    }
    
    //MARK:- SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            ModelFilter = FilterCreated
            tbl_CreaterList.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }

}
