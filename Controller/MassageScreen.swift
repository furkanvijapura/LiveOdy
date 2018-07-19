//
//  MassageScreen.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 22/09/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class MassageScreen: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate
{
    @IBOutlet var toolView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var tblMessage: UITableView!
    var idChat = String()
    var textfieldBottomAnchor: NSLayoutConstraint?
    var arrr:NSMutableArray = []
    var arryCoommentList = NSArray()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Comments"
        print(idChat)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(MassageScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        tblMessage.delegate=self
        tblMessage.dataSource=self
        textField.translatesAutoresizingMaskIntoConstraints = false
        toolView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        toolView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        toolView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textfieldBottomAnchor = toolView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        textfieldBottomAnchor?.isActive = true
        getAllComments()
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.clear
        refreshControl?.tintColor = UIColor.black
        refreshControl?.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        tblMessage.addSubview(refreshControl!)
        //self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        setUpKeyBoardObservers()
    }
    func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }
    @objc private func refreshWeatherData(_ sender: Any) {
        getAllComments()
    }
    func back(sender: UIBarButtonItem)
    {
        _ = navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arryCoommentList.count
    }
    @IBAction func btnSend(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
            ApiCallingTOAddComment()
            dismissKeyboard()
        }
        else
        {
            //self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func ApiCallingTOAddComment()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(idChat, forKey:"id")
        objDic.setValue("6", forKey: "commentType")
        objDic.setValue("admin", forKey: "givenBy")
        objDic.setValue(textField.text, forKey:"comment")
        APISession.postDataWithRequest(objDic, withAPIName: "comment")
        {
            (response, permissions) in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            self.arryCoommentList.adding(response!)
            print(("Response is......",self.arryCoommentList))
            self.getAllComments()
            self.tblMessage .reloadData()
        }
    }
    func getAllComments()
    {
        if Reachability.isConnectedToNetwork(){
            START_INDICATOR()
            APISession.getDataForVisitProfileWithRequest(withAPIName: "visitplan/", strOrgId: idChat, strUserId:"/6")
            {(response, permissions) in
                print(("Response is......",response))
                self.STOP_INDICATOR()
                refreshControl.endRefreshing()
                self.arryCoommentList=response!
                print(self.arryCoommentList)
                self.tblMessage .reloadData()
                self.tblMessage.remembersLastFocusedIndexPath = true
            }
        }
        else
        {
            // self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func setCardView(view : UIView){
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        /*
         clientName = "<null>";
         comment = "hello how are you ";
         commentFor = "<null>";
         commentForId = "<null>";
         commentType = "<null>";
         createdDate = 1526381142651;
         givenBy = "Arpit Jariwala";
         id = 1879;
         isReOpen = "<null>";
         isUnRead = 0;
         userId = 1105;*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BubbleTableViewCell
        setCardView(view: cell.msgView)
        
        let objData : NSDictionary = self.arryCoommentList[indexPath.row] as! NSDictionary
        let userIDDD : NSNumber = objData.value(forKey: "userId") as! NSNumber
        let milisecond = objData.value(forKey: "createdDate") as! NSNumber
        let createrName = objData.value(forKey: "givenBy") as! String
        let msgRead = objData.value(forKey: "isUnRead") as! Int
        //let dateVar = Date.init(timeIntervalSinceNow: NSTimeIntervalSince1970(milisecond/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy \'at\' hh:mm a"
        print(dateFormatter.string(from: Date(milliseconds: Int(milisecond))))
        
        cell.lblMassage.text = objData.value(forKey: "comment") as? String
        cell.lblTiming.text = "\(createrName) \(dateFormatter.string(from: Date(milliseconds: Int(milisecond))))"
        
        if userIDDD == objInfo.UserId
        {
            cell.msgViewTrailingMargin.constant = 0
            cell.msgViewLeadingMargin.constant = 95
            cell.lblTimeTrailingMargin.constant = 0
            cell.lblTimeLeadingMargin.constant = 95
            cell.lblTiming.textAlignment = .right
            cell.lblMassage.textAlignment = .right
            cell.msgView.backgroundColor = UIColor.init(red: 150/245, green: 150/245, blue: 180/245, alpha: 0.8)
            if msgRead == 1{
                cell.imgRead.image = UIImage(named:"unRead")
            }else{
                cell.imgRead.image = UIImage(named:"Read")
            }
        }
        else
        {
            cell.msgViewTrailingMargin.constant = 95
            cell.msgViewLeadingMargin.constant = 0
            cell.lblTimeTrailingMargin.constant = 95
            cell.lblTimeLeadingMargin.constant = 0
            cell.lblTiming.textAlignment = .left
            cell.lblMassage.textAlignment = .left
            cell.msgView.backgroundColor = UIColor.init(red: 200/245, green: 200/245, blue: 200/245, alpha: 1.0)
            cell.imgRead.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 102
    }
    
    //4 Use NSnotificationCenter to monitor the keyboard updates
    func setUpKeyBoardObservers()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //5 toggle the bottom layout global variable based on the keyboard's height
    func handleKeyboardWillShow(notification: NSNotification) {
        
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        if let keyboardFrame = keyboardFrame {
            textfieldBottomAnchor?.constant = -keyboardFrame.height
        }
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        if let keyboardDuration = keyboardDuration {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    func handleKeyboardWillHide(notification: NSNotification) {
        arrr.add(textField.text)
        textField.text = ""
        tblMessage.reloadData()
        textfieldBottomAnchor?.constant = 5
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        if let keyboardDuration = keyboardDuration {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    //6 remove the observers
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    func textFieldShouldBeginEditing(_textField: UITextField) -> Bool
    {
        let txtFieldPosition = textField.convert(textField.bounds.origin, to: tblMessage)
        let indexPath = tblMessage.indexPathForRow(at: txtFieldPosition)
        if indexPath != nil {
            tblMessage.scrollToRow(at: indexPath!, at: .top, animated: true)
        }
        return true
    }
}


