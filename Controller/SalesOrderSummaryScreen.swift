//
//  SalesOrderSummaryScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 8/9/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class SalesOrderSummaryScreen: UITableViewController {

    @IBOutlet var mainHeaderView: UIView!
    @IBOutlet var lblCompanyName: UILabel!
    @IBOutlet var btnUserProfile: UIButton!
    @IBOutlet var btnProductDetails: UIButton!
    @IBOutlet var btnSalesOrderNo: UIButton!
    @IBOutlet var btnRetailerName: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title="Sales Order Summary"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(SalesOrderSummaryScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        
        
//        self.tableView.layer.cornerRadius=0.1
//        self.tableView.layer.borderWidth=1.0
//        self.tableView.layer.borderColor=UIColor.blue.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        
//        cell1.layer.cornerRadius=0.1
//        cell1.layer.borderWidth=1.0
//        cell1.layer.borderColor=UIColor.blue.cgColor
        
        // Configure the cell ...
        
        return cell1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 110
    }
    
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return mainHeaderView
    }

   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 110
    }
    
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
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
