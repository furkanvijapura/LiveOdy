//
//  SecondViewController.swift
//  DemoTabBar
//
//  Created by discusit on 25/07/18.
//  Copyright © 2018 Discus IT. All rights reserved.
// # Pods for DemoTabBar
//pod 'SQLite.swift', '~> 0.11.5'

import UIKit
import SQLite

class SecondViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet var contactNO: UITextField!
    @IBOutlet var emailID: UITextField!
    @IBOutlet var Lname: UITextField!
    @IBOutlet var Fname: UITextField!
    @IBOutlet var tblDataBase: UITableView!
    
    var firstName = [String]()
    var LastName = [String]()

    
    var database: Connection!
    
    let usersTable = Table("Demo-API")
    let id = Expression<Int>("id")
    let FnameColunm = Expression<String>("fname")
    let LnameColunm = Expression<String>("lname")
    let emailColunm = Expression<String>("email")
    let contactColunm = Expression<Int>("contact")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Demo-API").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDataBase.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = firstName[indexPath.row]
        cell?.detailTextLabel?.text = LastName[indexPath.row]
       
        return cell!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstName.count
    }

    @IBAction func CreateTable(_ sender: Any) {
        let CreateTable = usersTable.create{
            (Table) in
            Table.column(self.id, primaryKey: true)
            Table.column(self.FnameColunm)
            Table.column(self.LnameColunm)
            Table.column(self.contactColunm)
            Table.column(self.emailColunm, unique: true)
        }
        do {
            try self.database.run(CreateTable)
            print("Create Table")
            
        } catch{
            print(error)
        }
    }
    @IBAction func Update(_ sender: Any) {
//        guard let userIdString = alert.textFields?.first?.text,
//            let userId = Int(userIdString),
//            let email = alert.textFields?.last?.text
//            else { return }
//        print(userIdString)
//        print(email)
//
//        let user = self.usersTable.filter(self.id == userId)
//        let updateUser = user.update(self.email <- email)
//        do {
//            try self.database.run(updateUser)
//        } catch {
//            print(error)
//        }
    }
    @IBAction func Delete(_ sender: Any) {
        let user = self.usersTable.filter(self.id == Int(contactNO.text!)!)
        let deleteUser = user.delete()
        do {
            try self.database.run(deleteUser)
        } catch {
            print(error)
        }
    }
    @IBAction func Insert(_ sender: Any) {
        
        let insertUserInfo = usersTable.insert(self.FnameColunm <- Fname.text!,self.LnameColunm <- Lname.text!, self.contactColunm <- Int(contactNO.text!)!, self.emailColunm <- emailID.text!)
        do{
            try database.run(insertUserInfo)
            print("Inser User Info")
            Fname.text = ""
            Lname.text = ""
            contactNO.text = ""
            emailID.text = ""
        }catch{
            print(error)
        }
    }
    @IBAction func Show(_ sender: Any) {
        do {
            let users = try self.database.prepare(self.usersTable)
            print(users)
            firstName.removeAll()
            LastName.removeAll()
            for user in users {
                firstName.append(user[self.FnameColunm])
                LastName.append(user[self.LnameColunm])
                print("userId: \(user[self.id]), name: \(user[self.FnameColunm]), name: \(user[self.LnameColunm]), email: \(user[self.emailColunm])email: \(user[self.contactColunm])")
            }
        } catch {
            print(error)
        }
        tblDataBase.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

