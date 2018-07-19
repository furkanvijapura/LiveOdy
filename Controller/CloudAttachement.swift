//
//  CloudAttachement.swift
//  Odin_App_Project_Swift
//
//  Created by Sunil Yadav on 24/10/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit
import MobileCoreServices
import CloudKit

class CloudAttachement: UIViewController,UIDocumentPickerDelegate,UINavigationControllerDelegate,UIDocumentMenuDelegate,UITableViewDelegate,UITableViewDataSource
{
    let container = CKContainer.default()
    
    var main = [String]()
    var main2 = [String]()
    var nm = String()
    @IBOutlet weak var Table: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    //MARK:- iCloud button
    
    @IBAction func Cloud_action(_ sender: Any)
    {
        let login = self.isIcloudLogin()
        print(login)
        
        //        let importMenu = UIDocumentPickerViewController (documentTypes:[String(kUTTypePDF), String(kUTTypeImage), String(kUTTypeMovie), String(kUTTypeVideo), String(kUTTypePlainText), String(kUTTypeMP3)], in: UIDocumentPickerMode.import)
        //
        //        importMenu.delegate = self
        //
        //        self.present(importMenu, animated: true, completion: nil)
        
        let importmenu = UIDocumentMenuViewController(documentTypes: [String(describing: kUTTypePNG),String(describing:kUTTypeImage),String(describing:kUTTypePDF)], in: .import)
        importmenu.modalPresentationStyle = .formSheet
        importmenu.delegate = (self as UIDocumentMenuDelegate)
        //        importmenu.addOption(withTitle: "iCloud", image: nil, order: .last, handler:
        //            {
        //
        //            importmenu.delegate = (self as! UIDocumentMenuDelegate)
        //
        //            print("tapped on iCloud...")
        //        })
        
        self.present(importmenu, animated: true, completion: nil)
    }
    
    // MARK:-  Delegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL)
    {
        url.startAccessingSecurityScopedResource()
        
        print(url)
        let name = url.lastPathComponent
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
            nm = name
//            UploadRequest()
            Table.reloadData()
            
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
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return main2.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = main2[indexPath.row]as String
        
        return cell
    }
    
//    func UploadRequest()
    
    
    
   
}
