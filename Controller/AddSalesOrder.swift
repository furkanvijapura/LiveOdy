//
//  AddSalesOrder.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 8/17/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class AddSalesOrder: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {

    @IBOutlet var mainHeadreView: UIView!
    var pickOption = ["one", "two", "three", "seven", "fifteen"]

    
    let pickerView = UIPickerView()

    @IBOutlet var frameViewSet: UIView!
    @IBOutlet var lblLastOrder: UILabel!
    @IBOutlet var txtDate: UITextField!
    @IBOutlet var txtRate: UITextField!
    @IBOutlet var txtOrganizationName: UITextField!
    @IBOutlet var txtCompanyName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Add Sales Order"
        
        frameViewSet.backgroundColor=UIColor.red
        
//        let cellReuseIdentifier = "addHeadercell"
//        mainHeadreView.trailingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive=true
//        mainHeadreView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive=true
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self
        
        pickerView.delegate = self
        txtOrganizationName.inputView = pickerView
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(AddSalesOrder.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
    
    
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK:  Pickerview delegate and data sources..
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addHeadercell") as! AddSalesOrderHeaderCell
        cell.txtCompanyName.text = pickOption[row]
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AddSalesOrder.doneButtonActionAdd))
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "addHeadercell") as! AddSalesOrderHeaderCell

        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        
        cell.txtCompanyName.inputAccessoryView = doneToolbar
        
    }
    
    func doneButtonActionAdd()
    {
//        txtCompanyName.resignFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        mainHeadreView.frame=CGRect(x:self.tableView.frame.origin.x+20, y: 64, width:self.tableView.frame.size.width, height: 200)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "addHeadercell") as! AddSalesOrderHeaderCell
    
//        cell.mainHeaderView.frame=CGRect(x: self.tableView.frame.origin.x+5, y: 64, width: self.tableView.frame.size.width-5, height: 215)
//        print("My view size is====",cell.mainHeaderView.frame)
//        cell.mainHeaderView.layer.cornerRadius = 5.0
//        cell.mainHeaderView.layer.borderColor = UIColor.lightGray.cgColor
//        cell.mainHeaderView.layer.borderWidth = 0.1
//        cell.txtCompanyName.delegate = self
//        cell.txtOrganizationName.delegate = self
//        cell.txtDate.delegate = self 
//
        
//        cell.txtCompanyName.inputView = pickerView
//        self.addDoneButtonOnKeyboard()

            return frameViewSet
    }
    
     override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell") as! AddSalesOrderFooterCell
        
        cell.mainFooterView.layer.cornerRadius = 3.0
        cell.mainFooterView.layer.borderColor = UIColor.lightGray.cgColor
        cell.mainFooterView.layer.borderWidth = 0.1
        
        return cell
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        
        
        return 220
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat

    {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddSalesOrderCell
        
//        cell.viewBackData.backgroundColor = UIColor.white
//        cell.viewBackData.layer.cornerRadius = 5.0
//        cell.viewBackData.layer.borderColor = UIColor.gray.cgColor
//        cell.viewBackData.layer.borderWidth = 0.1
//        cell.viewBackData.layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
//        cell.viewBackData.layer.shadowOpacity = 1.0
//        cell.viewBackData.layer.shadowRadius = 5.0
//        cell.viewBackData.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)

        return cell
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
