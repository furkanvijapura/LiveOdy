//
//  ProductMoreInfoScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 01/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class ProductMoreInfoScreen: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var viewDocumentProduct: UIView!
    @IBOutlet weak var tblProductInfo: UITableView!
    
    @IBOutlet var viewInfosetProduct: UIView!
    @IBOutlet var viewKeyInfoProduct: UIView!
    
    var arrayProductKeyInfo = NSArray()
    var arrayProductInfoset = NSArray()
    var arrayProductDocuments = NSArray()
    var strTitleProduct = String()
    var productMoreId = NSString()
    var  docsArray = NSArray()
    var  keyInfoArray = NSArray()
    var  infoSetArray = NSArray()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tblProductInfo.separatorStyle = UITableViewCellSeparatorStyle.none
        self.title=strTitleProduct
        getProductMoreInfo()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ProductMoreInfoScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    func getProductMoreInfo()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataWithRequest( withAPIName: "product/more/" + (productMoreId as String)) {
                (response, permissions) in
                print(("",response))
                self.STOP_INDICATOR()
                if response != nil
                {
                    let docsArray : NSArray = response! .value(forKey: "docs") as! NSArray
                    self.docsArray=docsArray
                    let keyInfo : NSArray = response! .value(forKey: "keyInfo") as! NSArray
                    self.keyInfoArray=keyInfo
                    let infoSet : NSArray = response! .value(forKey: "infoSet") as! NSArray
                    self.infoSetArray=infoSet
                }
                self.tblProductInfo .reloadData()
            }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
            let cell1  = tableView.dequeueReusableCell(withIdentifier: "cell0") as! KeyInfocells
            if keyInfoArray.count==0
            {
                cell1.lblProductName.text="NA"
                cell1.lblProductType.text="NA"
            }
            else
            {
            let objData : NSDictionary = self.keyInfoArray[indexPath.row] as! NSDictionary
            if let name : String = objData.value(forKey: "keyInfoValue") as? String
            {
                cell1.lblProductName.text=name
            }
            if let lable : String = objData.value(forKey: "keyInfoLabel") as? String
            {
                cell1.lblProductType.text=lable
            }
            }
            return cell1
        }
        if indexPath.section == 1
        {
            let cell2  = tableView.dequeueReusableCell(withIdentifier: "cell1") as! InfoSetCells
            if infoSetArray.count==0
            {
                cell2.lblProductInfoName.text="NA"
                cell2.lblProductInfoDetails.text="NA"
            }
            else{
            let objData : NSDictionary = self.infoSetArray[indexPath.row] as! NSDictionary
            if let typeName : String = objData.value(forKey: "typeName") as? String
            {
                cell2.lblProductInfoName.text=typeName
            }
                if let detailsLbl : String = objData.value(forKey: "infoSetMoreLabel") as? String
                {
                    if detailsLbl == ""
                    {
                        cell2.lblProductInfoDetails.text="NA"
                    }
                    else{
                        cell2.lblProductInfoDetails.text=detailsLbl
                    }
                }
                if let detailsValue : String = objData.value(forKey: "infoSetMoreValue") as? String
                {
                    if detailsValue == ""
                    {
                        cell2.lblProductValueDetails.text="NA"
                    }
                    else{
                        cell2.lblProductValueDetails.text=detailsValue
                    }
                }
            }
            return cell2
        }
            
        else
        {
            let cell3  = tableView.dequeueReusableCell(withIdentifier: "cell2") as! DocumentCells
            if docsArray.count==0
            {
                cell3.lblProductDocumentName.text="NA"
            }
            else{
            let objData : NSDictionary = self.docsArray[indexPath.row] as! NSDictionary
            if let Docname : String = objData.value(forKey: "docName") as? String
            {
                cell3.lblProductDocumentName.text=Docname
            }
            }
            return cell3
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section) {
        case 0:
            return 40.0
        case 1:
            return 40.0
        case 2:
            return 40.0
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            if keyInfoArray.count==0
            {
                return 1
            }
            else{
            return keyInfoArray.count
            }
        case 1:
            if infoSetArray.count==0
            {
                return 1
            }
            else{
            return infoSetArray.count
            }
        case 2:
            if docsArray.count==0
            {
                return 1
            }
            else{
            return docsArray.count
            }
            
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 45.0
        }
        else if indexPath.section == 1
        {
            return 65.0
        }
        else
        {
            return 45.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        switch (section) {
        case 0:
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.contentView.addSubview(viewKeyInfoProduct)
        case 1:
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.contentView.addSubview(viewInfosetProduct)
        case 2:
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.contentView.addSubview(viewDocumentProduct)
        default:  break
        }
        
        
    }
}
