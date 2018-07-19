//
//  ProductFilterScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 21/05/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit
class ProductFilterScreen: UIViewController,UIPickerViewDelegate
{
    @IBOutlet var viewStatus: UIView!
    var status = ["Enabled","Disabled"]
    var contactarrayData = NSArray()
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    let pickerView = UIPickerView()
    @IBOutlet weak var txtStatus: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Filter"
      //  btnCancel.isHidden=true
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ProductFilterScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        txtStatus.inputView = pickerView
        txtStatus.setDoneOnKeyboard()
        pickerView.delegate = self
        txtStatus.rightViewMode = .always
        txtStatus.rightView = UIImageView(image: UIImage(named: "down_dark_arrow"))
        viewStatus.SetViewShadow()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnContactsTapped(_ sender: Any) {
    }
    func getProductFilter()
    {
        //  INDISTART()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
            //objDic .setValue("5", forKey:"filterType")
            if txtStatus.text == "Enabled"
            {
                objDic .setValue("1", forKey:"filterStatus")
            }
            else if txtStatus.text == "Disabled"
            {
                objDic .setValue("2", forKey:"filterStatus")
            }
        START_INDICATOR()
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "product/getAllMinifiedProducts") { (response, isVisit)
            in
            //print(("Response is......",response))
            // self.contactarrayData=response!
            //FilterDicArry = self.contactarrayData
            self.STOP_INDICATOR()
            if response != nil
            {
                DicDataProductList = (response)!
                print("FilterDicArry.count=",DicDataProductList.count)
                // let initialDataAryFilter:[FIlterModel] = FIlterModel.generateModelFilterArray()
                // var dataAryFilter:[FIlterModel] = FIlterModel.generateModelFilterArray()
                
                //  self.INDISTOP()
            }
            //  self.INDISTOP()
            let objReg=self.storyboard?.instantiateViewController(withIdentifier:"ProductListScreen") as! ProductListScreen
            objReg.isFilterProduct=true
            self.navigationController?.pushViewController(objReg, animated: true)
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        getProductFilter()
    }
    
    // MARK: UiPickerview delegates here:
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if txtStatus.isEditing
        {
            return status.count
        }
        return status.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         if txtStatus.isEditing
        {
            return status[row]
        }
        return status[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
         if txtStatus.isEditing
        {
            txtStatus.text = status[row]
        }
        //        txtPersonName.text = pickOption[row]
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
