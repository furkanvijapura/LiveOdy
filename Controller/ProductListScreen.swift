//
//  ProductListScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 20/11/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class ProductListScreen: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {

    let initialDataAryFilter:[ModelProductlist] = ModelProductlist.generateModelArray()
    var dataAryFilter:[ModelProductlist] = ModelProductlist.generateModelArray()
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tblProductList: UITableView!
    @IBOutlet weak var txtEnabled: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    var  arrProductdata = NSArray()
    var isFilterProduct=Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ProductListScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        addDoneButtonOnKeyboard()
        searchBar.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.clear
        refreshControl?.tintColor = UIColor.black
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        tblProductList.reloadData()
        tblProductList.addSubview(refreshControl!)
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        getProductLists()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getProductLists()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataWithRequestWithToken( withAPIName: "product/getAllMinifiedProducts") {
                (response, permissions) in
                 refreshControl.endRefreshing()
                print(("",response))
                self.STOP_INDICATOR()
                if response != nil
                {
                    DicDataProductList=(response)!
                    //            self.INDISTOP()
                    //  self.arrProductdata = response!
                    ModelProductlist1.removeAll()
                    ModelProductlistfilter.removeAll()
                    ModelProductlist1 = ModelProductlist.generateModelArray()
                    ModelProductlistfilter = ModelProductlist.generateModelArray()
                }
            }
        }
        else
        {
            self.STOP_INDICATOR()
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnFilterTapped(_ sender: Any)
    {
        isFilterProduct = true
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "ProductFilterScreen") as! ProductFilterScreen
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    func back(sender: UIBarButtonItem)
    {
        ModelProductlist1 = ModelProductlistfilter
        tblProductList.reloadData()
    _ = navigationController?.popViewController(animated: true)
//        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "MainViewScreen") as? MainViewScreen
//        let navBar = UINavigationController(rootViewController: destination1!)
//        self.present(navBar, animated: false, completion: nil)
    }
    func tableView(_ tableView:  UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isFilterProduct==true
        {
            if dataAryFilter.count == 0{
                return 1
            }
            else{
            return dataAryFilter.count
            }
        }
        else{
        return ModelProductlist1.count
        }
    }
    var name = String()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductListCell
        if isFilterProduct == true {
            if dataAryFilter.count != 0{
                let model = dataAryFilter[indexPath.row]
                cell.lblProductName.text = model.OrganizationName
                cell.lblProductType.text = model.OrganizationType
                //            name = cell.lblProductName.text!
                //            let fullName    = name
                //            let fullNameArr = fullName.components(separatedBy: " ")
                //            let nm    = fullNameArr[0]
                //            cell.setDefaultImage1(name: nm)
                if model.ProLogo != ""{
                    let imgprofile  = Constant.WEBSERVICE_URLUploadImage + model.ProLogoID + "_" + (model.ProLogo as String)
                    let strValue:String = imgprofile + "?token=" + objInfo.Token
                    let url = URL(string: strValue)
                    let data = try? Data(contentsOf: url!)
                    if data != nil{
                        cell.btnProfilePic.setImage(UIImage(data: data!), for: UIControlState.normal)
                    }
                }
                else{
                    cell.btnProfilePic.setImage(UIImage(named:"User_profile_icon"), for: UIControlState.normal)
                }
                
            }
            else{
                // displayAlertMessage(messageToDisplay: "No Products Available..")
                cell.lblProductName.text = "No Products Available"
                cell.lblProductType.isHidden = true
            }
            
        }
        else{
            
            let model = ModelProductlist1[indexPath.row]
            cell.lblProductName.text = model.OrganizationName
            cell.lblProductType.text = model.OrganizationType
            if model.ProLogo != ""{
                let imgprofile  = Constant.WEBSERVICE_URLUploadImage + model.ProLogoID + "_" + (model.ProLogo as String)
                let strValue:String = imgprofile + "?token=" + objInfo.Token
                let url = URL(string: strValue)
                let data = try? Data(contentsOf: url!)
                if data != nil{
                    cell.btnProfilePic.setImage(UIImage(data: data!), for: UIControlState.normal)
                }
                //                                else{
                //                                    name = cell.lblProductName.text!
                //                                    let fullName    = name
                //                                    let fullNameArr = fullName.components(separatedBy: " ")
                //                                    let nm    = fullNameArr[0]
                //                                    cell.setDefaultImage1(name: nm)
                //                                }
            }
            else{
                cell.btnProfilePic.setImage(UIImage(named:"User_profile_icon"), for: UIControlState.normal)
            }
            
        }
        return cell
    }
    func doneButtonAction()
    {
        searchBar.text = ""
        if isFilterProduct==true {
            if (searchBar.text?.isEmpty)! {
                dataAryFilter = initialDataAryFilter
                tblProductList.reloadData()
            }else {
                filterTableView(text: searchBar.text!)
            }
        }
        else{
        if (searchBar.text?.isEmpty)! {
            ModelProductlist1 = ModelProductlistfilter
            tblProductList.reloadData()
        }else {
            filterTableView(text: searchBar.text!)
        }
        }
        self.searchBar.resignFirstResponder()
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ProductListScreen.doneButtonAction))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.searchBar.inputAccessoryView = doneToolbar
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if isFilterProduct==true {
            let model = dataAryFilter[indexPath.row]
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "ProductProfileScreen") as! ProductProfileScreen
            objReg.productId = model.ID as NSString
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        else{
        let model = ModelProductlist1[indexPath.row]
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "ProductProfileScreen") as! ProductProfileScreen
        objReg.productId = model.ID as NSString
        self.navigationController?.pushViewController(objReg, animated: true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if isFilterProduct==true {
            if searchText.isEmpty {
                dataAryFilter = initialDataAryFilter
                tblProductList.reloadData()
            }else {
                filterTableView(text: searchText)
            }
        }
        else{
        if searchText.isEmpty {
            ModelProductlist1 = ModelProductlistfilter
            tblProductList.reloadData()
        }else {
            filterTableView(text: searchText)
        }
        }
    }
    func filterTableView(text:String) {
        if isFilterProduct == true {
            dataAryFilter = initialDataAryFilter.filter({ (mod) -> Bool in
                return mod.OrganizationName.lowercased().contains(text.lowercased())
            })
        }
        else{
        
        ModelProductlist1 = ModelProductlistfilter.filter({ (mod) -> Bool in
            return mod.OrganizationName.lowercased().contains(text.lowercased())
        })
        }
        self.tblProductList.reloadData()
    }
}
