//
//  EditProductPrimaryDetailController.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 11/10/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
var QuantityArray  = NSMutableArray()
var AmountArray  = NSMutableArray()

class EditProductPrimaryDetailController: UIViewController,UITextFieldDelegate {

    @IBOutlet var txtPrice: RoundTextField!
    @IBOutlet var txtDiscount: RoundTextField!
    @IBOutlet var txtCart: RoundTextField!
    @IBOutlet var txtPriceBook: RoundTextField!
    @IBOutlet var txtAmount: RoundTextField!
    @IBOutlet var txtSKu: RoundTextField!
    
    var ProductName = NSMutableArray()
    var skuName = NSMutableArray()

    var DiscountArray      = NSMutableArray()
    var PriceBookArray     = NSMutableArray()
    var PriceArray     = NSMutableArray()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(EditProductPrimaryDetailController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        txtSKu.text = "\(skuName[0])"
        
        txtAmount.text   = "\(AmountArray[0])"
        txtCart.text   = "\(QuantityArray[0])"

        txtPriceBook.text         = "\(PriceBookArray[0])"
        txtDiscount.text     = "\(DiscountArray[0])"
        txtPrice.text     = "\(PriceArray[0])"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSaveTapped(_ sender: Any) {
        
        print(arrParameterPrimaryMain[Extradata])
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).removeObject(forKey: "basicPrice")
        print(arrParameterPrimaryMain)
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).setValue((txtAmount.text!), forKey: "basicPrice")
        print(arrParameterPrimaryMain)
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).removeObject(forKey: "quantity")
        print(arrParameterPrimaryMain)
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).setValue((txtCart.text!), forKey: "quantity")
        print(arrParameterPrimaryMain)
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).removeObject(forKey: "discountAmount")
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).setValue((txtDiscount.text!), forKey: "discountAmount")
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).removeObject(forKey: "productTotal")
        (arrParameterPrimaryMain[ExtraPrimarydata] as! NSMutableDictionary).setValue((txtPrice.text!), forKey: "productTotal")
        print(arrParameterPrimaryMain)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        var txtAfterUpdate = string
        if let text = textField.text as NSString?
        {
            txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            
            print(txtAfterUpdate)
        }
        if textField == txtAmount
        {
            let rateValue = Float(txtPriceBook.text!)
            let priceValue = Float(txtAfterUpdate)
            if txtAfterUpdate==""
            {
                //                let strTotal = String(format : "%d",(rateValue! - priceValue!))
//                cell.txtDiscountPercent.text = nil
            }
            else{
                let strTotal = String(format : "%.2f",(rateValue! - priceValue!))
                txtDiscount.text = strTotal
            }
        }
        else
        {
            let rateValue1 = Float(txtAmount.text!)
            let priceValue1 = Float(txtAfterUpdate)
            if txtAmount.text==""
            {
                txtPrice.text = nil
            }
            else{
                if txtAfterUpdate==""
                {
                    txtPrice.text = nil
                }
                else{
                    let strTotal1 = String(format : "%.2f",(rateValue1! * priceValue1!))
                   txtPrice.text = strTotal1
                }
            }
        }
        
        return true;
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
