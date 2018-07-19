//
//  EditAllSalesOrderScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 26/08/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class EditAllSalesOrderScreen: UITableViewController,UITextFieldDelegate,MyCellPrimaryDelegate{

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtProductName: RoundTextField!
    @IBOutlet weak var txtNotifyCount: RoundTextField!
    @IBOutlet weak var txtTotalPrice: RoundTextField!
    @IBOutlet weak var txtPrice: RoundTextField!
    @IBOutlet weak var txtRateBook: RoundTextField!
    @IBOutlet weak var txtDiscountPercent: RoundTextField!
    var Id=NSNumber()
    @IBOutlet weak var footerView: UIView!
    var arrGetProduct : NSMutableArray = NSMutableArray()
    var arrGetBasicPrice : NSMutableArray = NSMutableArray()
    var arrProductId : NSMutableArray = NSMutableArray()
    var arrIdNumber : NSMutableArray = NSMutableArray()

    var arrParameter = NSMutableArray()

    
    var RateArray      = [150,100,200]
    var ItemArray      = [1,2,3,4,5]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        addDoneButtonOnKeyboard()
        self.title="Add Sales Order"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(EditAllSalesOrderScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        footerView.backgroundColor = UIColor.white
       footerView.layer.cornerRadius = 5.0
        footerView.layer.borderColor = UIColor.black.cgColor
        footerView.layer.borderWidth = 0.1
        footerView.layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
        footerView.layer.shadowOpacity = 1.0
        footerView.layer.shadowRadius = 5.0
       footerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        print("Data is====",arrGetProduct)
        print("Price is====",arrGetBasicPrice)
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    @IBAction func btnCancelTapped(_ sender: Any) {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain") as! EditAddSalesClass
//        print(cell.txtPrice.text)
        _ = navigationController?.popViewController(animated: true)

    }
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "AddSalesController") as! AddSalesController

        for i in 0..<arrGetProduct.count
        {
            let indexpath = IndexPath(row: i, section: 0)
            let cell = self.tableView.cellForRow(at: indexpath) as! EditAddSalesClass
            let taxDic = NSMutableDictionary()
            taxDic.setValue(cell.txtRateBook.text, forKey:"priceBookPrice")
            taxDic.setValue(cell.txtPrice.text, forKey:"basicPrice")
            taxDic.setValue(cell.txtNotifyCount.text, forKey:"quantity")
            taxDic.setValue(cell.txtDiscountPercent.text, forKey:"discountAmount")
            taxDic.setValue(cell.txtTotalPrice.text, forKey:"productTotal")
            taxDic.setValue(arrIdNumber[indexpath.row], forKey:"id")
            taxDic.setValue(arrProductId[indexpath.row], forKey:"productId")
            if cell.txtTotalPrice.text==""
            {
                
            }
            else{
            objReg.arrNoSEC.append(Int(Float(cell.txtTotalPrice.text!)!))
            }

            //objReg.arrNoSEC.append(Int(Float(cell.txtTotalPrice.text!)!))
            print(objReg.arrNoSEC)
            taxDic.setValue("0", forKey:"tax")
            arrParameter.add(taxDic)
        }
        print(arrParameter)
        arrParameterPrimaryMain = arrParameter
        objReg.arrGetSalesProduct = arrGetProduct
        objReg.arrGetPriceBook=arrGetBasicPrice
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrGetProduct.count
    }
  override  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain", for: indexPath) as! EditAddSalesClass
//        cell.txtPrice.inputAccessoryView=doneToolbar
//        cell.txtNotifyCount.inputAccessoryView=doneToolbar
        cell.txtPrice.setDoneOnKeyboard()
        cell.txtNotifyCount.setDoneOnKeyboard()

//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(EditAllSalesOrderScreen.doneButtonAction))
//        let items = NSMutableArray()
//        items.add(flexSpace)
//        items.add(done)

        cell.txtProductName.text=arrGetProduct[indexPath.row] as? String
        cell.delegate=self as? MyCellPrimaryDelegate

        let rateValue: NSNumber = (arrGetBasicPrice[indexPath.row] as! NSNumber)
        cell.txtRateBook.text = String(format : "%.2f",rateValue.floatValue)
        cell.mainView.backgroundColor = UIColor.white
        cell.mainView.layer.cornerRadius = 5.0
        cell.mainView.layer.borderColor = UIColor.gray.cgColor
        cell.mainView.layer.borderWidth = 0.1
        cell.mainView.layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
        cell.mainView.layer.shadowOpacity = 1.0
        cell.mainView.layer.shadowRadius = 5.0
        cell.mainView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//===================
//        cell.txtPrice.text = String(RateArray[indexPath.row])
//        cell.txtNotifyCount.text = String(ItemArray[indexPath.row])
//        cell.txtTotalPrice.text = String(Int(cell.txtPrice.text!)! * Int(cell.txtNotifyCount.text!)!)
//        cell.txtDiscountPercent.text = String(Int(cell.txtRateBook.text!)! - Int(cell.txtPrice.text!)!)

            return cell
    }
    
    
//=============§for delete row=================
    func btnCloseTapped(cell:EditAddSalesClass)
    {
        //Get the indexpath of cell where button was tapped
        //        let cell33 = tableView.dequeueReusableCell(withIdentifier: "cell") as! EditAllSecondarySalesOrderCell
        let indexPath001 = self.tableView.indexPath(for: cell)
        self.arrGetProduct.remove(indexPath001 as Any)
        self.arrGetProduct.removeObject(at:(indexPath001?.row)!)
//        self.arrSku.removeObject(at:(indexPath001?.row)!)
        
        tableView.deleteRows(at:[indexPath001!], with: .left)
        //UITableViewCell.transition(with: cell33,duration: 0.60, animations:{ self.tableView.reloadData() })
        tableView.reloadData()
        print(indexPath001!.row)
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return footerView
    }
     override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat

    {
        return 50
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain") as! EditAddSalesClass
//          addDoneButtonOnKeyboard()
////        cell.txtPrice.inputAccessoryView=doneToolbar
//        cell.txtPrice.inputView=doneToolbar
//        cell.txtNotifyCount.inputView = doneToolbar

        if cell.txtPrice .isEditing
        {
//            cell.txtPrice.inputAccessoryView = doneToolbar
//            cell.txtNotifyCount.inputAccessoryView = doneToolbar
//            cell.txtPrice.keyboardType = UIKeyboardType.default

        }
        print(cell.txtPrice.text)

     }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var txtAfterUpdate = string
        if let text = textField.text as NSString?
        {
            txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            print(txtAfterUpdate)
        }
        
        let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        let cell = self.tableView.cellForRow(at: indexPath!) as! EditAddSalesClass
        if textField == cell.txtPrice
        {
            let rateValue = Float(cell.txtRateBook.text!)
            let priceValue = Float(txtAfterUpdate)
            if txtAfterUpdate==""
            {
//                let strTotal = String(format : "%d",(rateValue! - priceValue!))
                cell.txtDiscountPercent.text = nil
            }
            else{
            let strTotal = String(format : "%.2f",(rateValue! - priceValue!))
                cell.txtDiscountPercent.text = strTotal
            }
        }
        else
        {
            let rateValue1 = Float(cell.txtPrice.text!)
            let priceValue1 = Float(txtAfterUpdate)
            if cell.txtPrice.text==""
            {
                cell.txtTotalPrice.text = nil
            }
            else{
                if txtAfterUpdate==""
                {
                    cell.txtTotalPrice.text = nil
                }
                else{
                    let strTotal1 = String(format : "%.2f",(rateValue1! * priceValue1!))
                    cell.txtTotalPrice.text = strTotal1
                }
            }
        }
        
        return true;
    }
    var doneToolbar = UIToolbar()
    func addDoneButtonOnKeyboard()
    {
        doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(EditAllSalesOrderScreen.doneButtonAction))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
    }
    func doneButtonAction()
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain") as! EditAddSalesClass
        cell.txtPrice.resignFirstResponder()
        cell.txtNotifyCount.resignFirstResponder()
    }
    func RateItem() -> Double
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain") as! EditAddSalesClass
        let Rate : Double = Double(cell.txtPrice.text!)!
        let Item : Double = Double(cell.txtNotifyCount.text!)!
        return Rate * Item
    }
    func discount()-> String
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMain") as! EditAddSalesClass
        let MaintAmoutn:int_fast64_t = int_fast64_t(cell.txtRateBook.text!)!
        let Rate       :int_fast64_t = int_fast64_t(cell.txtPrice.text!)!
        
        return String(MaintAmoutn - Rate)
        
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


