
import UIKit

class OR_Filter: UIViewController
{
    var arrSalesTypeList = NSArray()
    var arrOrgList = NSArray()
    var arrPeopleList = NSArray()
    var arrStatusList = NSArray()
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let datePickerTo = UIDatePicker()
    let dateFormatterTo = DateFormatter()

    @IBOutlet var txtOrgName: UITextField!
    @IBOutlet var txtTo: ImageTextField!
    @IBOutlet var txtSalsType: ImageTextField!
    @IBOutlet var txtStatus: UITextField!
    @IBOutlet var txtPeople: ImageTextField!
    @IBOutlet var txtFrom: ImageTextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title="Order Requisition Filter"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(OR_Filter.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
        orFilterSalesTypeMain = ""
        orFilterOrgNameMain = ""
        orFilterStatusMain = ""
        orFilterBuyerNameMain = ""
        datePicker.datePickerMode = UIDatePickerMode.date
        datePickerTo.datePickerMode = UIDatePickerMode.date
        dateFormatter.dateFormat = "dd MMM yyyy"
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        dateFormatterTo.dateFormat = "dd MMM yyyy"
        datePickerTo.addTarget(self, action: #selector(handleDatePickerTo(sender:)), for: UIControlEvents.valueChanged)
        txtFrom.inputView=datePicker
        txtTo.inputView=datePickerTo
         txtFrom.text = dateFormatter.string(from: datePicker.date)
         txtTo.text = dateFormatterTo.string(from: datePickerTo.date)
        txtFrom.setDoneOnKeyboard()
        txtTo.setDoneOnKeyboard()
         getORFilterListing()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleDatePicker(sender: UIDatePicker) {
        txtFrom.text = dateFormatter.string(from: datePicker.date)
    }
    func handleDatePickerTo(sender: UIDatePicker) {
        txtTo.text = dateFormatterTo.string(from: datePickerTo.date)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        txtOrgName.text=orFilterOrgNameMain
        txtSalsType.text=orFilterSalesTypeMain
        txtStatus.text=orFilterStatusMain
        txtPeople.text=orFilterBuyerNameMain

    }
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnOrgNameTapped(_ sender: Any)
    {
        let destination1=self.storyboard?.instantiateViewController(withIdentifier: "SelectOrgNameList") as! SelectOrgNameList
        self.present(destination1, animated: false, completion: nil)
    }
    @IBAction func btnSalesTapped(_ sender: Any)
    {
        let destination1=self.storyboard?.instantiateViewController(withIdentifier: "SelectSalesTypeList") as! SelectSalesTypeList
        self.present(destination1, animated: false, completion: nil)
    }
    @IBAction func btnStatusTapped(_ sender: Any)
    {
        let destination1=self.storyboard?.instantiateViewController(withIdentifier: "SelectStatusList") as! SelectStatusList
        self.present(destination1, animated: false, completion: nil)
    }
    @IBAction func btnPeopleTapped(_ sender: Any)
    {
        let destination1=self.storyboard?.instantiateViewController(withIdentifier: "SelectFilterBuyerNameList") as! SelectFilterBuyerNameList
        self.present(destination1, animated: false, completion: nil)
    }
    @IBAction func btnCancelTapped(_ sender: Any)
    {
        _ = navigationController?.popViewController(animated: true)
    }
    func getORFilterListing()
    {
        if Reachability.isConnectedToNetwork(){
         START_INDICATOR()
        APISession.getDataWithRequest( withAPIName: "orderRequisition/filter")
        {
            (response, permissions) in
            print(("",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let orFilterList : NSDictionary = response! .value(forKey: "orFilter") as! NSDictionary
                ORFilterSalesList = orFilterList.value(forKey: "salesType") as! NSArray
                ORFilterOrgList = orFilterList.value(forKey: "organizationName") as! NSArray
                ORFilterStatusList = orFilterList.value(forKey: "status") as! NSArray
                ORFilterBuyerNameList = orFilterList.value(forKey: "people") as! NSArray

                //ORDicData=orList
                //ORListData.removeAll()
                //ORListData = ModelORList.generateORModelArray()
               // print("ORDicData :: ",ORDicData)
                //tableeeORListScreen.reloadData()
            }
        }
        }
    }

    func ORFilterAPICalling()
    {
        if Reachability.isConnectedToNetwork(){
         START_INDICATOR()
        let objDic:NSMutableDictionary=NSMutableDictionary.init()
        objDic .setValue(txtFrom.text, forKey:"fromDateStr")
        objDic .setValue(txtTo.text, forKey:"toDateStr")
        objDic .setValue(orFilterSalesTypeIDMain, forKey:"saleTypeId")
        objDic .setValue(orFilterStatusIDMain, forKey:"statusId")
        objDic .setValue(orFilterBuyerIDMain, forKey:"createdBy")
        APISession.postDataWithRequestwithTokenDelete(objDic, withAPIName: "orderRequisition/list") { (response, isVisit)
            in
            print(("Response is......",response))
            self.STOP_INDICATOR()
            if response != nil
            {
                let status = response?.value(forKey: "status") as! NSNumber
                if status != 0
                {
                let orList : NSArray = response! .value(forKey: "orList") as! NSArray
                ORDicData=orList
                ORListData.removeAll()
                ORListData = ModelORList.generateORModelArray()
                print("ORDicData :: ",ORDicData)
                tableeeORListScreen.reloadData()
               // self.navigationController?.popToRootViewController(animated: true)
                   self.navigationController?.popViewController(animated: true)
                }
                else{
                    let message = response?.value(forKey: "message") as! String
                   self.displayAlertMessage(messageToDisplay: message)
                }
            }
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }
    }
    @IBAction func btnSaveTapped(_ sender: Any)
    {
        if Reachability.isConnectedToNetwork(){
        if txtFrom.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select from data....")
        }
        else if txtTo.text == ""
        {
            displayAlertMessage(messageToDisplay: "Please select to date....")
        }

        else{
       ORFilterAPICalling()
        }
        }
        else
        {
//            self.displayAlertMessage(messageToDisplay: "Internet connection not available!")
            ShowAlertInterConnection()
        }

    }

}
