//
//  ProfileSettingScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 7/31/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import Alamofire

class ProfileSettingScreen: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var lblRole: UILabel!
    @IBAction func btnSignOutTapped(_ sender: Any) {
    }
    @IBOutlet var imgUserProfile: UIImageView!
    @IBOutlet var btnAccount: UIButton!
    @IBOutlet var lblSite: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarItem()
        
        imgUserProfile.layer.cornerRadius=30.0;
        imgUserProfile.layer.borderColor = UIColor.black.cgColor
        imgUserProfile.layer.borderWidth=1.0
        imgUserProfile.layer.masksToBounds=true
        self.title="Profile Setting"
             // ImageProfile()
        PostData()
        let roleName: String? = UserDefaults.standard.object(forKey: "roleName") as? String
        print(("Token is", roleName))
        let siteValue: String? = UserDefaults.standard.object(forKey: "Site") as? String
        lblRole.text=roleName
        lblSite.text=siteValue
        self.navigationItem.hidesBackButton = true
        //let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ProfileSettingScreen.back(sender:)))
        //navigationController?.navigationBar.barTintColor = UIColor.white
        //navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //self.navigationItem.leftBarButtonItem = backButton
//        navigationController?.navigationBar.barTintColor = UIColor.white
//        UINavigationBar.appearance().barTintColor = UIColor.green
//        self.getUserProfileDetails()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnProfileImageTapped(_ sender: Any)
    {
        print("Helloo.....")
//        showActionSheet()
        forActionSheetMethod()
        
    }
    
    func showActionSheet()
    {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler:
        {
        (action:UIAlertAction!) -> Void in
        self.camera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler:
        {
        (alert:UIAlertAction!) -> Void in
        self.photoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //=======================================
    
    
    func forActionSheetMethod()
    {
    let cameraImg = UIImage(named: "camera_gray")
    let galleryImg = UIImage(named: "gallery_gary")
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler:
    {
        (alert:UIAlertAction!) -> Void in
        self.camera()
    })
    let gallery = UIAlertAction(title: "Gallery", style: .default, handler:
    {
        (alert:UIAlertAction!) -> Void in
        self.photoLibrary()
    })
    camera.setValue(cameraImg, forKey: "image")
    gallery.setValue(galleryImg, forKey: "image")
        
        
//        let attributedString = NSMutableAttributedString(string: camera.title!)
//        attributedString.addAttribute(NSKernAttributeName, value: CGFloat(1.0), range: NSRange(location: 0, length: attributedString.length))
//     [camera.title!].attributedText = attributedString
        
    alert.addAction(gallery)
    alert.addAction(cancel)
    alert.addAction(camera)
    present(alert, animated: true, completion: nil)
    }
//
//==================================================
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func photoLibrary()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
//        profilePic.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        imgUserProfile.image=info(UIImagePickerControllerOriginalImage)as?UIImage
//        let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
//        print(imageURL)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgUserProfile.image = image
        UploadImage()
        self.dismiss(animated: true, completion: nil)
    }
    func ImageProfile()
    {
   // let imgprofile = "https://cdn.pixabay.com/photo/2014/11/05/20/43/brown-518324_960_720.jpg"
        let imgprofile  = Constant.WEBSERVICE_URLUploadImage + (objInfo.profilelogolink as String)
    let strValue:String = imgprofile + "?token=" + objInfo.Token
//        let url = URL(string: strValue)
        let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: urlString!)
        let data = try? Data(contentsOf: url!)
        if data != nil{
            imgUserProfile.image = UIImage(data: data!)
        }
    }
    func PostData()
    {
        START_INDICATOR()
        let objDataDic = NSMutableDictionary.init()
        objDataDic .setValue("person", forKey: "value")
        objDataDic .setValue(objInfo.UserId, forKey: "fkId")
        print(objDataDic)
        APISession.postDataWithRequestwithToken(objDataDic, withAPIName: "docs/getLogo") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                //                let status : NSNumber = response! .value(forKey: "status") as! NSNumber
                //                if status == 0{
                //                }
                
                let orgName:NSArray=(response as AnyObject).value(forKey: "logoId") as! NSArray
                let logoid:NSNumber = (orgName.object(at: 0) as? NSNumber)!
                
                let logoName:NSArray=(response as AnyObject).value(forKey: "logoName") as! NSArray
                let name:String = (logoName.object(at: 0) as? String)!
                print(name)
                let strValue:String =  Constant.WEBSERVICE_URLUploadImage + (logoid.stringValue) + "_" + name + "?token=" + objInfo.Token
                print(strValue)
//                let url = URL(string: strValue)
                let urlString = strValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let url = URL(string: urlString!)
                let data = try? Data(contentsOf: url!)
                if data != nil{
                self.imgUserProfile.image = UIImage(data: data!)
                }
            }
        }
    }
    func UploadImage()
    {
        START_INDICATOR()
        //Parameter HERE
        let parameters = [
            "userId": (objInfo.UserId).stringValue,
            "logoFor" : "person"] as [String : Any]
        //Header HERE
        let headers = [
            "token" : objInfo.Token,
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data"
        ]
                let image = imgUserProfile.image
                let imgData = UIImageJPEGRepresentation(image!, 0.7)!
                Alamofire.upload(multipartFormData: { multipartFormData in
                    self.STOP_INDICATOR()
                    //Parameter for Upload files
                    multipartFormData.append(imgData, withName: "file",fileName: ".png" , mimeType: "jpg/png")
                    for (key, value) in parameters
                    {
                        multipartFormData.append(((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: key)
                    }
                }
                    , usingThreshold:UInt64.init(),
                      to: Constant.WEBSERVICE_URL+"docs/uploadLogo", //URL Here
                    method: .post,
                    headers: headers as? HTTPHeaders, //pass header dictionary here
                    encodingCompletion: { (result) in
                        self.STOP_INDICATOR()
                        switch result {
                        case .success(let upload, _, _):
                            print("the status code is :")
                            upload.uploadProgress(closure: { (progress) in
                                print("something")
                            })
                            upload.responseJSON { response in
                                print("the resopnse code is : \(String(describing: response.response?.statusCode))")
                                print("the response is : \(response)")
//                                self.APICallingToGetAllAttachement()
                            }
                            break
                        case .failure(let encodingError):
                            print("the error is  : \(encodingError.localizedDescription)")
                            break
                        }
                })
    }
    /*
    func back(sender: UIBarButtonItem) {
//        _ = navigationController?.popViewController(animated: true)
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "MainViewScreen") as? MainViewScreen
        let navBar = UINavigationController(rootViewController: destination1!)
        self.present(navBar, animated: false, completion: nil)

//        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
 */
    func getUserProfileDetails()
    {
        START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "user_management/user_profile/2") { (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            let statusResponse:NSString=(((response as AnyObject).value(forKey: "userRole") as! NSString).value(forKey: "role") as! NSString)
            print(("Final Valus is....",statusResponse))
            
        }
    }
}
