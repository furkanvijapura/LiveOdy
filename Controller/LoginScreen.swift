
 
 import UIKit
 //import QuartzCore
 
 let objInfo=AllUserInfo()
 var logoutBoools = true
 
 class LoginScreen: UIViewController {
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnRemember: UIButton!
    
    @IBOutlet var objIndicatior: UIActivityIndicatorView!
    //    @IBOutlet var forActivityIndicator: UIView!
    @IBAction func btnForgotPasswordTapped(_ sender: Any)
    {
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPassword
        self.navigationController?.pushViewController(objReg, animated: true)
        //        self.present(objReg, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isTranslucent = true
        let navBackgroundImage:UIImage! = UIImage(named: "Gradient")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage,
                                                                    for: .default)
        //            Constant.WEBSERVICE_URL1 = Constant.WEBSERVICE_URL
        //            print("TEst constant====",Constant.WEBSERVICE_URL1)
        self.addDoneButtonOnKeyboard()
        

        let strGetToken: NSNumber? = UserDefaults.standard.object(forKey: "LoginTag") as? NSNumber
        if strGetToken == 1001
        {
            btnRemember.setImage(UIImage(named: "Login_Checkbox"), for: UIControlState.normal)
            btnRemember.isSelected = true;
            let EmailLogin: String? = UserDefaults.standard.object(forKey: "EmailLogin") as? String
            let PasswordLogin: String? = UserDefaults.standard.object(forKey: "PasswordLogin") as? String
            txtEmail.text=EmailLogin
            txtPassword.text=PasswordLogin
        }
        else{
            btnRemember.setImage(UIImage(named: "Login_UnCheckbox"), for: UIControlState.normal)
            btnRemember.isSelected = false;
            // txtEmail.text=""
            // txtPassword.text=""
      
            if Constant.BoolServer == false
            {
            
                
            }
            else
            {
         
            }
        }
        /*
         let mainQueue = OperationQueue.main
         NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationUserDidTakeScreenshot,
         object: nil,
         queue: mainQueue) { notification in
         // executes after screenshot
         }
         */
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(LoginScreen.doneButtonAction))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        self.txtEmail.inputAccessoryView = doneToolbar
        self.txtPassword.inputAccessoryView = doneToolbar
        
        //txtEmail.text="admin@azafrangroup.com"
        //txtPassword.text="admin321"
        
        //  txtEmail.text="admin@INTERNAL-TESTING.com"
        // txtPassword.text="admin123"
        //
        //       txtEmail.text="admin1"
        //        txtPassword.text="admin123"
    }
    func doneButtonAction()
    {
        self.txtEmail.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
    }
    @IBAction func btnRememberMe(_ sender: Any)
    {
        if (btnRemember.isSelected == true)
        {
            btnRemember.tag = 1000
            btnRemember.setImage(UIImage(named: "Login_UnCheckbox"), for: UIControlState.normal)
            btnRemember.isSelected = false;
        }
        else
        {
            btnRemember.tag = 1001
            btnRemember.setImage(UIImage(named: "Login_Checkbox"), for: UIControlState.normal)
            btnRemember.isSelected = true;
            UserDefaults.standard.setValue( btnRemember.tag, forKey: "LoginTag")
            if txtEmail.text != "" || txtPassword.text != ""
            {
                UserDefaults.standard.setValue(txtEmail.text, forKey: "EmailLogin")
                UserDefaults.standard.setValue(txtPassword.text, forKey: "PasswordLogin")
            }
        }
    }
    @IBAction func btnLoginTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            START_INDICATOR()
            let objDic:NSMutableDictionary=NSMutableDictionary.init()
            objDic .setValue("abc", forKey: Constant.kBrowser)
            objDic .setValue(txtEmail.text, forKey: Constant.kUserName)//txtEmail.text
            //        objDic .setValue("admin", forKey: Constant.kUserName)//txtEmail.text
            //
            objDic.setValue(txtPassword.text, forKey: Constant.Kpassword)//txtPassword.text
            objDic.setValue("abc", forKey: Constant.kVersion)
            objDic.setValue("abc", forKey: Constant.kDevice)
            objDic.setValue("abc", forKey: Constant.kOS)
            APISession.postDataForLogin(objDic, withAPIName: "validAuth/authenticateForMobile") { (response, permissions) in
                if permissions
                {
                    self.STOP_INDICATOR()
                    if response != nil{
                        let status : NSNumber = response!.value(forKey: "status") as! NSNumber
                        if status == 0
                        {
//                            self.displayAlertMessage(messageToDisplay: "Authentication Failed! Invalid Username & Password.")
                            self.ShowAlertLogin()
                        }
                        else
                        {
                            refreshiingBoooo=true
                            UserDefaults.standard.setValue(self.txtEmail.text, forKey: "EmailLogin")
                            UserDefaults.standard.setValue(self.txtPassword.text, forKey: "PasswordLogin")
                            UserDefaults.standard.setValue( self.btnRemember.tag, forKey: "LoginTag")
                            self.displayAlertMessage(messageToDisplay: "Successfully login....")
                            objInfo.LoginInfo(dicInfo: response!)
                            print("objInfo is ==",objInfo)
                            print("Userid is=",objInfo.userName)
                            UserDefaults.standard.setValue(objInfo.Token, forKey: "token")
                            let strGetToken: String? = UserDefaults.standard.object(forKey: "token") as? String
                            print(("Token is", strGetToken))
                            UserDefaults.standard.setValue(objInfo.permision, forKey: "permissions")
                            UserDefaults.standard.setValue(objInfo.roleName, forKey: "roleName")
                            UserDefaults.standard.setValue(objInfo.configurations, forKey: "configurations")
                            let arrCountryList:NSArray = response?.value(forKey: "sites")as! NSArray
                            print(("Site is", arrCountryList))
                            let strSiteValue: String = (arrCountryList[0] as? String)!
                            print(("Site first is", strSiteValue))
                            UserDefaults.standard.setValue(strSiteValue, forKey: "Site")
                            self.INDISTOP()
                            UserDefaults.standard.setValue(objInfo.userName, forKey: "userName")
                            UserDefaults.standard.setValue(objInfo.profilelogolink, forKey: "profileLogoLink")
                            Constant.ShareOBJ.strUserId = objInfo.UserId
                            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "MyWorldDashboard") as! MyWorldDashboard
                            self.navigationController?.pushViewController(objReg, animated: true)
                        }
                    }
                }
                //                else
                //                {
                //                    self.STOP_INDICATOR()
                //                    self.displayAlertMessage(messageToDisplay: "Could not connect to the server.")
                //                }
            }
        }else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet Connection not Available!")
            ShowAlertInterConnection()
        }
        
    }
    func getCompanyLists()
    {
        //"organization/getMinifiedOrganizationList"
        INDISTART()
        APISession.getDataWithRequestWithToken( withAPIName:"common/contacts" )
        {
            (response, permissions) in
            self.STOP_INDICATOR()
            print(("",response))
            if response != nil
            {
                DicData = (response)!
                // self.INDISTOP()
            }else{
                print("errorrrr")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    /*
     // MARK: - Navigation
     
     
     func btnSignUpTapped(sender:UIButton)
     {
     let objDic:NSMutableDictionary=NSMutableDictionary.init()
     objDic .setValue(Constant.kRegister, forKey: Constant.kMode)
     objDic .setValue(strImage, forKey: Constant.kProfileImage)
     objDic .setValue(txtFullName.text, forKey: Constant.kFullName)
     objDic .setValue(txtEmailAddress.text, forKey: Constant.kEmailAddress)
     objDic .setValue(txtPassword.text, forKey: Constant.kPassword)
     objDic .setValue(txtMobileNo.text, forKey: Constant.kMobileNo)
     objDic .setValue(txtConfirmPassword.text, forKey: Constant.kConfirmPassword)
     objDic.setValue("909090", forKey: Constant.kDeviceId)
     objDic.setValue("2", forKey: Constant.kDeviceType)
     objIndicator .startAnimating()
     
     APISession .postDataWithRequest(objDic) { (response, status) in
     self.objIndicator .stopAnimating()
     if status
     {
     let statusResponse = response?.value(forKey: "status") as! NSInteger
     if statusResponse==0
     {
     "Failed" .showAsAlert(VC: self)
     }
     else
     {
     let dicResponse=response?.value(forKey: "userDetail") as! NSDictionary
     
     let objProfile=self.storyboard?.instantiateViewController(withIdentifier: "ProfileScreen") as! ProfileScreen
     objProfile.dicData=dicResponse.mutableCopy() as! NSMutableDictionary
     self.navigationController?.pushViewController(objProfile, animated: true)
     
     "Register Succsesfully" .showAsAlert(VC: self)
     print("response is",response!)
     }
     }
     else
     {
     
     }
     }
     }
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
 }
