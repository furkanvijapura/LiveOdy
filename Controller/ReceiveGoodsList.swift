//
//  ReceiveGoodsList.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 05/02/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
import Floaty
//START_INDICATOR()
//self.STOP_INDICATOR()

var TableReceiveGoods = UITableView()

class ReceiveGoodsList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var floaty = Floaty()
    var searchActive : Bool = false
    @IBOutlet var tblReciveGoods: UITableView!
    @IBOutlet var SearchBarTertiary: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Receive List"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(TertiaryStackStock.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        //self.layoutFAB()
        addDoneButtonOnKeyboard()
        TableReceiveGoods = tblReciveGoods
        if Reachability.isConnectedToNetwork(){
        GetReceiveGoods()
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
        refreshiingBoooo = false
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.tblReciveGoods.addSubview(refreshControl)
        tblReciveGoods.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        GetReceiveGoods()
    }
    func back(sender: UIBarButtonItem)
    {
        ReceiveGoodsData = ReceiveGoodsFilterData
        tblReciveGoods.reloadData()
        _ = navigationController?.popViewController(animated: true)
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(TertiaryStackStock.doneButtonAction))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        self.SearchBarTertiary.inputAccessoryView = doneToolbar
    }
    func doneButtonAction()
    {
        SearchBarTertiary.text = ""
        if (SearchBarTertiary.text?.isEmpty)! {
            ReceiveGoodsData = ReceiveGoodsFilterData
            tblReciveGoods.reloadData()
        }
        else
        {
            filterTableView(text: SearchBarTertiary.text!)
        }
        self.SearchBarTertiary.resignFirstResponder()
    }
    func layoutFAB()
    {
//        floaty.addItem("Report", icon: UIImage(named: "share_or"))
//        {
//            item in
//
//            let textToShare = "Swift is awesome!  Check out this website about it!"
//            if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
//                let objectsToShare = [textToShare, myWebsite] as [Any]
//                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//                activityVC.popoverPresentationController?.sourceView = item
//                self.present(activityVC, animated: true, completion: nil)
//            }
//        }
        
//        floaty.addItem("Start stock take", icon: UIImage(named: "create_or"))
//        {
//            item in
//            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "DailySalesSummary") as! DailySalesSummary
//            //UpdateDailySalesScreen
//            self.navigationController?.pushViewController(objReg, animated: true)
//        }
//        floaty.paddingX = 20
//        floaty.paddingY = 20
//        floaty.fabDelegate = self as? FloatyDelegate
//        self.view.addSubview(floaty)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReciveGoods.dequeueReusableCell(withIdentifier: "cell") as! ReceiveGoodsListCell
        let ModelT = ReceiveGoodsData[indexPath.row]
        cell.lblBuyerName.text = ModelT.buyerOrganizationName
        cell.lblWhereHouseName.text = "[" + ModelT.buyerWarehouseName + "]"
        cell.lblSellerName.text = ModelT.sellerOrganizationName
        cell.lblReceiveId.text = ModelT.tReceiveId
        let strSymbol:String =  ModelT.currencySymbol 
        cell.btnCreaterDate.setTitle(ModelT.createdDate, for: .normal)
        cell.lblSoNumber.text = ModelT.saleOrderNo
        cell.btnTotalAmount.setTitle(strSymbol + " " + ModelT.totalAmount, for: .normal)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReceiveGoodsData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if Reachability.isConnectedToNetwork(){
        let ModelT = ReceiveGoodsData[indexPath.row]
        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"ReceiveGoodsProfileScreen") as! ReceiveGoodsProfileScreen
        objReg.strProfileId=ModelT.id
        self.navigationController?.pushViewController(objReg, animated: true)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnFilter(_ sender: Any)
    {
        let pushFilter = storyboard?.instantiateViewController(withIdentifier: "Receive_Goods_Filter")as! Receive_Goods_Filter
        self.navigationController?.pushViewController(pushFilter, animated: true)
    }
    func filterTableView(text:String)
    {
        ReceiveGoodsFilterData = ModelReceiveGoodsList.generateReceiveGoodArray()
        ReceiveGoodsData = ReceiveGoodsFilterData.filter({ (mod) -> Bool in
            return mod.buyerOrganizationName.lowercased().contains(text.lowercased()) || mod.sellerOrganizationName.lowercased().contains(text.lowercased()) || mod.buyerWarehouseName.lowercased().contains(text.lowercased()) || mod.tReceiveId.lowercased().contains(text.lowercased()) || mod.createdDate.lowercased().contains(text.lowercased()) || mod.saleOrderNo.lowercased().contains(text.lowercased())
        })
        self.tblReciveGoods.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            ReceiveGoodsData = ReceiveGoodsFilterData
            tblReciveGoods.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
        tblReciveGoods.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
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


}
