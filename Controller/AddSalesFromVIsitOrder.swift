//
//  AddSalesFromVIsitOrder.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 22/08/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class AddSalesFromVIsitOrder: UITableViewController,UIPickerViewDelegate {
    
    
    @IBOutlet var lblLastOrderNO: UILabel!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var txtPricebookSelect: UITextField!
    @IBOutlet var txtDateSelect: UITextField!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var txtPersonName: UITextField!
    @IBOutlet var lblPerson: UILabel!
    @IBOutlet var txtOrganizationName: UITextField!
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet var lblSalesTypeChannel: UILabel!
    var strChennelName = NSString()
    
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var strId=NSNumber()
    var arrayByerList = NSArray()
    var arrayLastOrder = NSArray()

    var arrayPricebookList = NSArray()
    var strSallerName = NSString()
    var StrOrgId=NSString()
    var strSallerId = NSString()
    var strProductId = NSString()

      var strValueType = NSString()
    var strChannelType = NSString()
    var isChannelType = Bool()

//    var Saller = ["one", "two", "three", "seven", "fifteen"]
//    var Buyer = ["Discus", "IT", "PVT", "LTD", "Company"]
//    var Pricebook = ["1000", "15000", "2000", "2500", "3000"]

    @IBOutlet weak var btnCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="Add Sales Order"
        
        pickerView.delegate = self
        txtOrganizationName.inputView = pickerView
        txtPersonName.inputView = pickerView
        txtDateSelect.inputView=datePicker
        txtPricebookSelect.inputView=pickerView
        lblSalesTypeChannel.text = strChennelName as String
        if isChannelType==true
        {
        getbyerDetails()
        }
        else{
            getSallerSecondaryDetails()

        }
        getPriceBookDetails()
        getLastSalesOredrNo()
        txtOrganizationName.text=strSallerName as String
        print(strId)
        StrOrgId=strId.stringValue as NSString
        
//        lblSalesTypeChannel.text=strChannelType as String

        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(AddSalesFromVIsitOrder.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        
        let calendar = Calendar.current
        let minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        let minDate = calendar.date(from: minDateComponent)
        datePicker.minimumDate = minDate
        
        datePicker.datePickerMode = .date
        //        timePIcker.datePickerMode = .time
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        //        TimeFormatter.dateFormat = "hh:mm"
        txtDateSelect.text = dateFormatter.string(from: datePicker.date)
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        self.addDoneButtonOnKeyboard()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    func getbyerDetails()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("organizationForToSO", forKey:"value")
        objDic .setValue("1", forKey:"type")
        objDic .setValue(strId, forKey:"id")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "data/") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            self.arrayByerList=response!
            //            self.tableView .reloadData()
        }
    }
    func getSallerSecondaryDetails()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue("allRetailerListByDistId", forKey:"value")
        objDic .setValue(strId, forKey:"id")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "data/") { (response, isVisit)
            in
            self.STOP_INDICATOR()
            print(("Response is......",response))
            self.arrayByerList=response!
            print(self.arrayByerList)
            //            self.tableView .reloadData()
        }
    }
    func getPriceBookDetails()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(strId, forKey:"id")
        objDic .setValue("organizationPriceBook", forKey:"value")

        APISession.postDataWithRequestwithToken(objDic, withAPIName: "data/") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            self.arrayPricebookList=response!
            //            self.tableView .reloadData()
        }
    }
    func getLastSalesOredrNo()
    {
        APISession.getDataWithRequestWithToken( withAPIName: "saleOrder/lastOrderNumber") {
            (response, permissions) in
            self.STOP_INDICATOR()
            print(("",response))
            let OrgName:NSArray=(response as AnyObject).value(forKey: "value") as! NSArray
            let strLastOrderNo:NSString = (OrgName.object(at: 0) as? NSString)!
            self.lblLastOrderNO.text = "Last Order:" + " " + (strLastOrderNo as String)
        }
    }
    func getSalesType()
    {
        START_INDICATOR()
        APISession.getSalesTypeChannel( withAPIName: "organization/getSalesTypeCategory/", strOrgId: (StrOrgId as (String)) as (String), strUserId: "/" + (strSallerId as String) as (String)) {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
//          if
            self.strValueType = ((response as AnyObject).value(forKey: "value") as? NSString)!
//          {
            print(self.strValueType)
//            self.lblSalesTypeChannel.text = "Channel type: " + (self.strValueType as String) as String
//            }
//          else if self.strValueType == ((response as AnyObject).value(forKey: "message") as? NSString)!
//          {
//            self.lblSalesTypeChannel.text = "Channel type: " + (self.strValueType as String) as String
//            
//            }
        }
    }
    func getPrimaryProductList()
    {
    }
    @IBAction func btnProductAddTapped(_ sender: Any)
    {
        UserDefaults.standard.setValue(txtOrganizationName.text, forKey: "salesOrgName")
        UserDefaults.standard.setValue(txtPersonName.text, forKey: "salesBuyerName")
        UserDefaults.standard.setValue(lblSalesTypeChannel.text, forKey: "salesChannelType")
        UserDefaults.standard.setValue(txtPricebookSelect.text, forKey: "salesPriceBook")
        UserDefaults.standard.setValue(txtDateSelect.text, forKey: "salesOrderdate")
//        print(<#T##items: Any...##Any#>)
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailsScreen") as! SearchDetailsScreen
        objReg.Id=strId
        objReg.addProductActive=false
        if isChannelType==true
        {
            objReg.isTypeChannel = true
        }
        else{
            objReg.isTypeChannel = false

        }
       objReg.strSecondaryProuctId = strSallerId
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if txtPersonName.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select saller name....")
        }
        else{
            displayAlertMessage(messageToDisplay: "Please select products first....")
        }
    }
    func handleDatePicker(sender: UIDatePicker) {
        
        txtDateSelect.text = dateFormatter.string(from: datePicker.date)

    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AddVisitScreen.doneButtonActionAdd))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        self.txtOrganizationName.inputAccessoryView = doneToolbar
        self.txtPersonName.inputAccessoryView = doneToolbar
        self.txtDateSelect.inputAccessoryView=doneToolbar
        self.txtPricebookSelect.inputAccessoryView=doneToolbar
        
    }
    
    func doneButtonActionAdd()
    {
        self.txtPersonName.resignFirstResponder()
        self.txtOrganizationName.resignFirstResponder()
        self.txtDateSelect.resignFirstResponder()
        self.txtPricebookSelect.resignFirstResponder()
//        getSalesType()
    }
    // MARK: UiPickerview delegates here:
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
         if txtPersonName.isEditing
        {
            return arrayByerList.count
        }
        else if txtPricebookSelect.isEditing
        {
            return arrayPricebookList.count
        }
        return arrayPricebookList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
         if txtPersonName.isEditing
        {
            let orgName:NSArray=(self.arrayByerList as AnyObject).value(forKey: "value") as! NSArray
            let strOrganization:String = (orgName[row] as? String)!

            return strOrganization
        }
        else if txtPricebookSelect.isEditing
        {
            let orgName:NSArray=(self.arrayPricebookList as AnyObject).value(forKey: "value") as! NSArray
            let strPriceBook:String = (orgName[row] as? String)!
            
            return strPriceBook
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
    if txtPersonName.isEditing
        {
            let orgName:NSArray=(self.arrayByerList as AnyObject).value(forKey: "value") as! NSArray
            let strOrganization:String = (orgName[row] as? String)!
            txtPersonName.text = strOrganization
            
            let sallerId:NSArray=(self.arrayByerList as AnyObject).value(forKey: "id") as! NSArray
            let idNumber:NSNumber =  (sallerId[row] as? NSNumber)! as NSNumber
            strSallerId = idNumber.stringValue as NSString
            UserDefaults.standard.setValue(strSallerId, forKey: "sallerId")
            UserDefaults.standard.setValue(StrOrgId, forKey: "buyerId")


        }
        else if txtPricebookSelect.isEditing
        {
            let orgName:NSArray=(self.arrayPricebookList as AnyObject).value(forKey: "value") as! NSArray
            let strPriceBook:String = (orgName[row] as? String)!
            txtPricebookSelect.text = strPriceBook
            
            
            let productId:NSArray=(self.arrayPricebookList as AnyObject).value(forKey: "id") as! NSArray
            let productNu:NSNumber =  (productId[row] as? NSNumber)! as NSNumber
            strProductId = productNu.stringValue as NSString
            UserDefaults.standard.setValue(strProductId, forKey: "ProductId")
        }
        
        
        //        txtPersonName.text = pickOption[row]
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
