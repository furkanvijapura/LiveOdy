//
//  CompanyListScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 17/11/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
let initialDataAryFilter:[FIlterModel] = FIlterModel.generateModelFilterArray()
var dataAryFilter:[FIlterModel] = FIlterModel.generateModelFilterArray()
class CompanyListScreen: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate
{
   
    var isFilterArr=Bool()
    
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var txtEnable: UITextField!
    @IBOutlet weak var tblCompanyList: UITableView!
    @IBOutlet weak var searchBarCompany: UISearchBar!
    var  arrCompanydata = NSArray()
    var  arrSelectData = NSMutableArray()
    var arrAutosearchProduct = NSArray()
    var searchActive : Bool = false
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Contacts"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(CompanyListScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        searchBarCompany.delegate = self
        addDoneButtonOnKeyboard()
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.clear
        refreshControl?.tintColor = UIColor.black
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        tblCompanyList.addSubview(refreshControl!)
    }
    override func viewWillAppear(_ animated: Bool) {
        tblCompanyList.reloadData()
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        isFilterArr = false
        
        if contactFilterBoolManagerrr.contactCompanyBool == 1 && contactFilterBoolManagerrr.contactPersonBool == 1
        {
            // picker editable
            getCompanyLists()
        }
        else if contactFilterBoolManagerrr.contactCompanyBool == 1 && contactFilterBoolManagerrr.contactPersonBool == 0
        {
            getCompanyFinalLists()
        }
        else  if contactFilterBoolManagerrr.contactCompanyBool == 0 && contactFilterBoolManagerrr.contactPersonBool == 1
        {
            getPersonFinalLists()
        }
        else{
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func getCompanyLists()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataWithRequestWithToken( withAPIName:"common/contacts" )
            {
                (response, permissions) in
                print(("",response))
                refreshControl.endRefreshing()
                self.STOP_INDICATOR()
                if response != nil
                {
                    DicData = (response)!
                    ModelContact.removeAll()
                    ModelContact = Model.generateModelArray()
                    ModelContactFilterfilter.removeAll()
                    ModelContactFilterfilter = Model.generateModelArray()
                   self.tblCompanyList.reloadData()
                }
                
            }
        }
        else
        {
            //            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    func getCompanyFinalLists()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            let objDic:NSMutableDictionary=NSMutableDictionary.init()
            objDic .setValue("1", forKey:"filterType")
            objDic .setValue("1", forKey:"filterStatus")
            APISession.postDataWithRequestwithToken(objDic, withAPIName: "common/contacts/filter")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                refreshControl.endRefreshing()
                print(("",response))
                if response != nil
                {
                    DicData = (response)!
                    ModelContact.removeAll()
                    ModelContact = Model.generateModelArray()
                    ModelContactFilterfilter.removeAll()
                    ModelContactFilterfilter = Model.generateModelArray()
                }
            }
        }
        else
        {
            //            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func getPersonFinalLists()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            let objDic:NSMutableDictionary=NSMutableDictionary.init()
            objDic .setValue("2", forKey:"filterType")
            objDic .setValue("1", forKey:"filterStatus")
            APISession.postDataWithRequestwithToken(objDic, withAPIName: "common/contacts/filter")
            {
                (response, permissions) in
                self.STOP_INDICATOR()
                refreshControl.endRefreshing()
                print(("",response))
                if response != nil
                {
                    DicData = (response)!
                    ModelContact.removeAll()
                    ModelContact = Model.generateModelArray()
                    ModelContactFilterfilter.removeAll()
                    ModelContactFilterfilter = Model.generateModelArray()
                }
            }
        }
        else
        {
            //            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    @IBAction func btnFilterTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
            isFilterArr=true
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "CompanyPeopleFilterScreen") as! CompanyPeopleFilterScreen
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        else
        {
            //            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func back(sender: UIBarButtonItem)
    {
        ModelContact = ModelContactFilterfilter
       // tblCompanyList.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView:  UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isFilterArr == true
        {
            return dataAryFilter.count
        }
        else
        {
            return ModelContact.count
        }
    }
    var name = String()
    var orgId = String()
    var type = String()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CompanyListCell
        if isFilterArr==true
        {
            let model = dataAryFilter[indexPath.row]
            if model.contactType == 1
            {
                cell.imgUser.isHidden=true
                cell.lblCompanyName.text = model.OrganizationName
                cell.lblCompanyType.text = model.OrganizationType
                cell.imgContactType.image = UIImage(named: "Industery_Dark_Blue")
            }
            if model.contactType == 2
            {
                cell.imgUser.isHidden=false
                cell.lblCompanyName.text = model.fullName
                cell.lblCompanyType.text = model.designation
                cell.imgContactType.image = UIImage(named: "User_Dark_blue")
            }
            if model.contactType == 3
            {
                cell.imgUser.isHidden=true
                cell.imgContactType.image = UIImage(named: "User_Dark_blue")
                cell.lblCompanyName.text = model.fullName
                cell.lblCompanyType.text = model.designation
            }
            if model.ProLogo != ""
            {
                let imgprofile  = Constant.WEBSERVICE_URLUploadImage + model.ProLogoID + "_" + (model.ProLogo as String)
                let strValue:String = imgprofile + "?token=" + objInfo.Token
                
                //remove space from url -
                let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
                let url = URL(string: urlString!)
                let data = try? Data(contentsOf: url!)
                if data != nil
                {
                    cell.btnProfilePic.setImage(UIImage(data: data!), for: UIControlState.normal)
                }
            }
            else{
                cell.btnProfilePic.setImage(UIImage(named:"User_profile_icon"), for: UIControlState.normal)
            }
        }
        else{
            let model = ModelContact[indexPath.row]
            if model.contactType == 1
            {
                cell.imgUser.isHidden=true
                cell.lblCompanyName.text = model.OrganizationName
                cell.lblCompanyType.text = model.OrganizationType
                cell.imgContactType.image = UIImage(named: "Industery_Dark_Blue")
            }
            if model.contactType == 2
            {
                cell.imgUser.isHidden=false
                cell.lblCompanyName.text = model.fullName
                cell.lblCompanyType.text = model.designation
                cell.imgContactType.image = UIImage(named: "User_Dark_blue")
            }
            if model.contactType == 3
            {
                cell.imgUser.isHidden=true
                cell.imgContactType.image = UIImage(named: "User_Dark_blue")
                cell.lblCompanyName.text = model.fullName
                cell.lblCompanyType.text = model.designation
            }
            if model.ProLogo != ""{
                let imgprofile  = Constant.WEBSERVICE_URLUploadImage + model.ProLogoID + "_" + (model.ProLogo as String)
                let strValue:String = imgprofile + "?token=" + objInfo.Token
                //remove space from url - 
                let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: urlString!)
                let data = try? Data(contentsOf: url!)
                if data != nil{
                    cell.btnProfilePic.setImage(UIImage(data: data!), for: UIControlState.normal)
                }
            }
            else{
                cell.btnProfilePic.setImage(UIImage(named:"User_profile_icon"), for: UIControlState.normal)
            }
        }
        return cell
    }
    func doneButtonAction()
    {
        searchBarCompany.text = ""
        if isFilterArr==true {
            if (searchBarCompany.text?.isEmpty)! {
                dataAryFilter = initialDataAryFilter
                tblCompanyList.reloadData()
            }else {
                filterTableView(text: searchBarCompany.text!)
            }
        }
        else{
            if (searchBarCompany.text?.isEmpty)! {
                ModelContact = ModelContactFilterfilter
                tblCompanyList.reloadData()
            }else {
                filterTableView(text: searchBarCompany.text!)
            }
        }
        self.searchBarCompany.resignFirstResponder()
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(CompanyListScreen.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.searchBarCompany.inputAccessoryView = doneToolbar
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if Reachability.isConnectedToNetwork(){
            if isFilterArr==true {
                let model = dataAryFilter[indexPath.row]
                if model.contactType==1
                {
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier: "CompanyProfileScreen") as!CompanyProfileScreen
                    objReg.companyId = model.ID as NSString
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
                else
                {
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier: "PeopleProfileScreen") as!PeopleProfileScreen
                    objReg.companyId = model.ID as NSString
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
            }
            else
            {
                let model = ModelContact[indexPath.row]
                if model.contactType==1
                {
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier: "CompanyProfileScreen") as!CompanyProfileScreen
                    objReg.companyId = model.ID as NSString
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
                else{
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier: "PeopleProfileScreen") as!PeopleProfileScreen
                    objReg.companyId = model.ID as NSString
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
            }
        }
        else
        {
            //            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }
    func filterTableView(text:String) {
        if isFilterArr == true {
            
            dataAryFilter = initialDataAryFilter.filter({ (mod) -> Bool in
                return mod.OrganizationName.lowercased().contains(text.lowercased())
            })
            
        }
        else{
            ModelContact = ModelContactFilterfilter.filter({ (mod) -> Bool in
                return mod.OrganizationName.lowercased().contains(text.lowercased())
            })
        }
        self.tblCompanyList.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if isFilterArr==true {
            if searchText.isEmpty {
                dataAryFilter = initialDataAryFilter
                tblCompanyList.reloadData()
            }else {
                filterTableView(text: searchText)
            }
        }
        else{
            if searchText.isEmpty {
                ModelContact = ModelContactFilterfilter
                tblCompanyList.reloadData()
            }else {
                filterTableView(text: searchText)
            }
        }
    }
}
