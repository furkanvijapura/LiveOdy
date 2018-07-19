//
//  FprgotPassword.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 06/09/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController {

    @IBOutlet weak var btnResetPasword: UIButton!
    @IBOutlet weak var txtEmail: HoshiTextField!
    override func viewDidLoad() {
        super.viewDidLoad() 
        txtEmail.setDoneOnKeyboard()
        self.title = "Forgot password"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ForgotPassword.back(sender:)))
        let navBackgroundImage:UIImage! = UIImage(named: "Gradient")
        self.navigationController?.navigationBar.setBackgroundImage(navBackgroundImage,
                                                                    for: .default)
//        UINavigationBar.setBackgroundImage(#imageLiteral(resourceName: "Gradient"))
        self.navigationItem.leftBarButtonItem = backButton
//        if let myImage = UIImage(named: "Gradient")
//        {
//            UINavigationBar.appearance().setBackgroundImage(myImage, for: .default)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func btnResetPasswordTapped(_ sender: Any)
    {
        apiCAllingToResetPassword()
    }
    
    func apiCAllingToResetPassword()
    {
        START_INDICATOR()
    let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic.setValue(txtEmail.text, forKey:"userIdExtern")
        objDic.setValue("", forKey:"captchaResponse")
        objDic.setValue("", forKey:"clientName")

    APISession.postDataWithRequest(objDic, withAPIName: "user_management/reset_password")
    {(response, permissions) in
         self.STOP_INDICATOR()
        if response != nil{
        let message:NSString=(response as AnyObject).value(forKey: "message") as! NSString
        print(message)
        let alert = UIAlertController(title:"Odin App", message:message as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
        {
            (alert:UIAlertAction!) -> Void in
            if message == "Your Password send to Your Email Id"{
               self.navigationController?.popViewController(animated: true)
            }
        })
        alert.addAction(okAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
        }
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
