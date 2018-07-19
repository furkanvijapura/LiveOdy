//
//  HRDashboard.swift
//  Odin_App_Project_Swift
//
//  Created by discusit on 09/03/18.
//  Copyright © 2018 discussolutions. All rights reserved.
//

import UIKit

class HRDashboard: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    @IBOutlet weak var tblHRList: UITableView!
    var timesheetBool = Int()
    var modueltimesheetName = ["Timesheet"]
    var moduletimesheetImage = ["timesheet_dashboard_gray"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HR"
        self.setNavigationBarItem()
        timesheetBool = (objInfo.permision.value(forKey: "CRM_TIMESHEET") as? Int)!
        if timesheetBool==1
        {
            //getORListing()
        }
        if timesheetBool == 0 {
            //displayAlertMessage(messageToDisplay: "Permission denied")
            ShowAlertForPermission()
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        // self.setNavigationBarItem()
        // self.navigationController?.setNavigationBarHidden(false, animated: animated)
        if timesheetBool == 0 {
            //displayAlertMessage(messageToDisplay: "Permission denied")
           // ShowAlertForPermission()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblHRList.dequeueReusableCell(withIdentifier: "cell") as! HRtDashboardCell
        cell.lblHRModuleName.text=modueltimesheetName[indexPath.row]
        cell.imgHRModule.image = UIImage(named: moduletimesheetImage[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row==0{
            if timesheetBool==1{
                return 70
            }
            else{
                return 0
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row==0
        {
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "timesheet") as! timesheet
            self.navigationController?.pushViewController(objReg, animated: true)
        }
    }
}
