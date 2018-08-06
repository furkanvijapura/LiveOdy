

import Foundation
import UIKit

struct Constant {
    static var BoolServer = Bool()
    //MARK:- Screen Width/Height MACRO
    static let SCREEN_WIDTH=UIScreen.main.bounds.width
    

   
    
    //validAuth/authenticateForMobile
    
//    static let ApiName =    [NSString, stringWithFormat,:"%@/%@",WEBSERVICE_URL,ApiName]
    
//    static let ApiName =    String .localizedStringWithFormat("%@/%@", WEBSERVICE_URL)


    //MARK:- Request Params MACRO For login
    
    // For Login
    static let ksites  = "sites"
    static let Ksite =  "site"
    static let ktoken  = "token"
    static let kUserId = "userId"
    static let kpermissions  = "permissions"
    static let kuserName = "userName"
    static let kconfigurations = "configurations"
    static let kroleName  = "roleName"
    static let KlogoUrl =  "logoUrl"
    static let kcashflowConfigurations  = "cashflowConfigurations"
    static let kprofileLogoLink  = "profileLogoLink"
    
    
    static let kUserName  = "username"
    static let Kpassword =  "password"
    static let kBrowser  = "browser"
    static let kDevice  = "device"
    static let kOS = "os"
    static let kVersion = "version"

    //MARK:- Request Params MACRO
//    static let kMobileNo="mobileNo"
//    static let kPassword="password"
//    static let kMode="mode"
//    static let kRegister="Register"
//    static let kLogin="Login"
//    static let kDeviceId="deviceId"
//    static let kDeviceType="deviceType"
//    static let kFullName="fullName"
//    static let kEmailAddress="emailAddress"
//    static let kConfirmPassword="confirmPassword"
//    static let kProfileImage="profileImage"
    
    //MARK:- Shared Manager MACRO
    static let ShareOBJ=SharedManager .sharedInstance
    
    //MARK:- Profile Image URL MACRO
    static func ProfileImgURL(strUserId:String)->String {
    return strUserId
    }
}
//enum Constant{
//          static let WEBSERVICE_URL = "http://internal-testing.discus.solutions:8180/discus-cloud-web/rs/"
//          static let WEBSERVICE_URLGetImage = "http://internal-testing.discus.solutions:8180/discus-cloud-web/"
//          static let WEBSERVICE_URLUploadImage = "http://internal-testing.discus.solutions:8180/discus-cloud-web/fileservice/logo/"
//}

