//
//  SharedManager.swift
//  DemoCheckList
//
//  Created by i-Phone14 on 11/10/16.
//  Copyright © 2016 Trainee2. All rights reserved.
//

import UIKit

final class SharedManager: NSObject {
    static let sharedInstance = SharedManager()
    var cache: NSCache<AnyObject, AnyObject>=NSCache.init()
    var strUserId:NSNumber=NSNumber()
//    static let sharedInstance : SharedManager = {
//        let instance = SharedManager(array: [])
//        return instance
//    }()
//    
//    //MARK: Local Variable
//    
//    var emptyStringArray : [String]
//    
//    //MARK: Init
//    
//    init( array : [String]) {
//        emptyStringArray = array
//    }
}

