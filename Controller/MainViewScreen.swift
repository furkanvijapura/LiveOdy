//
//  MainViewScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 6/21/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import Floaty

var LoginBoooool : Bool = true

class MainViewScreen: UITableViewController {
    var titleName:String!
    var floaty = Floaty()

    @IBOutlet var btnNotificationCount: UIButton!
    @IBOutlet var btnVisitMain: UIButton!
    @IBOutlet var lblTotalVisit: UILabel!
    @IBOutlet var lblAIAItem: UILabel!
    var appd:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if LoginBoooool == false
        {
            let appDelegateee = UIApplication.shared.delegate as! AppDelegate
            appDelegateee.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        }
        
       /* let view = storyboard?.instantiateViewController(withIdentifier: "Splashscreen")as! Splashscreen
        // let signin = storyboard.instantiateViewController(withIdentifier: "LoginScreen")as! LoginScreen
        let SideTableViewController = storyboard?.instantiateViewController(withIdentifier: "SideTableViewController") as! SideTableViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: view)
        SideTableViewController.mainViewController = nvc
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: SideTableViewController)*/

        self.setNavigationBarItem()
        getSOListing()
        getCompanyLists()
        getProductLists()
        getORListing()
        self.navigationItem.title = "My World"
       // self.navigationItem.hidesBackButton = true

       if let myImage = UIImage(named: "Gradient")
       {
            UINavigationBar.appearance().setBackgroundImage(myImage, for: .default)
           // UINavigationBar.appearance().backgroundColor=UIColor(red: 24, green: 71, blue: 127, alpha: 1.0)
//            self.title = "Dashboard"
            
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
         btnNotificationCount.setTitle(UserDefaults.standard.object(forKey: "todayPendingCounts") as? String, for: UIControlState.normal)
            btnNotificationCount.setTitleColor(UIColor.white, for: UIControlState.normal)
        }
    }
    func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            print("Swipe Right")
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuTableViewViewController") as? SideMenuTableViewViewController
            destination?.modalTransitionStyle = .flipHorizontal
            // var naBar = UINavigationController(rootViewController: destination!)
            self.present(destination!, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
//MARK: - For floting method=============================
    func layoutFAB()
    {
        floaty.addItem("Sunil....", icon: UIImage(named: "Comment"))
        { item in
                                    let objReg=self.storyboard?.instantiateViewController(withIdentifier: "AddVisitScreen") as! AddVisitScreen
                                    self.navigationController?.pushViewController(objReg, animated: true)
        }
        floaty.addItem("Sunil..Yadav..", icon: UIImage(named: "Filter"))
        { item in
            
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "AddVisitScreen") as! AddVisitScreen
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        floaty.paddingX = 10
        floaty.paddingY = 80
        floaty.fabDelegate = self as? FloatyDelegate
        self.view.addSubview(floaty)
    }
    //========================For OPtion Menu==============
    
        @IBAction func menuFunc(_ sender: Any) {
            
            //        self .performAnimationForCenterView()
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuTableViewViewController") as? SideMenuTableViewViewController
//             let navbar = UINavigationController(rootViewController: destination!)
            
            self.present(destination!, animated: false, completion: nil)
        }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
      /*  let view = storyboard?.instantiateViewController(withIdentifier: "Splashscreen")as! Splashscreen
        
        // let signin = storyboard.instantiateViewController(withIdentifier: "LoginScreen")as! LoginScreen
        let SideTableViewController = storyboard?.instantiateViewController(withIdentifier: "SideTableViewController") as! SideTableViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: view)
        SideTableViewController.mainViewController = nvc
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: SideTableViewController)*/

        self.setNavigationBarItem()

        getCompanyLists()
        getProductLists()
        getORListing()
        getSOListing()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func btnVisitMainTapped(_ sender: Any)
    {
//        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "VisitMainScreen") as! VisitMainScreen
//        self.navigationController?.pushViewController(objReg, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row==1
        {
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "VisitMainScreen") as! VisitMainScreen
            objReg.isFilter=false
            self.navigationController?.pushViewController(objReg, animated: true)
        }
            else if indexPath.row==0
        {
            //let objReg=self.storyboard?.instantiateViewController(withIdentifier:"SalesOrderScreen") as! SalesOrderScreen
            //self.navigationController?.pushViewController(objReg, animated: true)
        }
    }
}
extension MainViewScreen : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
func getCompanyLists()
{
    //"organization/getMinifiedOrganizationList"
   // INDISTART()
    APISession.getDataWithRequestWithToken( withAPIName:"common/contacts" )
    {
        (response, permissions) in
        // self.STOP_INDICATOR()
        print(("",response))
        if response != nil
        {
            DicData = (response)!
      //      INDISTOP()
        }
    }
}
func getProductLists()
{
//    INDISTART()
    APISession.getDataWithRequestWithToken( withAPIName: "product/getAllMinifiedProducts") {
        (response, permissions) in
         //self.STOP_INDICATOR()
        print(("",response))
        if response != nil
        {
            DicDataProductList=(response)!
//            self.INDISTOP()
            
            //  self.arrProductdata = response!
        }
    }
}

func getORListing()
{
    APISession.getDataWithRequest( withAPIName: "orderRequisition/list")
    {
        (response, permissions) in
        // self.STOP_INDICATOR()
        print(("",response))
        if response != nil
        {
            let orList : NSArray = response! .value(forKey: "orList") as! NSArray
            ORDicData=orList
            ORListData.removeAll()
            ORListData = ModelORList.generateORModelArray()
            print("ORDicData :: ",ORDicData)
            if refreshiingBoooo == false
            {
                refreshControl.endRefreshing()
            }
            else{
            //refreshControl.endRefreshing()
            }
            tableeeORListScreen.reloadData()
            //self.tblCompanyList.reloadData()
        }
    }
}

func getSOListing()
{
    APISession.getDataWithRequest( withAPIName: "saleOrder/list")
    {
        (response, permissions) in
        print(("",response))
        //self.STOP_INDICATOR()
        if response != nil
        {
            let soList : NSArray = response! .value(forKey: "soList") as! NSArray
            SOMainArray = soList
             SOListData.removeAll()
             SOListData = SOModel_List.GenrateSOModelData()
            if refreshiingBoooo == false
            {
                refreshControl.endRefreshing()
            }

            //generateSOAPprover = false
            tablevaaaar.reloadData()
        }
    }
}
