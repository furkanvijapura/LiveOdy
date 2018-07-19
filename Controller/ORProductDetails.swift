//
//  ORProductDetails.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 27/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//
import UIKit
var arrFinalORProduct : NSMutableArray = NSMutableArray()
var arrParameter = NSMutableArray()

class ORProductDetails: UIViewController, UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ORProductDelegate
{
    var arrTest =  NSMutableArray()
    @IBOutlet weak var tblORproductDetail: UITableView!
    var arrBasicPrice : NSMutableArray = NSMutableArray()
    var arrSku : NSMutableArray = NSMutableArray()
    var arrMaserment : NSMutableArray = NSMutableArray()
    var arrSelectProduct : NSMutableArray = NSMutableArray()
    var arrCurrencySymbolDetails : NSMutableArray = NSMutableArray()
    var arrCategoryName : NSMutableArray = NSMutableArray()
    var arrProductList : NSMutableArray = NSMutableArray()
    var finalarrayTotal:NSMutableArray = []
    var visitId=NSNumber()
    var ProductQtyORUpdate = NSMutableArray()
    var ProductTotalPriceORUpdate = NSMutableArray()
    var ProductSymbolORUpdate = NSMutableArray()
    var arrCellTotalAmount = NSMutableArray()
    var booool = true
    @IBOutlet var lblTotalAmountCurrency: UILabel!
    var arrTotalAmount=[0]
    @IBOutlet weak var lblTotalQty: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "OR Product Details"
        setupKeyboardNotifcationListenerForScrollView(tblORproductDetail)
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ORProductDetails.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        arrParameter.removeAllObjects()
        //==========================
        for _ in 0..<ProductIDArray.count
        {
            arrInputValue.add("0")
            arrInputValueTotal.add("0")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductIDArray.count
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblORproductDetail.dequeueReusableCell(withIdentifier: "cell") as! ORProductCell
        cell.txtQty.setDoneOnKeyboard()
        
        let strQtyValue = arrInputValue.object(at: indexPath.row) as? String
        
        if strQtyValue == "0"
        {
            cell.txtQty.text = ""
        }
        else
        {
            cell.txtQty.text = strQtyValue
        }
        
        let strQtyValueTotal = arrInputValueTotal.object(at: indexPath.row) as? String
        if strQtyValueTotal == "0"
        {
            cell.txtFinalAmount.text = "0.0"
        }
        else
        {
            cell.txtFinalAmount.text = strQtyValueTotal
        }
        
        cell.delegate=self as ORProductDelegate
        cell.lblProductName.text = ProductNameArray[indexPath.row] as? String
        let strSku:String = ProductSkuArray[indexPath.row] as! String
        print(strSku)
        if strSku == ""
        {
            cell.lblSku.text="NA"
        }
        else{
            cell.lblSku.text = strSku
        }
        //  cell.lblMeasurment.text=arrMaserment[indexPath.row] as? String
        
        let strMesurement:String = ProductMeasermentNameArray[indexPath.row] as! String
        if strMesurement == ""
        {
            cell.lblMeasurment.text="NA"
        }
        else{
            cell.lblMeasurment.text = strMesurement
        }
        
        let straCategoryName:String = ProductCategoryNameArray[indexPath.row] as! String
        if straCategoryName==""
        {
            cell.lblCategoryName.text="NA"
        }
        else{
            cell.lblCategoryName.text = straCategoryName
        }
        print(straCategoryName)
        let rateValue  = ProductPriBpriArray[indexPath.row]
        cell.txtBasicPrice.text = String(describing: rateValue)
        cell.lblPricebookCurreny.text = (ProductCurrencyNameArray[indexPath.row] as! String)
        cell.lblTotalCurreny.text = (ProductCurrencyNameArray[indexPath.row] as! String)
        lblTotalAmountCurrency.text = (ProductCurrencyNameArray[indexPath.row] as! String)
        //        cell.txtQty.text=ProductQtyORUpdate[indexPath.row] as? String
        //        cell.lblTotalCurreny.text=ProductSymbolORUpdate[indexPath.row] as? String
        //        cell.txtFinalAmount.text = ProductTotalPriceORUpdate[indexPath.row] as? String
        return cell
    }
    func btnCloseTapped(cell:ORProductCell)
    {
        let indexPath001 = self.tblORproductDetail.indexPath(for: cell)
        self.arrSelectProduct.remove(indexPath001 as Any)
        self.arrSelectProduct.removeObject(at:(indexPath001?.row)!)
        tblORproductDetail.deleteRows(at:[indexPath001!], with: .left)
        // tblORproductDetail.reloadData()
        print(indexPath001!.row)
        finalarrayTotal.removeAllObjects()
        
        tblORproductDetail.reloadData()
    }
    
    func dismissKeyboard12()
    {
        //self.endEditing(true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133.0
    }
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        arrParameter.removeAllObjects()
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        arrParameter.removeAllObjects()
        if boolORUpdate == true
        {
            for i in 0..<ProductIDArray.count
            {
                let taxDic = NSMutableDictionary()
                taxDic.setValue(ProductPriBpriArray[i], forKey:"priceBookPrice")
                taxDic.setValue(arrInputValueTotal.object(at: i), forKey:"totalPrice")
                taxDic.setValue(arrInputValue.object(at: i), forKey:"quantity")
                taxDic.setValue(ProductIDArray[i], forKey:"proId")
                arrParameter.add(taxDic)
            }
            print(arrParameter)
            arrFinalORProduct = arrParameter
            //----
            arrEditFinalORProduct = arrFinalORProduct
            
            let strTotal1 = Float(lblTotalPrice.text!)!
            //lblTotalPrice.text=String(format: "%.2f",strTotal1)
            
            if ProductIDArray.count == 0
            {
                displayAlertMessage(messageToDisplay: "Please select AnyOne Product")
            }
            else
            {
                if strTotal1 == 0
                {
                    displayAlertMessage(messageToDisplay: "Please Add Some Quantity.")
                }
                else
                {
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier:"EditOR_SummeryTableViewController") as! EditOR_SummeryTableViewController
                    let strTotalQTY = Float(lblTotalQty.text!)!
                    strTotalAmount = String(format: "%.2f",strTotal1)
                    objReg.totalAmount = lblTotalPrice.text!
                    strTotalQTy = String(format: "%.2f",strTotalQTY)
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
            }
        }
        else{
            for i in 0..<ProductIDArray.count
            {
                let taxDic = NSMutableDictionary()
                taxDic.setValue(ProductPriBpriArray[i], forKey:"priceBookPrice")
                taxDic.setValue(arrInputValueTotal.object(at: i), forKey:"totalPrice")
                taxDic.setValue(arrInputValue.object(at: i), forKey:"quantity")
                taxDic.setValue(ProductIDArray[i], forKey:"proId")
                
                arrParameter.add(taxDic)
            }
            print(arrParameter)
            arrFinalORProduct = arrParameter
            
            let strTotal1 = Float(lblTotalPrice.text!)!
            
            if ProductIDArray.count == 0
            {
                displayAlertMessage(messageToDisplay: "Please select Any One Product")
            }
            else
            {
                
                if strTotal1 == 0
                {
                    displayAlertMessage(messageToDisplay: "Please Add Some Quantity.")
                }
                else
                {
                    strTotalAmount = String(format: "%.2f",strTotal1)
                    let strTotalQTY = Float(lblTotalQty.text!)!
                    strTotalQTyyy = String(format: "%.2f",strTotalQTY)
                    let objReg = self.storyboard?.instantiateViewController(withIdentifier:"OR_SummeryTableViewController") as! OR_SummeryTableViewController
                    objReg.visitId = visitId
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
            }
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //=================Calculation===========================
    @IBAction func btnCalculate(_ sender: UIButton)
    {
        booool = false
        print(arrSelectProduct.count)
        finalarrayTotal.removeAllObjects()
        tblORproductDetail.reloadData()
    }
    func sum(array:[Int]) -> Int {
        var sum = 0
        for num in array {
            sum += num
        }
        return sum
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        tblORproductDetail.contentOffset = CGPoint(x: 0, y: 0)
        let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to: self.tblORproductDetail)
        let indexPath = self.tblORproductDetail.indexPathForRow(at: buttonPosition)
        let cell = self.tblORproductDetail.cellForRow(at: indexPath!) as! ORProductCell
        
        //let strInputValueWithTag : String = String(format: "%d-%@",(indexPath?.row)!,cell.txtQty.text!)
        let strInputValueWithTag : String = String(format: "%@",cell.txtQty.text!)
        let strInputValueWithTagTotal : String = String(format: "%@",cell.txtFinalAmount.text!)
        arrInputValue.replaceObject(at: (indexPath?.row)!, with: strInputValueWithTag)
        arrInputValueTotal.replaceObject(at: (indexPath?.row)!, with: strInputValueWithTagTotal)
        print(arrInputValue)
        var TotalValue : String = ""
        var totValue : Double = 0.0
        for i in 0..<arrInputValueTotal.count
        {
            if arrInputValueTotal.object(at: i) as! String == ""
            {
                arrInputValueTotal.replaceObject(at: i, with: "0")
            }
            let value : Double = Double(arrInputValueTotal.object(at: i) as! String)!
            totValue = totValue + value
        }
        TotalValue = String(format : "%.2f",totValue)
        lblTotalPrice.text = TotalValue
        var TotalValueQty : String = ""
        var totValueQTy : Double = 0.0
        for i in 0..<arrInputValue.count
        {
            if arrInputValue.object(at: i) as! String == ""
            {
                arrInputValue.replaceObject(at: i, with: "0")
            }
            let valueQTy : Double = Double(arrInputValue.object(at: i) as! String)!
            totValueQTy = totValueQTy + valueQTy
        }
        TotalValueQty = String(format : "%.2f",totValueQTy)
        lblTotalQty.text = TotalValueQty
        booool = false
        print(arrTest)
        finalarrayTotal.removeAllObjects()
        tblORproductDetail.reloadData()
    }
    var arrInputValue = NSMutableArray()
    var arrInputValueTotal = NSMutableArray()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var txtAfterUpdate = string
        switch string {
        case "0","1","2","3","4","5","6","7","8","9","":
            
           
            if let text = textField.text as NSString?
            {
                txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                print(txtAfterUpdate)
            }
            let buttonPosition:CGPoint = textField.convert(CGPoint.zero, to: self.tblORproductDetail)
            let indexPath = self.tblORproductDetail.indexPathForRow(at: buttonPosition)
            let cell = self.tblORproductDetail.cellForRow(at: indexPath!) as! ORProductCell
            if textField == cell.txtQty
            {
                let rateValue1 = Float(cell.txtBasicPrice.text!)
                let priceValue1 = Float(txtAfterUpdate)
                if cell.txtBasicPrice.text==""
                {
                    cell.txtFinalAmount.text = nil
                }
                else{
                    if txtAfterUpdate==""
                    {
                        cell.txtFinalAmount.text = nil
                    }
                    else{
                        let strTotal1 = String(rateValue1! * priceValue1!)
                        cell.txtFinalAmount.text=strTotal1
                    }
                }
            }
            else
            {
                let rateValue1 = Float(cell.txtBasicPrice.text!)
                let priceValue1 = Float(txtAfterUpdate)
                if cell.txtBasicPrice.text==""
                {
                    cell.txtFinalAmount.text = nil
                }
                else{
                    if txtAfterUpdate==""
                    {
                        cell.txtFinalAmount.text = nil
                    }
                    else{
                        let strTotal1 = String(format : "%.2f",(rateValue1! * priceValue1!))
                        cell.txtFinalAmount.text=strTotal1
                    }
                }
            }
            return true;
        case ".":
            let array = Array(textField.text!)
            var decimalCount = 0
            for character in array {
                if character == "." {
                    decimalCount += 1
                }
            }
            if decimalCount == 1 {
                return false
            } else {
                return true
            }
        default:
            let array = Array(string)
            if array.count == 0 {
                return true
            }
            
        }
        return false
    }
}


