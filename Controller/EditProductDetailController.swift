

import UIKit
var CartValueArray  = NSMutableArray()

class EditProductDetailController: UIViewController {

    @IBOutlet weak var txtBox: RoundTextField!
    @IBOutlet weak var txtProductName: RoundTextField!
    @IBOutlet weak var txtBarCode: RoundTextField!
    @IBOutlet weak var txtCartValue: RoundTextField!
    
    var ProducatNameArray = NSMutableArray()
    var BarCodeArray      = NSMutableArray()
    var BoxValueArray     = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Back_icon"), landscapeImagePhone: #imageLiteral(resourceName: "Back_icon"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(EditProductDetailController.back(sender:)))
        self.navigationItem.leftBarButtonItem = backButton

        print("ProducatNameArray::: ",ProducatNameArray,"BarCodeArray::: ",BarCodeArray,"CartValueArray::: ",CartValueArray,"BoxValueArray::: ",BoxValueArray)
        
        txtProductName.text = "\(ProducatNameArray[0])"
        txtCartValue.text   = "\(CartValueArray[0])"
        txtBox.text         = "\(BoxValueArray[0])"
        txtBarCode.text     = "\(BarCodeArray[0])"
    }
    
    @IBAction func btnSave(_ sender: Any)
    {
        print(arrParameterSecondaryMain[Extradata])
        (arrParameterSecondaryMain[Extradata] as! NSMutableDictionary).removeObject(forKey: "quantity")
        print(arrParameterSecondaryMain)
        (arrParameterSecondaryMain[Extradata] as! NSMutableDictionary).setValue(Int(txtCartValue.text!), forKey: "quantity")
         print(arrParameterSecondaryMain)
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCancel(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func back(sender: UIBarButtonItem) {
        
        _ = navigationController?.popViewController(animated: true)
    }
    

    
}
