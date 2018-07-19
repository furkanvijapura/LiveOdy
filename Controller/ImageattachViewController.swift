
//
//  ImageattachViewController.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 12/10/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import MobileCoreServices
import CloudKit
import Alamofire
import Photos

var finalStrForImg:String = String()
typealias Parameters = [String: String]

class ImageattachViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIDocumentPickerDelegate,UIDocumentMenuDelegate
{
    @IBOutlet var imgMainImg: UIImageView!
    @IBOutlet weak var txt: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var imageview: UIImageView!
    var isiCloud = Bool()
    let container = CKContainer.default()
    var main = [String]()
    var main2 = [String]()
    var nm = String()
    let picker = UIImagePickerController()
    let tempImageName : [String] = []
    let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    var imageURL: NSURL!
    var FileName : [String]!
    var image = UIImage()
    var imageName : [String]!
    var arrayTest=NSArray()
    var arrMain  = [NSString]()
    var arrayResponse=NSArray()
    var name = String()
    let visitId: String? = UserDefaults.standard.object(forKey: "PlanVisitId") as? String
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        table.delegate = self
        table.dataSource = self
        self.title = "Documents"
        //       imageview.isHidden = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ImageattachViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        APICallingToGetAllAttachement()
        
    }
    func APICallingToDeleteAttachement()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(visitId, forKey:"firstId")
        objDic .setValue(indexPathStr, forKey:"secondId")
        objDic .setValue("visitplan", forKey:"firstValue")
        objDic .setValue(docName, forKey:"secondValue")
        print(("objIdc delete data is ==",objDic))
        //docs/deleteDocument
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "docs/deleteDocumentMobile")
        {
            (response, permissions) in
            print("response is ==",response)
            self.STOP_INDICATOR()
            let msg:String=(response as AnyObject).value(forKey: "message") as! String
            print(msg)
            let alert = UIAlertController(title:"Message", message:msg, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            {
                (alert:UIAlertAction!) -> Void in
                 self.APICallingToGetAllAttachement()
            })
            alert.addAction(okAction)
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    var point = Int()
    var indexPathStr = String()
    var docName = String()

    func buttonPressed(sender: AnyObject)
    {
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.table)
        let cellIndexPath = self.table.indexPathForRow(at: pointInTable)
        print(cellIndexPath!)
        point = cellIndexPath!.row
        print(point)
    }
    @IBAction func btnDeleteTapped(_ sender: Any)
    {
        
        buttonPressed(sender: sender as AnyObject)
        let id:NSArray=(self.arrayResponse as AnyObject).value(forKey: "id") as! NSArray
        let docNmae:NSArray=(self.arrayResponse as AnyObject).value(forKey: "docName") as! NSArray
        indexPathStr = (id[point] as AnyObject).stringValue
        docName=(docNmae[point] as AnyObject) as! String
        docName = docNmae[point] as! String
        
        let alert = UIAlertController(title: "Delete Document", message:"Are you sure you want to delete this document?", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
        {
            (alert:UIAlertAction!) -> Void in
            self.APICallingToDeleteAttachement()
        })
        let cancelAction = UIAlertAction(title: "No", style: .default, handler:
        {
            (alert:UIAlertAction!) -> Void in
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    //MARK:- Upload Action button...
    
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func Upload_action(_ sender: Any)
    {
//         APICallingToUploadAllAttachement()
//        UploadImage()
//        uploadFilefresh()
//        uploadFile()
        if txt.text == ""
        {
            let cameraImg = UIImage(named: "camera_gray")
            let galleryImg = UIImage(named: "gallery_gary")
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let Gellary = UIAlertAction(title: "Gallery", style: .default, handler:
            {(img) in
                self.PhotoLibrary()
                
            })
            let Camera = UIAlertAction(title: "Camera" as String, style: .default, handler:
            {(go) in
                self.Camera()
            })
            let iCloud = UIAlertAction(title: "iCloud", style: .default, handler:
            {(img) in
                self.iCloud()
                
            })
            //Camera.setValue(cameraImg, forKey: "image")
//            Gellary.setValue(galleryImg, forKey: "image")
            alert.addAction(iCloud)
            alert.addAction(Camera)
            alert.addAction(Gellary)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            print("not blank.....")
            UploadImage()
            table.reloadData()
            txt.text = ""
        }
 
    }
    
    //MARK:- Gallery function...
    func iCloud()
    {
        isiCloud=true
        let login = self.isIcloudLogin()
        print(login)
        let importmenu = UIDocumentMenuViewController(documentTypes: [String(describing: kUTTypePNG),String(describing:kUTTypeImage),String(describing:kUTTypePDF)], in: .import)
    
        importmenu.modalPresentationStyle = .formSheet
        importmenu.delegate = (self as UIDocumentMenuDelegate)
        self.present(importmenu, animated: true, completion: nil)
    }
    var strUrl = String()
    var strDocType = String()

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL)
    {
        url.startAccessingSecurityScopedResource()
        print(url)
        let name = url.lastPathComponent
        img2 = name
        strUrl = url.absoluteString
        print(name)
        if main2.contains(name)
        {
            print("All ready Upload")
            //            Table.reloadData()
        }
        else
        {
            main = [name]
            main2.append(name)
            print(main2)
            let last4 = name.substring(from:name.index(name.endIndex, offsetBy: -4))
            strDocType=last4
            print(last4)
            UploadImage()
            nm = name
            //            UploadRequest()
            table.reloadData()
            
        }
        //        url.startAccessingSecurityScopedResource()
        url.stopAccessingSecurityScopedResource()
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController)
    {
        print(" cancelled by user")
        dismiss(animated: true, completion: nil)
    }
    //MARK: DocumentMenu Delegate
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController)
    {
        documentPicker.delegate = self as? UIDocumentPickerDelegate
        present(documentPicker, animated: true, completion: nil)
    }
    func PhotoLibrary()
    {
        isiCloud=false
        picker.allowsEditing = false
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        print(picker)
        present(picker, animated: true, completion: nil)
    }
    //MARK: Login Check
    func isIcloudLogin()->Bool
    {
        if let currentToken  = FileManager.default.ubiquityIdentityToken
        {
            print(currentToken)
            return true
        }
        else
        {
            print("Not logged in")
            return false
        }
    }
    //MARK:- Table Delegate
    
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return main2.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        
//        cell.textLabel?.text = main2[indexPath.row]as String
//        
//        return cell
//    }
    //MARK:- Camera function...
    
    func Camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        else
        {
            noCamera()
        }
    }
    var imgUserProfile = UIImage()
    var imgVIew = UIImageView()
    var img = String()
    var img2 = String()
    
    //MARK:- ImagePicker Delegate Method..
     func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let originalimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imgUserProfile=originalimage
       self.imgVIew.image=originalimage
        if picker.sourceType == .camera
        {
//            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//            print(documentDirectory)
//            let local = documentDirectory.appending("")
//            print(local)
           // let image11 = info[UIImagePickerControllerOriginalImage] as! UIImage
            //print(image)
//            let data: NSData = UIImagePNGRepresentation(image)! as NSData
//            //data.write(toFile: local, atomically: true)
////            let imageData = NSData(contentsOfFile: local)!
//            let photoURL = NSURL(fileURLWithPath: local)
//            print(photoURL)
////            imageURLff = photoURL
//            let imageWithData = UIImage(data: data as Data)!
//            print(imageWithData)
            self.saveToCameraRoll(image:originalimage)
            {
                  print("URL: \(String(describing: $0))")
                let imageURL1 = URL(string: String(describing: $0!))!
            print("imageURL..",imageURL1)
            let str = imageURL1.lastPathComponent
            print("lastPathComponent = ",str)
            self.img = str
                
            //nm.index((nm?.endIndex)!, offsetBy: -4)
            let last4 = self.img.substring(from:self.img.index(self.img.endIndex, offsetBy:-4))
            print("last4...",last4)
                self.arrayTest = [self.img]
                print(self.arrayTest)
                self.main2.append(str)
               // self.txt.text = str
                self.img2 = str
                self.name = self.img
                self.UploadImage()
            }
        }
        else{
        var imageURLff:NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
        let result = PHAsset.fetchAssets(withALAssetURLs: [imageURLff as URL], options: nil)
        let asset = result.firstObject
        print(asset!.value(forKey: "filename")!)
        
        print(imageURLff)
        img2=imageURLff.absoluteString!
        let imgname = imageURLff.path!
         img = imageURLff.lastPathComponent!
        img2 = (imageURLff.deletingPathExtension?.lastPathComponent)!
        print(img)
        print(imgname)
        arrayTest = [img]
        print(arrayTest)
//        main2.append((img as NSString) as String)
        main2.append(asset!.value(forKey: "filename") as! String)
        name = img
        txt.text = asset!.value(forKey: "filename") as? String
            
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(documentDirectory)
        let local = documentDirectory.appending(imgname)
        print(local)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(image)
        let data: NSData = UIImagePNGRepresentation(image)! as NSData
        data.write(toFile: local, atomically: true)
        let imageData = NSData(contentsOfFile: local)!
        let photoURL = NSURL(fileURLWithPath: local)
        print(photoURL)
        imageURLff = photoURL
        let imageWithData = UIImage(data: imageData as Data)!
        print(imageWithData)
        img2 = (asset!.value(forKey: "filename") as? String)!
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- NO Camera function...
    func noCamera()
    {
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //MARK:- Table Delegate Method...
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //        return 1
        print(imageName)
        
//        let objData : NSDictionary = self.arrayTest.object(at: 0) as! NSDictionary
//        if let visiteStr : NSArray = objData.value(forKey: "[]") as? NSArray
//        {
//        }
//        print(objData)

        
//         if arrayResponse.count>0
//        {
//            return arrayResponse.count
//        }
//     else
//        if arrMain.count  == 0
//        {
//            return 1
//        }
//        return arrMain.count
//        arrayResponse
        return arrayResponse.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cal", for: indexPath) as! AttachmentCell
        if arrayResponse.count>0
        {
        let objData : NSDictionary = self.arrayResponse[indexPath.row] as! NSDictionary
        cell.lblDocName.text = objData.value(forKey: "docName") as? String
//            let aString = objData.value(forKey: "docName") as? String
//            let newString1 = aString?.replacingOccurrences(of: ".png", with: "", options: .literal, range: nil)
//            let newString2 = newString1?.replacingOccurrences(of: ".PNG", with: "", options: .literal, range: nil)
//            let newString3 = newString2?.replacingOccurrences(of: ".JPG", with: "", options: .literal, range: nil)
//            let newString4 = newString3?.replacingOccurrences(of: ".jpg", with: "", options: .literal, range: nil)
//            let newString5 = newString4?.replacingOccurrences(of: ".pdf", with: "", options: .literal, range: nil)
//            cell.textLabel?.text = newString5
        }
       else
        if arrMain.count==0
        {
        }
        else
        {
            cell.lblDocName.text=arrMain[indexPath.row] as? String
        }
//        cell.textLabel?.text = arrayResponse[indexPath.row]as String
        return cell
    }
    var strTest = NSString()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let objData : NSDictionary = self.arrayResponse[indexPath.row] as! NSDictionary
        let strDocName:String = (objData.value(forKey: "docName") as? String)!
        let numberDoc:NSNumber = (objData.value(forKey: "id") as? NSNumber)!
        finalStrForImg = Constant.WEBSERVICE_URLGetImage + "fileservice/" + numberDoc.stringValue + "_" + strDocName
        print("FInal uri is = ", finalStrForImg)
        strTest = strDocName as NSString
        let lastpath = String(finalStrForImg.characters.suffix(4))
//        previewQL.dataSource = self // 5
//        previewQL.currentPreviewItemIndex = indexPath.row // 6
//        present(previewQL, animated: true, completion: nil)
//        DownloadDoc()
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "ShowImageScreen") as! ShowImageScreen
        if lastpath == ".pdf"
        {
            objReg.isImage = false
        }
        else{
            objReg.isImage = true
        }
        self.navigationController?.pushViewController(objReg, animated: true)
    }
    
    //============================
    
   
    // =======================For documnets download=====================
    func DownloadDoc()
    {
        let urlString = finalStrForImg
        let destination: DownloadRequest.DownloadFileDestination =
        { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(self.strTest as String)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(urlString, to: destination).response { response in
            print(response)
            
            if response.error == nil, let imagePath = response.destinationURL?.path {
                //let image = UIImage(contentsOfFile: imagePath)
//                self.ImageViewUpload.image = UIImage(contentsOfFile: imagePath)
            }
        }
        
    }
    func APICallingToGetAllAttachement()
    {
        START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(UserDefaults.standard.object(forKey: "PlanVisitId") as? String, forKey:"id")
//        objDic .setValue("43595", forKey:"id")
        objDic .setValue("visitplan", forKey:"value")
        APISession.postDataWithRequestwithToken(objDic, withAPIName: "docs/getAllDocs")
        {
            (response, permissions) in
            self.STOP_INDICATOR()
            self.arrayResponse=response!
            print("self.arrayResponse is ==",self.arrayResponse)
            
            self.table.reloadData()
        }
    }
 
//================Main   Fresh api calling============================================
    
func UploadImage()
    {
        //Parameter HERE
        
        let parameters = [
            "id": visitId,
            "docsFor" : "visitplan"]
        //Header HERE
        let headers = [
            "token" : objInfo.Token,
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data"
        ]
//        let image : UIImage = UIImage(named:"check_black")!
        if  self.isiCloud==true
        {
            let urlll = URL(string: strUrl)
            let dataiCloud = try? Data(contentsOf: urlll!)
//            let imageIcloud: UIImage = UIImage(data: dataiCloud!)!
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                //Parameter for Upload files
//                multipartFormData.append(dataiCloud!, withName: "file",fileName: "\(self.img2).png" , mimeType: "jpg/png")
                if self.strDocType == ".png"
                {
                multipartFormData.append(dataiCloud!, withName: "file",fileName: "\(self.img2).png" , mimeType: "jpg/png")

                }
                else if self.strDocType == ".jpg"
                
                {
                    multipartFormData.append(dataiCloud!, withName: "file",fileName: "\(self.img2).jpg" , mimeType: "jpg/png")

                }
                else{
                multipartFormData.append(dataiCloud!, withName: "file",fileName: self.img2 , mimeType: "application/octet-stream")
                }

                for (key, value) in parameters
                {
                    multipartFormData.append((value?.data(using: String.Encoding.utf8)!)!, withName: key)
                }
            }
                , usingThreshold:UInt64.init(),
                  to: Constant.WEBSERVICE_URL+"docs/upload", //URL Here
                method: .post,
                headers: headers as? HTTPHeaders, //pass header dictionary here
                encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        print("the status code is :")
                        upload.uploadProgress(closure: { (progress) in
                            print("something")
                        })
                        upload.responseJSON { response in
                            print("the resopnse code is : \(String(describing: response.response?.statusCode))")
                            print("the response is : \(response)")
                            self.APICallingToGetAllAttachement()
                        }
                        break
                    case .failure(let encodingError):
                        print("the error is  : \(encodingError.localizedDescription)")
                        break
                    }
            })
        }
        else{
            let image = imgUserProfile
            let imgData = UIImageJPEGRepresentation(image, 0.7)!
        Alamofire.upload(multipartFormData: { multipartFormData in
            //Parameter for Upload files
            multipartFormData.append(imgData, withName: "file",fileName: "\(self.img2).png" , mimeType: "jpg/png")
            
//            if self.strDocType == ".png"
//            {
//                multipartFormData.append(imgData, withName: "file",fileName: "\(self.img2).png" , mimeType: "jpg/png")
//                
//            }
//            else
//                
//            {
//                multipartFormData.append(imgData, withName: "file",fileName: "\(self.img2).jpg" , mimeType: "jpg/png")
//                
//            }
            
            for (key, value) in parameters
            {
                multipartFormData.append((value?.data(using: String.Encoding.utf8)!)!, withName: key)
            }
        }
            , usingThreshold:UInt64.init(),
           to: Constant.WEBSERVICE_URL+"docs/upload", //URL Here
            method: .post,
            headers: headers as? HTTPHeaders, //pass header dictionary here
            encodingCompletion: { (result) in
                switch result {
                case .success(let upload, _, _):
                    print("the status code is :")
                    upload.uploadProgress(closure: { (progress) in
                        print("something")
                    })
                    upload.responseJSON { response in
                        print("the resopnse code is : \(String(describing: response.response?.statusCode))")
                        print("the response is : \(response)")
                        self.APICallingToGetAllAttachement()
                    }
                    break
                case .failure(let encodingError):
                    print("the error is  : \(encodingError.localizedDescription)")
                    break
                }
        })
        }
    }
}
struct Media
{
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/png"
        //        self.filename = "kyleleeheadiconimage234567.jpg"
        self.filename = "\(arc4random()).png"
        
        guard let data = UIImageJPEGRepresentation(image, 0.7) else
        {
            return nil
        }
        self.data = data
    }
}
extension Data
{
    mutating func append(_ string: String)
    {
        if let data = string.data(using: .utf8)
        {
            append(data)
        }
    }
}



