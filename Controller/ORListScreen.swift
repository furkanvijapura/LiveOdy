import UIKit
import Floaty

var tableeeORListScreen = UITableView()
var strGenerateSOSalesType = String()
var arrGenerateSOID = NSMutableArray()

var refreshControl: UIRefreshControl!
var refreshiingBoooo = Bool()
var addUpdateOrder  = Int()

class ORListScreen: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate
{
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var txtEnable: UITextField!
    @IBOutlet weak var tblCompanyList: UITableView!
    @IBOutlet weak var searchBarCompany: UISearchBar!
    var  arrCompanydata = NSArray()
    var  arrSelectData = NSMutableArray()
    var arrAutosearchProduct = NSArray()
    var searchActive : Bool = false
    var Booool:Bool = true
    var floaty = Floaty()
    
    ////-----cell Selection var ---
    var MaxSelectArrayyy : NSMutableArray = []
    var addingvalue = 0
    var Boooolsss = true
    var BoolForFloaty = Bool()
    var BayerNameMainVar = String()
    var sellerNameMainVar = String()
    var addressIDMainVar = String()
    var selectedAddIndexArray = [0]
    var arrselectedLongPress = NSMutableArray()
    var floatyBooolsss = true
    var boolCheckLong = Bool()
    var generateSOOrder  = Int()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        arrGenerateSOID.removeAllObjects()
       // self.setNavigationBarItem()
        addUpdateOrder = (objInfo.permision.value(forKey: "CRM_ORDERREQUISITION_ADDUPDATE") as? Int)!
        generateSOOrder = (objInfo.permision.value(forKey: "CRM_ORDERREQUISITION_GENERATE_SALESORDER") as? Int)!
        self.layoutFAB()
        getORListing()
        tableeeORListScreen = tblCompanyList
        self.title = "Order Requisition"
        self.navigationItem.hidesBackButton = true
        searchBarCompany.delegate = self
        addDoneButtonOnKeyboard()
        SOListData = SOModel_List.GenrateSOModelData()
        tblCompanyList.allowsMultipleSelectionDuringEditing = true
        //-----------LongPressGestures in TableView Cell ------------------------------
        selectedAddIndexArray.removeAll()
        BayerNameMainVar = ""
        sellerNameMainVar = ""
        addressIDMainVar = ""
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.3 // 0.3 second press
        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
        self.tblCompanyList.addGestureRecognizer(longPressGesture)
        
        //----------------------pull----
        refreshiingBoooo = false
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.tblCompanyList.addSubview(refreshControl)
        for _ in 0..<ORListData.count
        {
            arrselectedLongPress.add("0")
        }
        ///-------End Gesture------------------
         let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(ORListScreen.back(sender:)))
         self.navigationItem.leftBarButtonItem = backButton
         tblCompanyList.allowsMultipleSelection = true
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //---handle pull refreshing data with api-----------
    @objc private func refreshWeatherData(_ sender: Any) {
        if Reachability.isConnectedToNetwork(){
            refreshControl.endRefreshing()
        getORListing()
        self.searchBarCompany.resignFirstResponder()
        searchBarCompany.text = ""
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    func handleLongPress(_ gesture: UILongPressGestureRecognizer)
    {
        if gesture.state == UIGestureRecognizerState.began
        {
            let touchPoint = gesture.location(in: tblCompanyList)
            if let indexPathss = tblCompanyList.indexPathForRow(at: touchPoint)
            {
                let model = ORListData[(indexPathss.row)]
                if model.status == "Pending SO"
                {
                    if selectedAddIndexArray.contains(indexPathss.row)  {
                        print("Yes")
                        if 0 < addingvalue  {
                            selectedAddIndexArray = selectedAddIndexArray.filter{$0 != indexPathss.row}
                            print(selectedAddIndexArray)
                            
                            ColorsArraySOList.remove(at: indexPathss.row)
                            ColorsArraySOList.insert("0", at: indexPathss.row)
                            
                            addingvalue -= 1
                            if addingvalue < MaxSelectArrayyy.count {
                                arrselectedLongPress.remove(MaxSelectArrayyy)
                                self.tblCompanyList.reloadRows(at: [indexPathss], with: .fade)
                                BoolForFloaty=false
                                
                            }
                        }
                    }
                    else
                    {
                        if addingvalue == 0
                        {
                            ColorsArraySOList.remove(at: indexPathss.row)
                            ColorsArraySOList.insert("1", at: indexPathss.row)
                            BayerNameMainVar = model.buyerOrganizationId
                            sellerNameMainVar = model.sellerOrganizationId
                            addressIDMainVar = model.addressId
                            addingvalue += 1
                            MaxSelectArrayyy.add(addingvalue)
                            arrselectedLongPress.add(MaxSelectArrayyy)
                            self.tblCompanyList.reloadRows(at: [indexPathss], with: .fade)
                            selectedAddIndexArray.append(indexPathss.row)
                            arrGenerateSOID.add(model.id)
                            strGenerateSOSalesType = model.salesTypeId
                            BoolForFloaty=false
                        }
                        else
                        {
                            if addingvalue  < MaxSelectArrayyy.count + 1
                            {
                                if model.buyerOrganizationId == BayerNameMainVar
                                {
                                    if  model.sellerOrganizationId == sellerNameMainVar
                                    {
                                        if model.addressId ==  addressIDMainVar
                                        {
                                            ColorsArraySOList.remove(at: indexPathss.row)
                                            ColorsArraySOList.insert("1", at: indexPathss.row)
                                            addingvalue += 1
                                            MaxSelectArrayyy.add(addingvalue)
                                            selectedAddIndexArray.append(indexPathss.row)
                                            arrselectedLongPress.add(MaxSelectArrayyy)
                                            arrGenerateSOID.add(model.id)
                                            print("arrGenerateSOID==",arrGenerateSOID)
                                            strGenerateSOSalesType = model.salesTypeId
                                            self.tblCompanyList.reloadRows(at: [indexPathss], with: .fade)
                                            
                                        }
                                    }
                                }
                                else
                                {
                                    self.tblCompanyList.reloadRows(at: [indexPathss], with: .fade)
                                    let alert = UIAlertController(title: "Please Select Same Address, Buyer and Seller Name. ", message: "Order Requisition.", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                    
                                }
                            }
                            
                        }
                    }
                    
                }
                self.tblCompanyList.reloadRows(at: [indexPathss], with: .fade)
                if addingvalue == 0
                    //|| addingvalue == 1
                {
                    layoutFAB()
                }
                else
                {
                    floatiTrueee()
                }
            }
            tblCompanyList.reloadData()
        }
    }
    func filterTableView(text:String) {
        ORFIlterData = ModelORList.generateORModelArray()//.generateORModelArray()
        ORListData = ORFIlterData.filter({ (mod) -> Bool in
            return mod.buyerOrganizationName.lowercased().contains(text.lowercased()) || mod.sellerOrganizationName.lowercased().contains(text.lowercased()) || mod.orNumber.lowercased().contains(text.lowercased()) || mod.creatorName.lowercased().contains(text.lowercased()) || mod.createdDate.lowercased().contains(text.lowercased()) || mod.status.lowercased().contains(text.lowercased())
        })
        self.tblCompanyList.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText.isEmpty {
            ORListData = ORFIlterData
            tblCompanyList.reloadData()
        }
        else
        {
            filterTableView(text: searchText)
        }
    }
    @IBAction func btnFilterTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        let objReg=self.storyboard?.instantiateViewController(withIdentifier: "OR_Filter") as! OR_Filter
        self.navigationController?.pushViewController(objReg, animated: true)
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    //MARK: - For floting method=============================
    
    func layoutFAB()
    {
        floaty.items.removeAll()
        if addUpdateOrder==1{
        floaty.addItem("Create OR", icon: UIImage(named: "create_or"))
        {
            item in
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "Create_OR") as! Create_OR
            objReg.visitId=0
            objReg.visitCreateOR = false
            //objReg.isOrgSet=false
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        }
        floaty.paddingX = 20
        floaty.paddingY = 20
        floaty.fabDelegate = self as? FloatyDelegate
        self.view.addSubview(floaty)
    }
    
    func floatiTrueee()
    {
        floaty.items.removeAll()

        if generateSOOrder==1{
        floaty.addItem("Generate SO", icon: UIImage(named: "genrete_SO"))
        {
            item in
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "GenerateSalesOrder") as! GenerateSalesOrder
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        }
         if addUpdateOrder==1{
        floaty.addItem("Create OR", icon: UIImage(named: "create_or"))
        {
            item in
            let objReg=self.storyboard?.instantiateViewController(withIdentifier: "Create_OR") as! Create_OR
            objReg.visitCreateOR = false
            objReg.visitId=0
            //objReg.isOrgSet=false
            self.navigationController?.pushViewController(objReg, animated: true)
        }
        }
        floaty.paddingX = 20
        floaty.paddingY = 20
        floaty.fabDelegate = self as? FloatyDelegate
        self.view.addSubview(floaty)
    }
    
    
    func back(sender: UIBarButtonItem)
    {
        ORListData = ORFIlterData
        tblCompanyList.reloadData()
                _ = navigationController?.popViewController(animated: true)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView:  UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if ORListData.count==0{
            return 1
        }
        else{
            return ORListData.count
        }
        // return 15
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ORListCell
        if ColorsArraySOList.count != 0 {
        if  ColorsArraySOList[indexPath.row] == "0"
        {
            cell.backgroundColor = UIColor.white
        }
        else
        {
            cell.backgroundColor = UIColor(red: 0/255, green: 152/255, blue: 199/255, alpha: 0.3)
        }
        }
        if ORListData.count==0{
            cell.lblBuyerOrgName.text = "No Products Available"
            cell.lblSellerOrgName.isHidden=true
            cell.createDate.isHidden=true
            cell.creatorName.isHidden=true
            cell.lblSellerOrgName.isHidden=true
            cell.orNumber.isHidden=true
            cell.lblSataus.isHidden=true
            cell.btntotalAmount.isHidden=true
            cell.lblSalesType.isHidden=true
        }
        else{
            cell.lblSellerOrgName.isHidden=false
            cell.createDate.isHidden=false
            cell.creatorName.isHidden=false
            cell.lblSellerOrgName.isHidden=false
            cell.orNumber.isHidden=false
            cell.lblSataus.isHidden=false
            cell.btntotalAmount.isHidden=false
            cell.lblSalesType.isHidden=false
            let model = ORListData[indexPath.row]
            cell.lblBuyerOrgName.text = model.buyerOrganizationName
            cell.lblSellerOrgName.text = model.sellerOrganizationName
            cell.createDate.setTitle(model.createdDate, for: UIControlState.normal)
            cell.creatorName.setTitle(model.creatorName, for: UIControlState.normal)
            cell.orNumber.text = model.orNumber
            cell.lblSataus.text = model.status
            
            if model.status=="Pending SO"
            {
                cell.lblSataus.backgroundColor=UIColor(red: 44/255, green: 123/255, blue: 180/255, alpha: 1.0)
            }
            else if model.status=="Cancelled"
            {
                cell.lblSataus.backgroundColor=UIColor(red: 218/255, green: 82/255, blue: 82/255, alpha: 1.0)
            }
            else if model.status=="Draft"
            {
                cell.lblSataus.backgroundColor=UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
            }
            else if model.status=="SO Created"
            {
                cell.lblSataus.backgroundColor=UIColor(red: 93/255, green: 189/255, blue: 98/255, alpha: 1.0)
            }
            else
            {
                cell.lblSataus.backgroundColor=UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            }
            cell.lblSalesType.text = model.salesTypeName
            cell.btntotalAmount.setTitle(model.currencySymbol + " " + "\( model.totalAmount)", for: UIControlState.normal)
        }
        return cell
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }
    func doneButtonAction()
    {
        searchBarCompany.text = ""
        if (searchBarCompany.text?.isEmpty)! {
              ORFIlterData = ORListData
            tblCompanyList.reloadData()
        }
        else
        {
            filterTableView(text: searchBarCompany.text!)
        }
        self.searchBarCompany.resignFirstResponder()
    }
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ORListScreen.doneButtonAction))
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        doneToolbar.items = items as? [UIBarButtonItem]
        doneToolbar.sizeToFit()
        self.searchBarCompany.inputAccessoryView = doneToolbar
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if ORListData.count != 0{
            let model = ORListData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ORListCell
            if ColorsArraySOList.count != 0 {
                if  ColorsArraySOList[indexPath.row] == "0"
                {
                    cell.backgroundColor = UIColor.white
                    print(model.id)
                    let objReg=self.storyboard?.instantiateViewController(withIdentifier:"ORProfile") as! ORProfile
                    //            objReg.orListId = model.id as NSString
                    objReg.orListId =  model.id.stringValue as NSString
                    objReg.orSalesTypeId=model.salesTypeId as NSString
                    self.navigationController?.pushViewController(objReg, animated: true)
                }
                else
                {
                 cell.backgroundColor = UIColor.white
                    ColorsArraySOList.remove(at: indexPath.row)
                    ColorsArraySOList.insert("0", at: indexPath.row)
                    layoutFAB()
                    tblCompanyList.reloadData()
                }
            }
            
            
        }
    }
}


