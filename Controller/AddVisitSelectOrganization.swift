//
//  AddVisitSelectOrganization.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 03/05/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

class AddVisitSelectOrganization: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var searchOrg: UISearchBar!
    @IBOutlet weak var tblOrg: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrgNameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOrganization")
        let ModelOrg = OrgNameData[indexPath.row]
        cell?.textLabel?.text = ModelOrg.value
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ModelOrg = OrgNameData[indexPath.row]
        OrgNameModel.OrganizationID = ModelOrg.id
        OrgNameModel.OrganizationName = ModelOrg.value
        OrgNameModel.OrganizationTypeID = ModelOrg.TypeID
        self.dismiss(animated: true, completion:nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            OrgNameData = OrgNameFilter
            tblOrg.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }
    func filterTableView(text:String)
    {
        OrgNameFilter = OrgNameModel.generateFilterModelArray()
        OrgNameData = OrgNameFilter.filter({ (mod) -> Bool in
            return mod.value.lowercased().contains(text.lowercased())
        })
        self.tblOrg.reloadData()
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
        
        self.searchOrg.inputAccessoryView = doneToolbar
    }
    func doneButtonAction()
    {
        self.searchOrg.resignFirstResponder()
        searchOrg.text = ""
        if (searchOrg.text?.isEmpty)! {
            OrgNameData = OrgNameFilter
            tblOrg.reloadData()
        }
        else
        {
            filterTableView(text: searchOrg.text!)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        getAllOrganizationNameWithID()
        addDoneButtonOnKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getAllOrganizationNameWithID()
    {
        if Reachability.isConnectedToNetwork(){
            let objDic:NSMutableDictionary = NSMutableDictionary.init()
            objDic .setValue("visitOrganizations", forKey:"value")
            APISession.postDataWithRequestwithToken(objDic, withAPIName: "data/bySite") { (response, isVisit)
                in
                print(("Response is......",response))
                self.STOP_INDICATOR()
                if response != nil
                {
                    OrgNameModel.OrganizationNameList = response!
                    OrgNameData = OrgNameModel.generateFilterModelArray()
                    self.tblOrg.reloadData()
                }
            }
        }
        else
        {
//        self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
}
