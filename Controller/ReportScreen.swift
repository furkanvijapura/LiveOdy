//
//  ReportScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 06/09/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class ReportScreen: UIViewController {
    @IBOutlet weak var txtFromDate: HoshiTextField!
    @IBOutlet weak var txtToDate: HoshiTextField!
    @IBOutlet weak var txtPerson: HoshiTextField!
    @IBOutlet weak var txtStatus: HoshiTextField!
    @IBOutlet weak var btnGenerateReport: UIButton!
    
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    let dateFormatter = DateFormatter()
    let dateFormatter1 = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Report"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ReportScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        
        txtFromDate.inputView=datePicker
        txtToDate.inputView=datePicker1
        
        let calendar = Calendar.current
        let minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        let minDate = calendar.date(from: minDateComponent)
        datePicker.minimumDate = minDate
        print(" min date : \(String(describing: minDate))")
        dateFormatter.dateFormat = "dd MMM yyyy  hh:mm"
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        
        let calendar1 = Calendar.current
        let minDateComponent1 = calendar.dateComponents([.day,.month,.year], from: Date())
        let minDate1 = calendar1.date(from: minDateComponent1)
        datePicker1.minimumDate = minDate1
        print(" min date : \(String(describing: minDate1))")
        dateFormatter1.dateFormat = "dd MMM yyyy  hh:mm"
        datePicker1.addTarget(self, action: #selector(handleDatePicker1(sender:)), for: UIControlEvents.valueChanged)
        self.addDoneButtonOnKeyboard()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleDatePicker(sender: UIDatePicker)
    {
        txtFromDate.text = dateFormatter.string(from: datePicker.date)
    }
    func handleDatePicker1(sender: UIDatePicker)
    {
        txtToDate.text = dateFormatter1.string(from: datePicker1.date)
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ReportScreen.doneButtonActionAdd))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()

        self.txtToDate.inputAccessoryView = doneToolbar
        self.txtFromDate.inputAccessoryView=doneToolbar
    }
    func doneButtonActionAdd()
    {
        self.txtFromDate.resignFirstResponder()
        self.txtToDate.resignFirstResponder()
    }

    
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnGenerateReportTapped(_ sender: Any) {
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
