//
//  OpportunityMainScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 11/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class OpportunityMainScreen: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var ScorBoard_view:UIView!
    @IBOutlet weak var Todo_view:UIView!
    @IBOutlet weak var Dynamic_view:UIView!
    @IBOutlet weak var Table:UITableView!
    @IBOutlet weak var image_view:UIImageView!
    
    var temp = true
    
    @IBDesignable class UIDesignableButton: UIButton
    {
    }
    @IBOutlet weak var btn:UIButton!
    var point = Int()
    override func viewDidLoad()
    {
        self.setNavigationBarItem()

        super.viewDidLoad()
        self.title="Opportunity"
        
     //   self.navigationItem.hidesBackButton = true
      //  let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(OpportunityMainScreen.back(sender:)))
       // self.navigationItem.leftBarButtonItem = backButton
        //        image_view.layer.cornerRadius = 25
    }
    func back(sender: UIBarButtonItem)
    {
        //        _ = navigationController?.popViewController(animated: true)
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "MainViewScreen") as? MainViewScreen
        let navBar = UINavigationController(rootViewController: destination1!)
        self.present(navBar, animated: false, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        else if section == 1
        {
            return 1
        }
        else
        {
            return 10
        }
        //        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell1 = Table.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)as! OpportunityCell1
            //            cell1.textLabel?.text = "discus it"
            return cell1
        }
        else if indexPath.section == 1
        {
            let cell2 = Table.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)as! OpportunityCell2
            
            //             cell2.textLabel?.text = "DBS"
            return cell2
        }
        else
        {
            let cell3 = Table.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)as! OpportunityCell3
            //            cell3.Chat_but.addTarget(self, action: #selector(Chat_action), for: .touchUpInside)
            
            cell3.Name.isHidden = true
            //            cell3.textLabel?.text = "DownTown"
            return cell3
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0
        {
            return 150.0
        }
        if indexPath.section == 1
        {
            return 150.0
        }
        else
        {
            return 200.0
        }
    }
    func Chat_action(sender: AnyObject)
    {
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.Table)
        let cellIndexPath = self.Table.indexPathForRow(at: pointInTable)
        print(cellIndexPath!)
        point = cellIndexPath!.row
        print(point)
        let cell3 = Table.dequeueReusableCell(withIdentifier: "cell3", for: cellIndexPath!)as! OpportunityCell3
        if temp == true
        {
            cell3.Name.isHidden = true
            temp = false
        }
        else
        {
            cell3.Name.isHidden = false
            temp = true
        }
    }
    @IBAction func MyTeam(sender:UIButton)
    {
        let cell3 = Table.dequeueReusableCell(withIdentifier: "cell3")as! OpportunityCell3
        if temp == true
        {
            cell3.Name.isHidden = false
            temp = false
        }
        else
        {
            cell3.Name.isHidden = true
            temp = true
        }
    }
}
