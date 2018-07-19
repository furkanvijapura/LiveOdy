//
//  Category.swift
//  DemoCheckList
//
//  Created by i-Phone14 on 07/10/16.
//  Copyright © 2016 Trainee2. All rights reserved.
//

import Foundation
import UIKit


extension UITextField{
    func setTextFieldStyle(strPlaceholder:String) {
        self.placeholder=strPlaceholder
        self.attributedPlaceholder=NSAttributedString(string: strPlaceholder, attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
        self.layer.borderColor=UIColor.lightGray.cgColor
        self.layer.borderWidth=1.0
        self.layer.cornerRadius=2.0
        self.tintColor=UIColor.lightGray
        self.textColor=UIColor.black
        self.font=UIFont(name: "Helvetica", size: 16.0)
        let padding:UIView=UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.leftView=padding
        self.leftViewMode=UITextFieldViewMode.always
    }
}

extension UITextField
{
           func isValidEmailAddress(emailAddressString: String) -> Bool
       {
    
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do
    {
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = emailAddressString as NSString
        let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    }
    catch let error as NSError
    {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
    }
}


//===========For Done On keyboard============================

extension UIActivityIndicatorView
{

func showActivityIndicatory(uiView: UIActivityIndicatorView) {
    
    let objIndicator=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white) as UIActivityIndicatorView
    objIndicator.color=UIColor.blue
    objIndicator.frame=CGRect(x:100, y:100, width: 80, height: 80)
    self .addSubview(objIndicator)
    objIndicator.startAnimating()
    
//    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
//    actInd.frame = CGRectMake(x: 0, y: 0, width: 40, height: 40);
//    actInd.center = uiView.center
//    actInd.hidesWhenStopped = true
//    actInd.activityIndicatorViewStyle =
//        UIActivityIndicatorViewStyle.whiteLarge
//    uiView.addSubview(actInd)
    
//    showActivityIndicatory.startAnimating()
    
}
}
//extension UIToolbar{
//
//    func addDoneButtonOnKeyboard(txt:UITextInputAssistantItem)
//{
//    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
//    doneToolbar.barStyle = UIBarStyle.blackTranslucent
//    
//    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: nil,action: #selector(AddVisitScreen.doneButtonActionAdd))
//    
//    let items = NSMutableArray()
//    items.add(flexSpace)
//    items.add(done)
//    
//    doneToolbar.items = items as? [UIBarButtonItem]
//    doneToolbar.sizeToFit()

//    UITextField.inputAccessoryView = doneToolbar
//    self.txtPersonName.inputAccessoryView = doneToolbar
//    self.txtDateSelect.inputAccessoryView=doneToolbar
//    self.txtTimeSelect.inputAccessoryView=doneToolbar
    
//}
//}

//===========For Done On keyboard============================


extension UIButton{
    func setButtonStyle(strTitle:String)  {
        self .setTitle(strTitle, for: UIControlState.normal)
        self.backgroundColor=UIColor.black
        self.layer.cornerRadius=2.0
        
    }
}
extension String
{
    func showAsAlert(VC:UIViewController)
    {
        let alert=UIAlertController(title: "Swift", message: self, preferredStyle: UIAlertControllerStyle.alert)
        let OK=UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert .addAction(OK)
        VC .present(alert, animated: true, completion: nil)
    }
}
extension UIImageView
{
    func setImageByURL(strURL:String)
    {
        let URL=Foundation.URL(string: strURL)
        let imgDataC=Constant.ShareOBJ.cache .object(forKey: strURL as AnyObject)
        if (imgDataC != nil) {
            let img=UIImage.init(data: imgDataC! as! Data)
            self.image=img
        }
        else
        {
            let imgData=NSData(contentsOf: URL!)
            
            let objIndicator=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white) as UIActivityIndicatorView
            objIndicator.color=UIColor.blue
            objIndicator.frame=CGRect(x: self.frame.size.width/2-5, y: self.frame.size.height/2-3, width: 10, height: 10)
            self .addSubview(objIndicator)
            objIndicator.startAnimating()
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                objIndicator .stopAnimating()
                if imgData != nil
                {
                    let image=UIImage.init(data: imgData! as Data)
                    DispatchQueue.main.async {
                        Constant.ShareOBJ.cache .setObject(imgData!, forKey: strURL as AnyObject)
                        self.image=image
                    }
                }
            }
        }
    }
}

//MARK:- Extension for Using a Sidemenu

//extension UIApplication {
//    
//    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = viewController as? UINavigationController
//        {
//            return topViewController(nav.visibleViewController)
//        }
//        if let tab = viewController as? UITabBarController
//        {
//            if let selected = tab.selectedViewController
//            {
//                return topViewController(selected)
//            }
//        }
//        if let presented = viewController?.presentedViewController
//        {
//            return topViewController(presented)
//        }
//        
//        if let slide = viewController as? SlideMenuController
//        {
//            return topViewController(slide.mainViewController)
//        }
//        return viewController
//    }
//    
//    
//}
