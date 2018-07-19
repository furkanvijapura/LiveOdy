//
//  MainVisitProfileScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 8/11/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
import Alamofire
var arrLocationMap = NSMutableArray()

class MainVisitProfileScreen: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lblProfitPrice: UILabel!
    @IBOutlet var viewTimeStatus: UIView!
    @IBOutlet var locationProfitView: UIView!
    @IBOutlet var btnLocation: UIButton!
    @IBOutlet var tblStatusView: UITableView!
    @IBOutlet var mainHeaderView: UIView!
    @IBOutlet var btnUserDetails: UIButton!
    @IBOutlet var btnAddress1: UIButton!
    @IBOutlet var btnUserCall: UIButton!
    var Id=NSNumber()
    @IBOutlet weak var lblOrganizationName: UILabel!
    @IBOutlet weak var btnUpdatedWithDate: UIButton!
    @IBOutlet weak var btncraterWithDate: UIButton!
    @IBOutlet weak var btnOrgCategory: UIButton!
    var strIndexPath = String()
    var userIdIndexPath = String()
    var arrayProfileDetails = NSArray()
    var arrTimeLineList : NSArray = []
    var arrFinalProfile : NSArray = []
    
    var contac = String()
    var AddressAddvisitMap = String()
    @IBOutlet weak var btnRateTotal: UIButton!
    @IBOutlet var btnAddress2: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(MainVisitProfileScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton

        self.title="Visit Profile"
         getVIsitProfileDetails()
        tableView.delegate = self
        tableView.dataSource = self
       // refreshiingBoooo = false
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.clear
        refreshControl?.tintColor = UIColor.black
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl!)
        notificationCoutn()
    }
    func notificationCoutn(){
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(MainVisitProfileScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        var navigationButton = UIBarButtonItem(image: #imageLiteral(resourceName: "notification_bell"), landscapeImagePhone: #imageLiteral(resourceName: "notification_bell"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(MainVisitProfileScreen.didTapSearchButton(sender:)))
        let label = UILabel(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
        label.layer.borderColor = UIColor.clear.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = label.bounds.size.height / 2
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = .white
        label.backgroundColor = .red
        let notificationCount: NSNumber? = UserDefaults.standard.object(forKey: "notificationCount") as? NSNumber
        if notificationCount != 0
        {
            label.text = notificationCount?.stringValue
            let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            rightButton.setBackgroundImage(UIImage(named: "notification_bell"), for: .normal)
            rightButton.addSubview(label)
            navigationButton = UIBarButtonItem(customView: rightButton)
        }
        self.navigationItem.rightBarButtonItem = navigationButton
    }
    override func viewWillAppear(_ animated: Bool) {
        getVIsitProfileDetails()
        notificationCoutn()
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        self.getVIsitProfileDetails()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func makeAPhoneCall(Contact: String)  {
        let url : NSURL = URL(string: "tel://\(Contact)")!as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    @IBAction func btnCallUser(_ sender: UIButton) {
      //  makeAPhoneCall(Contact: contac)
        contac.makeAColl()
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAttachementTapped(_ sender: Any) {
        INDISTART()
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "ImageattachViewController") as! ImageattachViewController
        self.INDISTOP()
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    func didTapSearchButton(sender: UIBarButtonItem)
    {
    }
    @IBAction func btnAddress1Tapped(_ sender: Any)
    {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapScreen") as! GoogleMapScreen
        GoogMapAddress = (btnAddress1.titleLabel?.text)!
        if GoogMapAddress != ""
        {
            geoCodeUsingAddress(address: GoogMapAddress as NSString)
             self.navigationController?.pushViewController(objReg, animated: true)
        }
        else{
//            self.displayAlertMessage(messageToDisplay: "Valid Address are not available.")
            ShowAlertInterConnection()
        }
       
    }
    func geoCodeUsingAddress(address: NSString) -> CLLocationCoordinate2D {
        var latitude: Double = 0
        var longitude: Double = 0
        let addressstr : NSString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(address)&key=AIzaSyC46oZSukuaJM0jQRMOe7QCvYfnJ3NIwas" as NSString
        let urlStr  = addressstr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let searchURL: NSURL = NSURL(string: urlStr! as String)!
        do {
            let newdata = try Data(contentsOf: searchURL as URL)
            if let responseDictionary = try JSONSerialization.jsonObject(with: newdata, options: []) as? NSDictionary {
                print(responseDictionary)
                let array = responseDictionary.object(forKey: "results") as! NSArray
                let dic = array[0] as! NSDictionary
                let locationDic = (dic.object(forKey: "geometry") as! NSDictionary).object(forKey: "location") as! NSDictionary
                latitude = locationDic.object(forKey: "lat") as! Double
                longitude = locationDic.object(forKey: "lng") as! Double
                lat = String(latitude)
                long = String(longitude)
                
            }} catch {
        }
        var center = CLLocationCoordinate2D()
        center.latitude = latitude
        center.longitude = longitude
        return center
    }
    @IBAction func btnChatTapped(_ sender: Any) {
        
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "MassageScreen") as! MassageScreen
        objReg.idChat=Id.stringValue
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    
    @IBAction func btnAddress2Tapped(_ sender: Any) {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapScreen") as! GoogleMapScreen
        GoogMapAddress = (btnAddress2.titleLabel?.text!)!
        geoCodeUsingAddress(address:GoogMapAddress  as! NSString)
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getVIsitProfileDetails()
    {
        //INDISTART()
       START_INDICATOR()
        APISession.getDataForVisitProfileWithRequest(withAPIName: "visitplan/VisitPlanDetailsById/", strOrgId: strIndexPath, strUserId:"/" + userIdIndexPath)
        {
            (response, permissions) in
            refreshControl?.endRefreshing()
            self.STOP_INDICATOR()
            if response != nil{
            self.arrayProfileDetails=response!
            
            let ProfileImage  = ((self.arrayProfileDetails).value(forKey: "logo") as! NSArray).object(at: 0) as! String
            
            let imgprofile  = Constant.WEBSERVICE_URLUploadImage + ProfileImage
            let imageURL:String = imgprofile + "?token=" + objInfo.Token
//            let url = URL(string: imageURL)
                let urlString = imageURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: urlString!)
            if let data = try? Data(contentsOf: url!)
            {
                let image: UIImage = UIImage(data: data)!
                self.btnProfile.setImage(image, for: .normal)
            }
            let OrgName:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "organizationName") as! NSArray
            self.lblOrganizationName.text = OrgName.object(at: 0) as? String
            
            let OrgCategory:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "orgCategory") as! NSArray
            self.btnOrgCategory.setTitle((OrgCategory.object(at: 0) as? String), for: UIControlState.normal)
            
            let creater:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "creater") as! NSArray
            let createDate:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "createdDate") as! NSArray
            let dateVisitStr : Double = (createDate.object(at: 0) as AnyObject).doubleValue
            let date1 = Date(timeIntervalSince1970: (dateVisitStr / 1000.0) )
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy  hh:mm a"
            let myStringafd = formatter.string(from: date1)
            self.btncraterWithDate.setTitle((creater.object(at: 0) as? String)! + ("   ") + (myStringafd), for: UIControlState.normal)
            
            let updater:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "updatedBy") as! NSArray
            let updateDate:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "datetimeOfVisit") as! NSArray
            let dateVisitStr1 : Double = (updateDate.object(at: 0) as AnyObject).doubleValue
            let date2 = Date(timeIntervalSince1970: (dateVisitStr1 / 1000.0) )
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "dd MMM yyyy  hh:mm a"
            let myStringafd1 = formatter.string(from: date2)
            self.btnUpdatedWithDate.setTitle((updater.object(at: 0) as? String)! + ("   ") + (myStringafd1), for: UIControlState.normal)
            
            let updateBY:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "updatedBy") as! NSArray
            let updateBYDate:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "updatedDate") as! NSArray
            let dateBYVisitStr1 : Double = (updateBYDate.object(at: 0) as AnyObject).doubleValue
            let dateBY = Date(timeIntervalSince1970: (dateBYVisitStr1 / 1000.0) )
            let formatterBY = DateFormatter()
            formatterBY.dateFormat = "dd MMM yyyy  hh:mm a"
            let myStringafdBY = formatterBY.string(from: dateBY)
            self.btnUserDetails.setTitle((updateBY.object(at: 0) as? String)! + ("   ") + (myStringafdBY), for: UIControlState.normal)
            
            let address:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "address") as! NSArray
            self.btnAddress1.setTitle((address.object(at: 0) as? String), for: UIControlState.normal)
          
            let objData : NSDictionary = self.arrayProfileDetails.object(at: 0) as! NSDictionary
//            let totalAmountStr : String = (totalAmount[indexPath.row] as AnyObject).stringValue
            
            self.Id=objData.value(forKey: "id") as! NSNumber
            UserDefaults.standard.setValue(self.Id.stringValue, forKey: "PlanVisitId")
            
            if let visitLocation : String = objData.value(forKey: "visitLocation") as? String
            {
                arrLocationMap.removeAllObjects()
                print(arrLocationMap)
                let strDic = visitLocation
                if strDic == "{}"
                {
                    self.btnAddress2.setTitle("NA", for: UIControlState.normal)
                    self.btnAddress2.isUserInteractionEnabled=false
                }
                else
                {
                    let dict = self.convertToDictionary(text: strDic)
                    if (dict?.count)!==3
                    {
                        let strFinal:String=(dict as AnyObject).value(forKey: "address") as! String
                        let strLlng:NSNumber=(dict as AnyObject).value(forKey: "lng") as! NSNumber
                        let strLat:NSNumber=(dict as AnyObject).value(forKey: "lat") as! NSNumber
                        if (strFinal == "")
                        {
                            arrLocationMap.add("No Data Found")
                            arrLocationMap.add(strLlng)
                            arrLocationMap.add(strLat)
                            self.btnAddress2.setTitle("NA", for: UIControlState.normal)
                        }
                        else
                        {
                        arrLocationMap.add(strFinal)
                        arrLocationMap.add(strLlng)
                        arrLocationMap.add(strLat)
                        self.btnAddress2.setTitle(strFinal, for: UIControlState.normal)
                            self.AddressAddvisitMap = strFinal
                        }
                    }
                    else if (dict?.count)!==2
                    {
                        let strLlng:NSNumber=(dict as AnyObject).value(forKey: "lng") as! NSNumber
                        let strLat:NSNumber=(dict as AnyObject).value(forKey: "lat") as! NSNumber
                        
                        if (strLlng == 0) || (strLat == 0)
                        {
                            
                        }
                        else
                        {
                        arrLocationMap.add("No Data Found")
                        arrLocationMap.add(strLlng)
                        arrLocationMap.add(strLat)
                        }
                        self.btnAddress2.setTitle("NA", for: UIControlState.normal)
                    }
                }
            }

            if let totalAmount : String = (objData.value(forKey: "totalAmount") as AnyObject).stringValue
            {
                if (totalAmount == "0")
                {
                    let commentVisit:NSArray=(self.arrayProfileDetails as AnyObject).value(forKey: "detailsOfVisit") as! NSArray
                    
                }
                else{
                     let CurrencySymbol : NSArray = (self.arrayProfileDetails as AnyObject).value(forKey: "currencySymbol") as! NSArray
                     self.btnRateTotal.setTitle(objData.value(forKey: "currencySymbol") as! String + " " + totalAmount, for: UIControlState.normal)
                }
                
            }
            let addRouteStr : NSArray = objData.value(forKey: "contacts") as! NSArray
            if (addRouteStr.count==0)
            {
            }
            else{
                self.contac  = (addRouteStr.object(at: 0) as? String)!
                if self.contac != ""{
                    self.btnUserCall.setTitle(self.contac, for: UIControlState.normal)
                  
                   
                }else{
                    self.btnUserCall.setTitle("NA",for: UIControlState.normal)
                     self.btnUserCall.isUserInteractionEnabled = false
                }
               
            }

            if let visiteStr : String = objData.value(forKey: "statusOfVisit") as? String
            {
                // This is for "isOutsideRadius"!=null
                if let visiteStrOrder : Bool = objData.value(forKey: "isOutsideRadius") as? Bool
                {
                    if (visiteStrOrder==true)
                    {
                            if (visiteStr == "No Order")
                            {
                                self.btnLocation.setImage(UIImage(named: "Location_close_red"), for: UIControlState.normal)
                                self.btnLocation.setTitle("No Order Off Location", for: UIControlState.normal)
                                self.btnLocation.setTitleColor(UIColor(red: 233/255, green: 116/255, blue: 13/255, alpha: 1.0), for: UIControlState.normal)
                            }
                            if (visiteStr=="Order")
                            {
                                self.btnLocation.setImage(UIImage(named: "Location_On_green"), for: UIControlState.normal)
                                self.btnLocation.setTitle("Order Off Location", for: UIControlState.normal)
                                self.btnLocation.setTitleColor(UIColor(red: 36/255, green: 145/255, blue: 91/255, alpha: 1.0), for: UIControlState.normal)
                            }
                    }
                    if (visiteStrOrder==false)
                    {
                        if (visiteStr == "No Order")
                        {
                            self.btnLocation.setImage(UIImage(named: "Location_close_red"), for: UIControlState.normal)
                            self.btnLocation.setTitle("No Order Location Found", for: UIControlState.normal)
                            self.btnLocation.setTitleColor(UIColor(red: 245/255, green: 131/255, blue: 76/255, alpha: 1.0), for: UIControlState.normal)
//                            self.btnRateTotal.isHidden=true
                        }
                        if (visiteStr=="Order")
                        {
                            self.btnLocation.setImage(UIImage(named: "Location_On_green"), for: UIControlState.normal)
                            self.btnLocation.setTitle("Order Location Found", for: UIControlState.normal)
                            self.btnLocation.setTitleColor(UIColor(red: 36/255, green: 145/255, blue: 91/255, alpha: 1.0), for: UIControlState.normal)
//                            self.btnRateTotal.isHidden=false

                        }
                    }
                }
                else
                {
                    if (visiteStr == "No Order")
                    {
                        self.btnLocation.setImage(UIImage(named: "Location_close_red"), for: UIControlState.normal)
                        self.btnLocation.setTitle("No Order Location Not Found", for: UIControlState.normal)
                        self.btnLocation.setTitleColor(UIColor(red: 245/255, green: 131/255, blue: 76/255, alpha: 1.0), for: UIControlState.normal)
                    }
                    if (visiteStr=="Order")
                    {
                        self.btnLocation.setImage(UIImage(named: "Location_On_green"), for: UIControlState.normal)
                        self.btnLocation.setTitle("Order Location Not Found", for: UIControlState.normal)
                        self.btnLocation.setTitleColor(UIColor(red: 36/255, green: 145/255, blue: 91/255, alpha: 1.0), for: UIControlState.normal)
                    }
                    if (visiteStr=="Pending")
                    {
                        self.btnLocation.setImage(UIImage(named: "pending_visit"), for: UIControlState.normal)
                        self.btnLocation.setTitle("Pending", for: UIControlState.normal)
                        self.btnLocation.setTitleColor(UIColor(red: 36/255, green: 145/255, blue: 91/255, alpha: 1.0), for: UIControlState.normal)
                    }
                }
            }
            else{
                self.btnLocation.setImage(UIImage(named: "pending_visit"), for: UIControlState.normal)
                self.btnLocation.setTitle("Pending", for: UIControlState.normal)
                self.btnLocation.setTitleColor(UIColor(red: 245/255, green: 131/255, blue: 76/255, alpha: 1.0), for: UIControlState.normal)
            }
            let visitHistoryList : NSArray = (self.arrayProfileDetails as AnyObject) .value(forKey: "visitHistoryList") as! NSArray
            self.arrTimeLineList = visitHistoryList.object(at: 0) as! NSArray
            
            self.arrFinalProfile = self.arrTimeLineList
            self.tableView.reloadData()
            self.INDISTOP()
        }
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
    
    //==================For extra====================
    
    override func
    viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFinalProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell") as! TimelineCell
        let personName:NSArray=(self.arrFinalProfile as AnyObject).value(forKey: "personName") as! NSArray
        cell.postLabel?.text = personName[indexPath.row] as? String
        
        let objData : NSDictionary = self.arrFinalProfile[indexPath.row] as! NSDictionary
        
        if let visiteStr : String = objData.value(forKey: "statusOfVisit") as? String
        {
            if (visiteStr == "No Order")
            {
                cell.nameLabel.text = "No Order"
                cell.typeImageView.image = UIImage(named:"cancel_profile_red")
            }
            else  if (visiteStr == "")
            {
                cell.nameLabel.text = "Pending"
                cell.typeImageView.image = UIImage(named:"Pending_profile")
            }
            else
            {
                cell.nameLabel.text = "Order"
                cell.typeImageView.image = UIImage(named:"cart_profile_green")
            }
        }
        else
        {
            cell.nameLabel.text = "Pending"
            cell.typeImageView.image = UIImage(named:"Pending_profile")
            
        }
        cell.dateImageView.image = UIImage(named:"user_profile_gray")
        let dateVisit:NSArray=(self.arrFinalProfile as AnyObject).value(forKey: "datetimeOfVisit") as! NSArray
        let dateVisitStr : Double = (dateVisit[indexPath.row] as AnyObject).doubleValue
        let date1 = Date(timeIntervalSince1970: (dateVisitStr / 1000.0) )
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy  hh:mm a"
        let myStringafd = formatter.string(from: date1)
        cell.dateLabel.text = myStringafd
        return cell
        
    }
}
