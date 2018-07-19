
import UIKit

var addressNameLable = NSString()
var diliveryidNUmber = NSNumber()

class DilevryAdressPopUp: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var addressNameLableNil = NSString()
    var diliveryidNUmberNil = NSNumber()
    var arrayDiliveryAddress = NSArray()
    @IBOutlet weak var tblDilevry: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.title = "Delivery Address"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDiliveryAddress.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tblDilevry.dequeueReusableCell(withIdentifier: "cell") as! DilevryAdress
        let objData : NSDictionary = self.arrayDiliveryAddress[indexPath.row] as! NSDictionary
        let mainName : String = (objData.value(forKey: "labelAs") as? String)!
        let address : String = (objData.value(forKey: "shipTo") as? String)!
        if arrayDiliveryAddress.count==1
        {
            let uncheckImage = UIImage(named:"Login_Checkbox")
            let unchecker = UIImageView(image: uncheckImage)
            cell.accessoryView = unchecker
        }
        else{
        let uncheckImage = UIImage(named:"Login_UnCheckbox")
        let unchecker = UIImageView(image: uncheckImage)
        cell.accessoryView = unchecker
        }
        cell.lblOrgName.text=mainName
        cell.lblOrgAddress.text=address
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let uncheckImage = UIImage(named:"Login_Checkbox")
        let unchecker = UIImageView(image: uncheckImage)
        tableView.cellForRow(at: indexPath)?.accessoryView = unchecker
        
        let objData : NSDictionary = self.arrayDiliveryAddress[indexPath.row] as! NSDictionary
        let addressName : String = (objData.value(forKey: "labelAs") as? String)!
        addressNameLableNil = addressName as NSString
        let addressId : NSNumber = (objData.value(forKey: "id") as? NSNumber)!
        print(addressName,addressId)
        diliveryidNUmberNil = addressId
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let uncheckImage = UIImage(named:"Login_UnCheckbox")
        let unchecker = UIImageView(image: uncheckImage)
        tableView.cellForRow(at: indexPath)?.accessoryView = unchecker
    }
    
    func tableView(_ tableView:  UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 85
    }
    @IBAction func btnSelectAddressTapped(_ sender: Any)
    {
    }
    @IBAction func btnCancel(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSaveTapped()
    {
    }
    @IBAction func btnSave(_ sender: Any)
    {
        addressNameLable = addressNameLableNil
        diliveryidNUmber = diliveryidNUmberNil
        dismiss(animated: true, completion: nil)
    }
    
}
