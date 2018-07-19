//
//  APISession.swift
//  DemoCheckList
//
//  Created by i-Phone14 on 07/10/16.
//  Copyright © 2016 Trainee2. All rights reserved.
//

import UIKit
import Foundation

class APISession: NSObject {
    static var alertLogoutBool = Bool()
    static var alertCount = Int()
    //==================================Test Upl Link==============================================================
    
//    class func postDataWithRequest(_ dicData:NSDictionary, completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
//    class func postData(withRequest dicData: [AnyHashable: Any], withAPIName strAPIName: String, completionHandler: @escaping (_: Any, _: Bool) -> Void)
//    +(void)postDataWithRequest:(NSMutableDictionary *)dicData withAPIName:(NSString *)strAPIName completionHandler:(void (^)(id , BOOL))completionHandler
    
  class func postDataWithRequest(_ dicData:NSDictionary, withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        let data=try? JSONSerialization .data(withJSONObject: dicData, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody=data
      
        
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
           
            
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    //Force Fully Logout alert
                    if let Unautho = dicResponse!["message"]{
                        print(Unautho,true)
                        if Unautho as! String == "Unauthorized" {
                           abc.LogAlertConter += 1
                            if abc.LogAlertConter == 1{
                                abc.ForceLogouttt()
                            }
                        }
                    }else{
                        completionHandler(dicResponse, error==nil)
                    }
                    alertLogoutBool = false
                })
            }
            else
            {
                alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    //For use login and other 
    class func postDataForLogin(_ dicData:NSDictionary, withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let data=try? JSONSerialization .data(withJSONObject: dicData, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody=data
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
                
            if error == nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    completionHandler(dicResponse, error==nil)
                    alertLogoutBool = false
                })
            }
            else
            {
               alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    
//    ======For visit profile Header================================================
    
    class func getDataForVisitProfileWithRequest(withAPIName strAPIName: (String),strOrgId: (String),strUserId: (String),  completionHandler:@escaping (_ response:NSArray?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName+strOrgId+strUserId)
        
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                  //  completionHandler(dicResponse, error==nil)
                    if ((dicResponse as? NSArray)?.value(forKey: "message") != nil )
                    {
                        completionHandler((dicResponse! as! NSArray), error==nil)
                    }else{
                        let dicResponse = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                        // force fully logout
                        if let Unautho  = dicResponse!!["message"]{
                            print(Unautho,true)
                            if Unautho as! String == "Unauthorized" {
                                abc.LogAlertConter += 1
                                if abc.LogAlertConter == 1{
                                    abc.ForceLogouttt()
                                }
                            }
                        }
                    }
                     alertLogoutBool = false
                })
            }
            else
            {
               alertCount += 1
                abc.loaderOFF()
                completionHandler((error as! NSArray), error==nil)
            }
        })
        session.resume()
    }
    
    class func getSalesTypeChannel(withAPIName strAPIName: (String),strOrgId: (String),strUserId: (String),  completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName+strOrgId+strUserId)
        
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
       
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // force fully logout
                    var Unautho = String()
                    if ((dicResponse!["message"] as? String) != nil){
                        Unautho = dicResponse!["message"] as! String
                    }else{
                        Unautho = ""
                    }
                    if Unautho == "Unauthorized" {
                        abc.LogAlertConter += 1
                        if abc.LogAlertConter == 1{
                            abc.ForceLogouttt()
                        }
                    }
                    else
                    {
                        completionHandler(dicResponse, error==nil)
                    }
                    alertLogoutBool = false
                })
            }
            else
            {
              alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }

    
   //==========+For sales product
    class func getDataForSalesProductWithRequest(withAPIName strAPIName: (String),  completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    //Force Fully Logout alert
                    // force fully logout
                    var Unautho = String()
                    if ((dicResponse!["message"] as? String) != nil){
                        Unautho = dicResponse!["message"] as! String
                    }else{
                        Unautho = ""
                    }
                    if Unautho == "Unauthorized" {
                        abc.LogAlertConter += 1
                        if abc.LogAlertConter == 1{
                            abc.ForceLogouttt()
                        }
                    }
                    else
                    {
                        completionHandler(dicResponse, error==nil)
                    }
                    alertLogoutBool = false
                })
            }
            else
            {
               alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    //    ======For Header================================================
    //Get :: OR,
    class func getDataWithRequest(withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
    let URL = Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
    let request = NSMutableURLRequest(url: URL!)
    request.httpMethod="GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue(objInfo.Token, forHTTPHeaderField: "token")
    let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
    // implement for server conection lost....
    if error==nil
    {
        DispatchQueue.main.async(execute: {
        let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        
            // force fully logout
            var Unautho = String()
            if ((dicResponse!["message"] as? String) != nil){
                Unautho = dicResponse!["message"] as! String
            }else{
                Unautho = ""
            }
            if Unautho == "Unauthorized" {
                abc.LogAlertConter += 1
                if abc.LogAlertConter == 1{
                    abc.ForceLogouttt()
                }
            }
            else
            {
                 completionHandler(dicResponse, error==nil)
            }
           
            alertLogoutBool = false
    })
    }
    else
    {
        alertCount += 1
        abc.loaderOFF()
        completionHandler(nil, error==nil)
    }
    })
        session.resume()
    }
    
    //=================================For get UserProfile with just token===============
    
    class func getDataWithRequestWithToken(withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSArray?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        
        let request = NSMutableURLRequest(url: URL!)
        request.httpMethod = "GET"
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")

        
        
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if ((dicResponse as? NSArray)?.value(forKey: "message") != nil )
                    {
                        completionHandler((dicResponse! as! NSArray), error==nil)
                    }else{
                        let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                        // force fully logout
                        if let Unautho  = dicResponse!!["message"]{
                            print(Unautho,true)
                            if Unautho as! String == "Unauthorized" {
                                abc.LogAlertConter += 1
                                if abc.LogAlertConter == 1{
                                    abc.ForceLogouttt()
                                }
                            }
                        }
                    }
                   
                    alertLogoutBool = false
                })
            }
            else
            {
               alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    //    ======For Post With Token================================================
    
    class func postDataWithRequestwithToken(_ dicData:NSDictionary, withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSArray?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        let data=try? JSONSerialization .data(withJSONObject: dicData, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody=data
        
        
        //let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC)*5))
        //dispatch_after(dispatchTime, dispatch_get_main_queue()) {        
        
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    if ((dicResponse as? NSArray)?.value(forKey: "message") != nil )
                    {
                        completionHandler((dicResponse! as! NSArray), error==nil)
                    }else{
                        let dicResponse = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
                        // force fully logout
                        if let Unautho  = dicResponse!!["message"]{
                            print(Unautho,true)
                            if Unautho as! String == "Unauthorized" {
                                abc.LogAlertConter += 1
                                if abc.LogAlertConter == 1{
                                    abc.ForceLogouttt()
                                }
                            }
                        }
                    }
                    alertLogoutBool = false
                })
            }
            else
            {
                alertCount += 1
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    
    
    //=================For download pdf===================
    class func postDataForPdfDownload(_ dicData:NSArray, withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("arraybuffer", forHTTPHeaderField: "responseType")
        request.addValue("token=" + objInfo.Token, forHTTPHeaderField: "Cookie")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        let data=try? JSONSerialization .data(withJSONObject: dicData, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody=data
        
        
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                   
                    // force fully logout
                    var Unautho = String()
                    if ((dicResponse!["message"] as? String) != nil){
                        Unautho = dicResponse!["message"] as! String
                    }else{
                        Unautho = ""
                    }
                    if Unautho == "Unauthorized" {
                        abc.LogAlertConter += 1
                        if abc.LogAlertConter == 1{
                            abc.ForceLogouttt()
                        }
                    }
                    else
                    {
                        completionHandler(dicResponse, error==nil)
                    }
                    alertLogoutBool = false
                })
            }
            else
            {
                alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    
    class func postDataForAttachement(_ dicData:[String:AnyObject], withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="POST"
        //        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.addValue("multipart/form-dataage/jpeg", forHTTPHeaderField: "Content-Type")
        request.addValue("form-data", forHTTPHeaderField: "Content-Disposition")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        
        //        request.addValue("form-data", forHTTPHeaderField: "Content-Disposition")
        
        let data=try? JSONSerialization .data(withJSONObject: dicData, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody=data
        
        
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // f completionHandler(dicResponse, error==nil)orce fully logout
                    var Unautho = String()
                    if ((dicResponse!["message"] as? String) != nil){
                        Unautho = dicResponse!["message"] as! String
                    }else{
                        Unautho = ""
                    }
                    if Unautho == "Unauthorized" {
                        abc.LogAlertConter += 1
                        if abc.LogAlertConter == 1{
                            abc.ForceLogouttt()
                        }
                    }
                    else
                    {
                        completionHandler(dicResponse, error==nil)
                    }
                    alertLogoutBool = false
                })
            }
            else
            {
                alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    class func postDataWithRequestwithTokenDelete(_ dicData:NSDictionary, withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        let data=try? JSONSerialization .data(withJSONObject: dicData, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody=data
        
        //let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC)*5))
        //dispatch_after(dispatchTime, dispatch_get_main_queue()) {

        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
            
            if error==nil   
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                   
                    // force fully logout
                    var Unautho = String()
                    if ((dicResponse!["message"] as? String) != nil){
                        Unautho = dicResponse!["message"] as! String
                    }else{
                        Unautho = ""
                    }
                    if Unautho == "Unauthorized" {
                        abc.LogAlertConter += 1
                        if abc.LogAlertConter == 1{
                            abc.ForceLogouttt()
                        }
                    }
                    else
                    {
                        completionHandler(dicResponse, error==nil)
                    }
                    alertLogoutBool = false
                })
            }
            else
            {
                alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
    
    class func postDataWithRequestwithTokenOnDictionary(_ dicData:NSDictionary, withAPIName strAPIName: (String), completionHandler:@escaping (_ response:NSDictionary?,_ status:Bool)->Void)
    {
        let URL=Foundation.URL(string: Constant.WEBSERVICE_URL+strAPIName)
        let request=NSMutableURLRequest(url: URL!)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(objInfo.Token, forHTTPHeaderField: "token")
        let data=try? JSONSerialization .data(withJSONObject: dicData, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody=data
        
        //let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC)*5))
        //dispatch_after(dispatchTime, dispatch_get_main_queue()) {
        
        let session = URLSession.shared.dataTask(with: request as URLRequest,completionHandler: { (data, response, error) in
            // implement for server conection lost....
           
            if error==nil
            {
                DispatchQueue.main.async(execute: {
                    let dicResponse = try? JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    // force fully logout
                    var Unautho = String()
                    if ((dicResponse!["message"] as? String) != nil){
                        Unautho = dicResponse!["message"] as! String
                    }else{
                        Unautho = ""
                    }
                    if Unautho == "Unauthorized" {
                        abc.LogAlertConter += 1
                        if abc.LogAlertConter == 1{
                            abc.ForceLogouttt()
                        }
                    }
                    else
                    {
                        completionHandler(dicResponse, error==nil)
                    }
                     alertLogoutBool = false
                })
            }
            else
            {
               alertCount += 1
                abc.loaderOFF()
                completionHandler(nil, error==nil)
            }
        })
        session.resume()
    }
}


class abc: NSObject {
    
    class func loaderOFF(){
       APISession.alertLogoutBool = true
         let control = UIViewController()
         control.STOP_INDICATOR()
        var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindowLevelAlert + 1
        let alert: UIAlertController =  UIAlertController(title: "Server error", message: "Could not connect to the server.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {(action: UIAlertAction) -> Void in
             APISession.alertCount = 0
            topWindow?.isHidden = true // if you want to hide the topwindow then use this
            topWindow = nil // if you want to remove the topwindow then use this
        }))
        topWindow?.makeKeyAndVisible()
        //if APISession.alertCount == 1{
            topWindow?.rootViewController?.present(alert, animated: true, completion: { _ in })
        //}
        }
    static var LogAlertConter = 0
    class func ForceLogouttt(){
        let control = UIViewController()
        control.STOP_INDICATOR()
        var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindowLevelAlert + 1
        let alert: UIAlertController =  UIAlertController(title: "Session Timeout", message: "Please login Again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {(action: UIAlertAction) -> Void in
            topWindow?.isHidden = true // if you want to hide the topwindow then use this
            topWindow = nil // if you want to remove the topwindow then use this
            abc.LogAlertConter = 0
            Switcher.updateRootVC()
        }))
        topWindow?.makeKeyAndVisible()
        topWindow?.rootViewController?.present(alert, animated: true, completion: { _ in })
    }
}
class Switcher:UIViewController {
    
    static func updateRootVC(){
        
        var rootVC : UIViewController?
       
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServerSelection") as! ServerSelection
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions:nil)
    }
}
