
import UIKit

var TertiaryDicData = NSMutableArray()
var TertiaryData = [ModelTetiaryList]()
var TertiaryFilterData = [ModelTetiaryList]()

class ModelTetiaryList: NSObject {
    var id : Int = Int()
    var tSaleNo : String = String()
    var CreatedBy : String = String()
    var OutletName : String = String()
    var tSaleStock : Double = Double()
    var tSaleStatus : String = String()
    var tSaleDate : String = String()
    
    init(id:Int,tSaleNo:String,CreatedBy:String,OutletName:String,tSaleStock:Double,tSaleStatus:String,tSalesDate:String) {
        self.id = id
        self.tSaleNo = tSaleNo
        self.CreatedBy = CreatedBy
        self.OutletName = OutletName
        self.tSaleStock = tSaleStock
        self.tSaleStatus = tSaleStatus
        self.tSaleDate = tSalesDate
    }
       class func generateTertiaryListArray() -> [ModelTetiaryList]{
            var ModelTertiaryArray = [ModelTetiaryList]()
            for i in 0..<TertiaryDicData.count
            {
                let idDD = (TertiaryDicData.object(at: i) as! NSDictionary).value(forKey: "id") as! Int
                let tSalesNoDD = (TertiaryDicData.object(at: i) as! NSDictionary).value(forKey: "tSaleNo") as! String
                let CreatedByDD = (TertiaryDicData.object(at: i) as! NSDictionary).value(forKey: "createdBy") as! String
                let outletnameDD = (TertiaryDicData.object(at: i) as! NSDictionary).value(forKey: "outletName") as! String
                let tSaleStockDD = (TertiaryDicData.object(at: i) as! NSDictionary).value(forKey: "tSaleStock") as! Double
                let tSaleStatusDD = (TertiaryDicData.object(at: i) as! NSDictionary).value(forKey: "tSaleStatus") as! String
                let tSaleDateDD = (TertiaryDicData.object(at: i) as! NSDictionary).value(forKey: "tSaleDate") as! String
                
                ModelTertiaryArray.append(ModelTetiaryList(id: idDD, tSaleNo: tSalesNoDD, CreatedBy: CreatedByDD, OutletName: outletnameDD, tSaleStock: tSaleStockDD, tSaleStatus: tSaleStatusDD, tSalesDate: tSaleDateDD))
            }
            return ModelTertiaryArray
        }
    }
