
import UIKit
var ORDicData:NSArray = NSArray()
var ORFIlterData = [ModelORList]()
var ORListData = [ModelORList]()
var ColorsArraySOList:[String] = NSMutableArray() as! [String]


class ModelORList: NSObject
{
    var sellerOrganizationName: String = ""
    var buyerOrganizationName: String = ""
    var orNumber: String = ""
    var buyerLogoName: String = ""
    var buyerContentType: String = ""
    var salesTypeName: String = ""
    var creatorName: String = ""
    var createdDate: String = ""
    var currencySymbol : String = ""
    var status: String = ""
    var id: NSNumber = 0
    var sellerOrganizationId : String = ""
    var buyerOrganizationId : String = ""
    var buyerLogoId : String = ""
    var salesTypeId : String = ""
    var totalAmount : String = ""
    var addressId : String = ""
    init(sellerOrganizationName:String,buyerOrganizationName:String,orNumber:String,buyerLogoName:String,buyerContentType:String,salesTypeName:String,creatorName:String,status:String,id:NSNumber,currencySymbol:String,sellerOrganizationId:String,buyerOrganizationId:String,addressId:String,buyerLogoId:String,salesTypeId:String,createdDate:String,totalAmount:String)
    {
        self.sellerOrganizationName = sellerOrganizationName
        self.buyerOrganizationName = buyerOrganizationName
        self.orNumber = orNumber
        self.buyerLogoName = buyerLogoName
        self.buyerContentType = buyerContentType
        self.salesTypeName = salesTypeName
        self.creatorName = creatorName
        self.status = status
        self.createdDate = createdDate
        self.currencySymbol = currencySymbol
        self.id = id
        self.sellerOrganizationId = sellerOrganizationId
        self.buyerOrganizationId = buyerOrganizationId
        self.buyerLogoId = buyerLogoId
        self.salesTypeId = salesTypeId
        self.totalAmount = totalAmount
        self.addressId=addressId
    }
    class func generateORModelArray() -> [ModelORList]{
      var modelAry = [ModelORList]()
        ColorsArraySOList.removeAll()
        for i in 0..<ORDicData.count
        {
            ColorsArraySOList.append("0")
            let id = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "id") as! NSNumber
            let sellerOrganizationId = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "sellerOrganizationId") as! Int
            let buyerOrganizationId = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "buyerOrganizationId") as! Int
            let addressId = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "addressId") as! Int
            let buyerLogoId = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "buyerLogoId") as! Int
            let salesTypeId = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "salesTypeId") as! Int
            let totalAmount = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "totalAmount") as! Double
            let sellerOrganizationName =  (ORDicData.object(at: i) as! NSDictionary).value(forKey: "sellerOrganizationName") as! String
            let buyerOrganizationName = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "buyerOrganizationName") as! String
            let orNumber = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "orNumber") as! String
            let buyerLogoName = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "buyerLogoName") as! String
            let buyerContentType = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "buyerContentType") as! String
            let salesTypeName = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "salesTypeName") as! String
            let creatorName = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "creatorName") as! String
            let status = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "status") as! String
            let createdDate = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "createdDate") as! String
            let currencySymbol = (ORDicData.object(at: i) as! NSDictionary).value(forKey: "currencySymbol") as! String
            modelAry.append(ModelORList(
                sellerOrganizationName: sellerOrganizationName, buyerOrganizationName: buyerOrganizationName,orNumber: orNumber, buyerLogoName: buyerLogoName,  buyerContentType: buyerContentType, salesTypeName: salesTypeName, creatorName: creatorName,status: status, id: id, currencySymbol: currencySymbol, sellerOrganizationId: String(sellerOrganizationId), buyerOrganizationId: String(buyerOrganizationId),addressId:String(addressId),  buyerLogoId: String(buyerLogoId), salesTypeId: String(salesTypeId), createdDate: String(createdDate),totalAmount: String(totalAmount)))
            
        }
        return modelAry
    }
}


//Mark : Select Product Model
var SelectProductData = [SelectProductModel]()
var SelectProductDataFilter = [SelectProductModel]()

class SelectProductModel: NSObject {
    var id = Int64()
    var name = String()
    var PriBpri = Double()
    var Sky = String()
    var MeasermentName = String()
    var CategoryName = String()
    var CurrencySymbol = String()
    
    init(id:Int64,name:String,PriBpri:Double,sku:String,measermentName:String,categoryName:String,currencySymbol:String) {
        self.id = id
        self.name = name
        self.PriBpri = PriBpri
        self.Sky = sku
        self.CategoryName = categoryName
        self.MeasermentName = measermentName
        self.CurrencySymbol = currencySymbol
    }
    
    class func genrateORSelectProductArray() -> [SelectProductModel]{
        var modelAry = [SelectProductModel]()
    
        for i in 0..<arrayProductLists.count
        {
            let proID = (arrayProductLists.object(at: i) as! NSDictionary).value(forKey: "productId") as! Int64
            let PriBookPri = (arrayProductLists.object(at: i) as! NSDictionary).value(forKey: "basicPrices") as! Double
            var ProName = (arrayProductLists.object(at: i) as! NSDictionary).value(forKey: "productName") as! String
            if ProName == ""{ ProName = "NA"}
            var skuuu = (arrayProductLists.object(at: i) as! NSDictionary).value(forKey: "sku") as! String
            if skuuu == "" {skuuu = "NA"}
            var Measer = (arrayProductLists.object(at: i) as! NSDictionary).value(forKey: "measurementName") as! String
            if Measer == "" { Measer = ""}
            var C_Name = (arrayProductLists.object(at: i) as! NSDictionary).value(forKey: "productCategoryName") as! String
            if C_Name == ""{ C_Name = "NA"}
            var CurencySymboal = (arrayProductLists.object(at: i) as! NSDictionary).value(forKey: "currencySymbol") as! String
            if CurencySymboal == ""{  CurencySymboal = "NA" }
            modelAry.append(SelectProductModel(id: proID, name: ProName, PriBpri: PriBookPri, sku: skuuu, measermentName: Measer , categoryName: C_Name, currencySymbol: CurencySymboal))
        }
        return modelAry
    }
}


//Mark : Select Link Pending OR Model : Creat Side

class LinkPendinOR: NSObject {
    // Linked OR finale Dictionary
    static var LinkedFinaleArray = NSMutableArray()
    //Salse Type ID : use in LinkPendinOR
    static var salesTypeID = Int()
    //Product Collection Array
    static var ProductMargArray = NSMutableArray()
    static var PrdocutFinalMargArray = NSMutableArray()
    //value
    static var ProductID = NSMutableArray()
    static var ProductIDSelect = NSMutableArray()
    static var ProductName = NSMutableArray()
    static var ProductSelectName = NSMutableArray()
    //Data
    static var PendinORList = NSArray()
    static var SelectLinnkPendingData = [LinkPendinOR]()
    static var SelectLinnkPendingDataFilter = [LinkPendinOR]()
    //search select structure
    var id = Int64()
    var name = String()
    
    init(id:Int64,name:String) {
        self.id = id
        self.name = name
    }
    
    class func genrateLinkPendingORArray() -> [LinkPendinOR]{
        var modelAry = [LinkPendinOR]()
        
        for i in 0..<PendinORList.count
        {
            let ID = (PendinORList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int64
            let orNumber = (PendinORList.object(at: i) as! NSDictionary).value(forKey: "orNumber") as! String
            
            modelAry.append(LinkPendinOR(id: ID, name: orNumber))
        }
        return modelAry
    }
}



//Mark : Select Link Pending OR Model : Update Side
class LinkPendinORUpdate: NSObject {
    // Linked OR finale Dictionary
    static var LinkedFinaleArray = NSMutableArray()
    
    //Salse Type ID : use in LinkPendinOR
    static var salesTypeID = Int()
    
    //Product Collection Array
    static var ProductMargArray = NSMutableArray()
    static var PrdocutFinalMargArray = NSMutableArray()
    static var ProductProfileDataMain = NSArray()
    //value
    static var ProductID = NSMutableArray()
    static var ProductIDSelect = NSMutableArray()
    static var ProductName = NSMutableArray()
    static var ProductSelectName = NSMutableArray()
    
    //Data
    static var PendinORList = NSArray()
    static var SelectLinnkPendingData = [LinkPendinORUpdate]()
    static var SelectLinnkPendingDataFilter = [LinkPendinORUpdate]()
    
    //search select structure
    var id = Int64()
    var name = String()
    
    init(id:Int64,name:String) {
        self.id = id
        self.name = name
    }
    
    class func genrateLinkPendingORUpdateArray() -> [LinkPendinORUpdate]{
        var modelAry = [LinkPendinORUpdate]()
        
        for i in 0..<PendinORList.count
        {
            let ID = (PendinORList.object(at: i) as! NSDictionary).value(forKey: "id") as! Int64
            let orNumber = (PendinORList.object(at: i) as! NSDictionary).value(forKey: "orNumber") as! String
            
            modelAry.append(LinkPendinORUpdate(id: ID, name: orNumber))
        }
        return modelAry
    }
}

