//
//  PeopleListScreen.swift
//  
//
//  Created by Sunil Yadav on 20/11/17.
//
//

import UIKit

class PeopleListScreen: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    let initialDataAryFilter:[FIlterModel] = FIlterModel.generateModelFilterArray()
    var dataAryFilter:[FIlterModel] = FIlterModel.generateModelFilterArray()

    @IBOutlet weak var tblPeopleList: UITableView!
    @IBOutlet weak var txtEnabled: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    var  arrPeopledata = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "People"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(PeopleListScreen.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        searchBar.delegate = self
        getPeopleLists()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPeopleLists()
    {
        START_INDICATOR()
        APISession.getDataWithRequestWithToken( withAPIName: "person/getMinifiedPersons") {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                self.arrPeopledata = response!
                self.tblPeopleList .reloadData()
            }
        }
    }
    func back(sender: UIBarButtonItem)
    {
        //        _ = navigationController?.popViewController(animated: true)
        let destination1 = self.storyboard?.instantiateViewController(withIdentifier: "MainViewScreen") as? MainViewScreen
        let navBar = UINavigationController(rootViewController: destination1!)
        self.present(navBar, animated: false, completion: nil)
    }

    func tableView(_ tableView:  UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if(searchActive)
//        {
//            return arrAutosearchProduct.count
//        }
        return arrPeopledata.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PeopleListCell

        let objData : NSDictionary = self.arrPeopledata[indexPath.row] as! NSDictionary
        if let orgName : String = objData.value(forKey: "firstName") as? String
        {
            cell.lblPeopleName.text = orgName
        }
        if let orgType : String = objData.value(forKey: "designation") as? String
        {
            cell.lblPeopleType.text = orgType
        }
        return cell
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
