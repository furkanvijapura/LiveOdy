//
//  MoreInfoScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 28/11/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class MoreInfoScreen: UIViewController,UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet var peopleHeaderview: UIView!
    @IBOutlet var infoOGHeaderview: UIView!
    @IBOutlet var infosetHeaderview: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var BillingVIew: UIView!
    @IBOutlet weak var ShipingView: UIView!
    @IBOutlet weak var lblPriceBookValue: UILabel!
    @IBOutlet weak var lblParentOrgName: UILabel!
    
    @IBOutlet weak var lblGSTNo: UILabel!
    @IBOutlet weak var viewAdditionalBack: UIView!
    @IBOutlet weak var viewKeyInfoList: UIView!
    @IBOutlet weak var expandTableView: UITableView!
    @IBOutlet weak var DynamicTableCell: UITableView!
    @IBOutlet weak var collectionViewPeople: UICollectionView!
    
    var arrray:[String] = ["Product Name","Product Info","About Produc"]
    var arroooy : [String] = ["NOT YET","DONE","FINISH"]
    var titlll : [String] = ["InfoSet","People"]
    
    var selectedIndex = -1
    var dataArrayTitle  : [String] = ["Finace","Person",]
    var dataArray1      : [String] = ["Account","Odin App",""]
    var dataArray2      : [String] = ["No Details","abc@gmail.com"]
    var dataArray3      : [String] = ["NA","+91 1234567890"]
    // var img             : [UIImage] = [#imageLiteral(resourceName: "infoSet"),#imageLiteral(resourceName: "people")]
    
    var items = ["1", "2", "3", "4", "5"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title="More Info"
        mainScrollView.delegate = self
        self.expandTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.DynamicTableCell.separatorStyle = UITableViewCellSeparatorStyle.none
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(MoreInfoScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        BillingVIew.SetViewShadow()
        ShipingView.SetViewShadow()
        viewAdditionalBack.SetViewShadow()
        lblGSTNo.text=objInfo.cstNo as String
        lblParentOrgName.text=objInfo.parentOrgName as String
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! PeopleCollectionCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        return peopleHeaderview as! UICollectionReusableView
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.expandTableView
        {
            return 1
        }
        else if tableView == self.DynamicTableCell
        {
            
            return 1
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.DynamicTableCell
        {
            return 3
        }
        else if tableView == self.expandTableView
        {
            
            return 2
        }
        return 0
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = DynamicTableCell.dequeueReusableCell(withIdentifier: "cell") as! infoSetCell
        cell.textLabel?.text = "NO DATA FOUND!"
        
        if tableView == self.expandTableView
        {
            let cell = expandTableView.dequeueReusableCell(withIdentifier:"Cell") as! customCell
            cell.selectionStyle = .none
            cell.matchName.text = dataArrayTitle[indexPath.row]
            cell.team2.text = dataArray2[indexPath.row]
            return cell;
        }
        else if tableView == self.DynamicTableCell
        {
            let cell = DynamicTableCell.dequeueReusableCell(withIdentifier: "cell") as! infoSetCell
            cell.selectionStyle = .none
            cell.lblInforight.text = arrray[indexPath.row]
            cell.lblinfoleft.text = arroooy[indexPath.row]
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == DynamicTableCell
        {
            return 30
        }
        else if tableView == expandTableView
        {
            if(selectedIndex == indexPath.row)
            {
                //return 100;
                print(indexPath.row)
                return self.calculateHeight(selectedIndexPath: indexPath)
            }
            else
            {
                return 31;
            }
        }
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let indexPath = expandTableView.indexPathForSelectedRow;
        if tableView == DynamicTableCell
        {
            
        }
        else if tableView == expandTableView
        {
            if(selectedIndex == indexPath?.row)
            {
                selectedIndex = -1
            }
            else
            {
                selectedIndex = (indexPath?.row)!
            }
            self.expandTableView.beginUpdates()
            self.expandTableView.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.automatic )
            self.expandTableView.endUpdates()
        }
    }
    func calculateHeight(selectedIndexPath: IndexPath) -> CGFloat
    {
        
        
        return 58
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if tableView == self.expandTableView
        {
            return 35
        }
        else if tableView == self.DynamicTableCell
        {
            
            return 35
        }
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        if tableView == DynamicTableCell
        {
            
            return infosetHeaderview
        }
        else if tableView == expandTableView
        {
            
            return infoOGHeaderview
        }
        return nil
    }
}

//@IBDesignable extension UIView {
//    @IBInspectable var borderColor: UIColor? {
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//        get {
//            guard let color = layer.borderColor else {
//                return nil
//            }
//            return UIColor(cgColor: color)
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var cornerRadius: CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//}

