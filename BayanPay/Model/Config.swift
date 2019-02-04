//
//  Config.swift
//  BayanPay
//
//  Created by Mohanad on 1/16/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import Foundation
struct Urls {
    
    //    Header
    static let header: [String:String] = ["Content-Type" : "application/x-www-form-urlencoded"]
    
    //    Main URL For API
    static let URL = "http://mapi.fusion.ps/api/"
    
    //    Get Hamlat Out OF Aouth
    static let getOutAdvs = "http://mapi.fusion.ps/api/Values/GetHamlat"
    
    //    Register New User
    static let Register = URL + "/Account/Register"
    
    //    Login Exist Users
    static let login = "http://mapi.fusion.ps/token"
    
    //    Bit History By UserName
    static let getBinHistory = URL + "Users/GetUserPinHistory"
    
    //    User Profile
    static let userProfile = "http://mapi.fusion.ps/api/Users/GetUserProfile"
    
    //    Account History
    static let AccountHisotry = "http://mapi.fusion.ps/api/Users/GetUserAccountHistory"
    
    // Get Hamla Price
    static let Price = "http://mapi.fusion.ps/api/Values/GetHamlaPrice"
    
    //    Bad History URL
    static let BadHistory = "http://mapi.fusion.ps/api/Users/GetUserBadHistory"
    var HamlaID:Int = 0
}
