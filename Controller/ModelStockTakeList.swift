

import UIKit
var StockTakeDicData: NSArray = NSArray()
var StockTakeData = [ModelStockTakeList]()
var StockTakeFilterData = [ModelStockTakeList]()
class ModelStockTakeList: NSObject
{
    var stockTakNo : String = ""
    var CreatedBy : String = ""
    var OutletName :  String = ""
    var StockTakeDate : String = ""
    var StockTakeVariance : String = ""
    
    init(StockTakeNO:String,CreatedBy:String,OutletName:String,StockTakeDate:String,StockTakeVariance:String) {
    
        self.stockTakNo = StockTakeNO
        self.CreatedBy = CreatedBy
        self.OutletName = OutletName
        self.StockTakeDate = StockTakeDate
        self.StockTakeVariance = StockTakeVariance
    }
    class func generateStockTakeArray() -> [ModelStockTakeList]{
        var ModelStockTake = [ModelStockTakeList]()
        for i in 0..<StockTakeDicData.count
        {
            let tStockTakeNoFF = (StockTakeDicData.object(at: i) as! NSDictionary).value(forKey: "tStockTakeNo") as! String
            let createdByFF = (StockTakeDicData.object(at: i) as! NSDictionary).value(forKey: "createdBy") as! String
            let outletNameFF = (StockTakeDicData.object(at: i) as! NSDictionary).value(forKey: "outletName") as! String
            let tStockTakeDateFF = (StockTakeDicData.object(at: i) as! NSDictionary).value(forKey: "tStockTakeDate") as! String
            let tStockTakeVarianceFF = (StockTakeDicData.object(at: i) as! NSDictionary).value(forKey: "tStockTakeVariance") as! String
            
            ModelStockTake.append(ModelStockTakeList(StockTakeNO: tStockTakeNoFF, CreatedBy: createdByFF, OutletName: outletNameFF, StockTakeDate: tStockTakeDateFF, StockTakeVariance: tStockTakeVarianceFF))
        }
        return ModelStockTake
    }

}
