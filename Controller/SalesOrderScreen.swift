//
//  SalesOrderScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 8/8/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class SalesOrderScreen: UITableViewController {
    
    var optionsMenu: CAPSOptionsMenu?
    
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    let dateFormatter = DateFormatter()
    let dateFormatter1 = DateFormatter()
    var distancestring = NSString()
    var strMonthStart = NSString()
    var arrayAllSalesData = NSArray()
    var productArray = NSArray()
    var myStringafd = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.title="Sales Order"

        //setNavigationBarItem()
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(SalesOrderScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        
//        let components = calendar.components([.Year, .Month], fromDate: date)
//        let startOfMonth = calendar.dateFromComponents(components)!
//        print(dateFormatter.stringFromDate(startOfMonth)
        
        let calendar = Calendar.current
        let minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        let minDate = calendar.date(from: minDateComponent)
        datePicker.minimumDate = minDate
        print(" min date : \(String(describing: minDate))")
        dateFormatter.dateFormat = "dd MM yyyy hh:mm"
        let date = dateFormatter.date(from: dateFormatter.string(from: datePicker.date))
        let nowDouble = date!.timeIntervalSince1970
        let valuee = String(nowDouble*100)
        let string = valuee
        let badchar = CharacterSet(charactersIn: "\".")
        distancestring = string.components(separatedBy: badchar).joined() as NSString
        print(distancestring)
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date!)
        let startOfMonth = Calendar.current.date(from: comp)!
        print(dateFormatter1.string(from: startOfMonth))

//        strMonthStart =  dateFormatter1.string(from: startOfMonth) as NSString
//        datePicker1.minimumDate = startOfMonth
//        dateFormatter1.dateFormat = "dd MM yyyy hh:mm"
//        let date1 = dateFormatter1.date(from: dateFormatter1.string(from: datePicker1.date))
//        print(strMonthStart)
        
        let nowDouble1 = startOfMonth.timeIntervalSince1970
        let valuee1 = String(nowDouble1*100)
        let string1 = valuee1
        let badchar1 = CharacterSet(charactersIn: "\".")
        strMonthStart = string1.components(separatedBy: badchar1).joined() as NSString
        print(strMonthStart)

      //  getAllSalesVisit()
        self.addOptionsMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- For Function method here.........
    func getAllSalesVisit()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(strMonthStart, forKey:"fromDate")
        objDic .setValue(distancestring, forKey:"toDate")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "saleOrder/salesOrderList/") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            self.arrayAllSalesData=response!
            self.tableView .reloadData()
        }
    }
    
    func startOfMonth() -> Date
    {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self.startOfMonth())))!
    }
    
    func endOfMonth() -> Date
    {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    func didTapSearchButton(sender: AnyObject)
    {
    }
    func addOptionsMenu()
    {
//        let optionButton = UIBarButtonItem(image: #imageLiteral(resourceName: "option_menu"), landscapeImagePhone: #imageLiteral(resourceName: "option_menu"), style: UIBarButtonItemStyle.plain, target: self, action:nil)
        
        
//         let navigationButton = UIBarButtonItem(image: #imageLiteral(resourceName: "option_menu"), landscapeImagePhone: #imageLiteral(resourceName: "option_menu"), style: UIBarButtonItemStyle.plain, target: self, action:nil)
        
//        self.navigationItem.rightBarButtonItem = optionButton
//        self.navigationItem.rightBarButtonItem = navigationButton
        
        
        //=================================================================
        let editImage   = UIImage(named: "option_menu")!
                let searchImage = UIImage(named: "notification_bell")!
        
        
                let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: nil)
        
                let searchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(didTapSearchButton))
        
//                navigationItem.rightBarButtonItems = [editButton, searchButton]
       
        //===================================================================
        optionsMenu = CAPSOptionsMenu(viewController: self, barButtonItem: editButton, keepBarButtonAtEdge: true)
        
        optionsMenu?.menuActionButtonsHighlightedColor(UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0))
        optionsMenu?.menuCornerRadius(2.0)
        
        let menuAction1: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Search")
        { (action: CAPSOptionsMenuAction) -> Void in
            print("Tapped Action Button 1")
        }
        
        // menuAction1.image = UIImage(named: "ic_audio_24x24")
        // menuAction1.image = UIImage(named: "more")
        
        optionsMenu?.addAction(menuAction1)
        
        let menuAction2: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Sync All")
        { (action: CAPSOptionsMenuAction) -> Void in
            print("Tapped Action Button 2")
        }
        optionsMenu?.addAction(menuAction2)
        
        let menuAction3: CAPSOptionsMenuAction = CAPSOptionsMenuAction(title: "Filter")
        { (action: CAPSOptionsMenuAction) -> Void in
            print("Tapped Action Button 3")
        }
        optionsMenu?.addAction(menuAction3)
    }
    
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
//        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "MainViewScreen") as? MainViewScreen
//        let navBar = UINavigationController(rootViewController: destination1!)
//        self.present(navBar, animated: false, completion: nil)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayAllSalesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! SalesOrderCell
        let objData : NSDictionary = self.arrayAllSalesData[indexPath.row] as! NSDictionary
        if let salesOrgName : String = objData.value(forKey: "organizationName") as? String
        {
            cell.lblOrgName.text=salesOrgName
        }
        if let salesOrgName : String = objData.value(forKey: "fromOrgName") as? String
        {
            cell.lblRetailerName.text=salesOrgName
        }
        if let salesOrgName : String = objData.value(forKey: "updatedBy") as? String
        {
            cell.lblUpdatedByName.setTitle(salesOrgName, for: UIControlState.normal)
        }
        if let salesOrgName : NSNumber = objData.value(forKey: "total") as? NSNumber
        {
            cell.btnTotalPrice.setTitle(salesOrgName.stringValue, for: UIControlState.normal)

//            if salesOrgName==0
//            {
//                cell.btnTotalPrice.isHidden=true
//            }
//            else{
//                cell.btnTotalPrice.isHidden=false
//
//            cell.btnTotalPrice.setTitle(salesOrgName.stringValue, for: UIControlState.normal)
//            }
        }
        if let salesOrgName : String = objData.value(forKey: "saleOrderNumber") as? String
        {
            cell.btnSalesNumber.setTitle(salesOrgName, for: UIControlState.normal)
        }
        if let salesOrgName : NSNumber = objData.value(forKey: "saleDate") as? NSNumber
        {
            let dateVisitStr : Double = (salesOrgName as AnyObject).doubleValue
            let date1 = Date(timeIntervalSince1970: (dateVisitStr / 1000.0) )
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
             myStringafd = formatter.string(from: date1)
            cell.btnSalesDate.setTitle(myStringafd, for: UIControlState.normal)
        }
        if let salesOrgName : NSArray = objData.value(forKey: "productList") as? NSArray
        {
            if  salesOrgName.count == 0
            {
                cell.btnProductDetails.setTitle("" , for: UIControlState.normal)

            }
          else if salesOrgName.count==1 {
                
                cell.btnProductDetails.setTitle((salesOrgName.object(at: 0) as? String) , for: UIControlState.normal)
            }
            else  if salesOrgName.count==2 {
                
                cell.btnProductDetails.setTitle((salesOrgName.object(at: 0) as? String)!  +  " +1 " , for: UIControlState.normal)
            }
            else if salesOrgName.count==3 {
                
                cell.btnProductDetails.setTitle((salesOrgName.object(at: 0) as? String)!  +  " +2 " , for: UIControlState.normal)
            }
            else if salesOrgName.count==4 {
                
                cell.btnProductDetails.setTitle((salesOrgName.object(at: 0) as? String)!  +  " +3 " , for: UIControlState.normal)
            }
            else if salesOrgName.count==5 {
                
                cell.btnProductDetails.setTitle((salesOrgName.object(at: 0) as? String)!  +  " +4 " , for: UIControlState.normal)
            }
            else{
                cell.btnProductDetails.setTitle((salesOrgName.object(at: 0) as? String)!  +  " +5 ", for: UIControlState.normal)
            }
        }

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let objData : NSDictionary = self.arrayAllSalesData[indexPath.row] as! NSDictionary
         if let salesOrgName : String = objData.value(forKey: "salesType") as? String
         {
            if salesOrgName == "Primary"
            {
                let objReg=self.storyboard?.instantiateViewController(withIdentifier:"MainSalesOrderSummaryScreen") as! MainSalesOrderSummaryScreen
                if let salesOrgName : String = objData.value(forKey: "organizationName") as? String
                {
                    objReg.strCompanyName=salesOrgName as NSString
                }
                if let salesOrgName : String = objData.value(forKey: "fromOrgName") as? String
                {
                    objReg.strorgName=salesOrgName as NSString
                }
                if let salesOrgName : String = objData.value(forKey: "updatedBy") as? String
                {
                    objReg.strUpdateBy=salesOrgName as NSString
                }
//                if let salesOrgName : String = objData.value(forKey: "saleDate") as? String
//                {
                print(myStringafd)
//                objReg.strSalesDate = myStringafd as NSString
//                          objReg.strSalesDate=salesOrgName as NSString
//                }
                
                if let salesOrgName : NSNumber = objData.value(forKey: "saleDate") as? NSNumber
                {
                    let dateVisitStr : Double = (salesOrgName as AnyObject).doubleValue
                    let date1 = Date(timeIntervalSince1970: (dateVisitStr / 1000.0) )
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMM yyyy"
                    myStringafd = formatter.string(from: date1)
                  objReg.strSalesDate = myStringafd as NSString
                }
                if let salesOrgName : String = objData.value(forKey: "saleOrderNumber") as? String
                {
                    objReg.strSalesOrderNumber=salesOrgName as NSString
                }
                if let salesOrgName : NSNumber = objData.value(forKey: "total") as? NSNumber
                {
                    objReg.strProductPrice=salesOrgName.stringValue as NSString
                }
                if let salesOrgName : NSNumber = objData.value(forKey: "totalWithoutTax") as? NSNumber
                {
                    objReg.strTotalPrice=salesOrgName.stringValue as NSString
                }
                if let salesOrgName : NSNumber = objData.value(forKey: "id") as? NSNumber
                {
                    objReg.strID = salesOrgName.stringValue as NSString
                }
                
                if let salesOrgName : String = objData.value(forKey: "salesType") as? String
                {
                    objReg.strSalesType=salesOrgName as NSString
                }
                objReg.isVisitSide=false
                self.navigationController?.pushViewController(objReg, animated: true)

            }
            else{
                let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SecondarySalesOrderSummaryScreen") as! SecondarySalesOrderSummaryScreen
                if let salesOrgName : String = objData.value(forKey: "organizationName") as? String
                {
                    objReg.strCompanyName=salesOrgName as NSString
                }
                if let salesOrgName : String = objData.value(forKey: "fromOrgName") as? String
                {
                    objReg.strorgName=salesOrgName as NSString
                }
                if let salesOrgName : String = objData.value(forKey: "updatedBy") as? String
                {
                    objReg.strUpdateBy=salesOrgName as NSString
                }
//                    if let salesOrgName : String = objData.value(forKey: "saleDate") as? String
//                print(myStringafd)
////                    {
//                objReg.strSalesDate=myStringafd as NSString
//                objReg.strSalesDate=salesOrgName as NSString
//                }
                
                
                if let salesOrgName : NSNumber = objData.value(forKey: "saleDate") as? NSNumber
                {
                    let dateVisitStr : Double = (salesOrgName as AnyObject).doubleValue
                    let date1 = Date(timeIntervalSince1970: (dateVisitStr / 1000.0) )
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMM yyyy"
                    myStringafd = formatter.string(from: date1)
                    objReg.strSalesDate = myStringafd as NSString
                }
                if let salesOrgName : String = objData.value(forKey: "saleOrderNumber") as? String
                {
                    objReg.strSalesOrderNumber=salesOrgName as NSString
                }
                if let salesOrgName : NSNumber = objData.value(forKey: "total") as? NSNumber
                {
                    objReg.strProductPrice=salesOrgName.stringValue as NSString
                }
                if let salesOrgName : NSNumber = objData.value(forKey: "totalWithoutTax") as? NSNumber
                {
                    objReg.strTotalPrice=salesOrgName.stringValue as NSString
                }
                if let salesOrgName : NSNumber = objData.value(forKey: "id") as? NSNumber
                {
                    objReg.strID = salesOrgName.stringValue as NSString
                }
                if let salesOrgName : String = objData.value(forKey: "salesType") as? String
                {
                    objReg.strSalesType=salesOrgName as NSString
                }
                objReg.isVisitSide=false
                self.navigationController?.pushViewController(objReg, animated: true)
            }
        }

        
//        let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SalesOrderSummaryScreen") as! SalesOrderSummaryScreen
//        self.navigationController?.pushViewController(objReg, animated: true)

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
