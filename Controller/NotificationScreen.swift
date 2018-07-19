//
//  NotificationScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 30/10/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class NotificationScreen: UITableViewController {
    var arrayNotidficationdata = NSArray()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Notification"

        getNotificationList()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(NotificationScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton

}
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func getNotificationList()
    {
        if Reachability.isConnectedToNetwork(){
        START_INDICATOR()
        APISession.getDataForVisitProfileWithRequest(withAPIName: "visitplan/getNotifications", strOrgId: "", strUserId: ""){(response, permissions) in
            
            print("Count response is=====",response)
            self.STOP_INDICATOR()
            self.arrayNotidficationdata=response!
            if self.arrayNotidficationdata.count==0
            {
                
            }
            else
            {
               self.tableView.reloadData()
            }
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayNotidficationdata.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! NotificationCell
        let objData : NSDictionary = self.arrayNotidficationdata[indexPath.row] as! NSDictionary
        if let contactName : String = objData.value(forKey: "concat") as? String
        {
            cell.concatName.text = contactName
        }
        if let orgNamaList : String = objData.value(forKey: "organization_name") as? String
        {
            cell.orgName.text = orgNamaList
        }
        if let commentdata : String = objData.value(forKey: "comment_data") as? String
        {
            cell.commentData.setTitle(commentdata, for: UIControlState.normal)
        }
        if let commentdate : NSNumber = objData.value(forKey: "created_date") as? NSNumber
        {
            let dateVisitStr : Double = commentdate.doubleValue
            let date1 = Date(timeIntervalSince1970: (dateVisitStr / 1000.0) )
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let myStringafd = formatter.string(from: date1)
            cell.commentDate.setTitle(myStringafd, for: UIControlState.normal)
        }
        
        // Configure the cell...

        return cell
    }
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
      let objReg=self.storyboard?.instantiateViewController(withIdentifier: "MassageScreen") as! MassageScreen
      self.navigationController?.pushViewController(objReg, animated: true)
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
