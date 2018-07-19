//
//  ChatScreen.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 7/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

class ChatScreen: UIViewController, UITableViewDelegate,UITextViewDelegate,UITableViewDataSource{
    
    @IBOutlet var textViewComment: UITextView!
    
    @IBOutlet var tblCommentTableView: UITableView!
    
    @IBOutlet var btnSendComment: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Comments"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ChatScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSendTapped(_ sender: Any) {
    }

    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblCommentTableView.dequeueReusableCell(withIdentifier: "Cell")!
        return cell
    }
    
      func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
}
