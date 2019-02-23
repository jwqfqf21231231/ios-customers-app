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
    static let Register = "http://mapi.fusion.ps/api/Account/Register"
    
    //    Login Exist Users
    static let login = "http://mapi.fusion.ps/token"
    
    //    Bit History By UserName
    static let getBinHistory = URL + "Users/GetUserPinHistory"
    
    //    User Profile
    static let userProfile = "http://mapi.fusion.ps/api/Users/GetUserProfile"
    
    //    Account History
    static let AccountHisotry = "http://mapi.fusion.ps/api/Users/GetUserAccountHistory"
    
    //   Bad History
    static let BadHisotry = "http://mapi.fusion.ps/api/Users/GetUserBadHistory?"

    
    // Get Hamla Price
    static let Price = "http://mapi.fusion.ps/api/Values/GetHamlaPrice"
    
   
    // CheckExitOverDownload
    static let CheckExit = "http://mapi.fusion.ps/api/Users/CheckExitOverDownload"
    
    //    ExitOverDownload
    static let ExitOverDown = "http://mapi.fusion.ps/api/Users/ExitOverDownload"
    
    
    // CheckUser
    static let CheckUser = "http://mapi.fusion.ps/api/Users/CheckUsermobile?"
    
    
    // GetHamlaList
    static let GetHamlaList = "http://mapi.fusion.ps/api/Users/GetHamlatList?userID="
    
    
//     GetHamlaSpeed
    static let GetHamlaSpeed = "http://mapi.fusion.ps/api/Users/GetHamlaSpeed?hamlaid="
    
    
//    GetPeriod
    static let GetHamlaPeriod = "http://mapi.fusion.ps/api/Users/GetHamlaPeriod?hamlaid="
    
//    AddPending
    static let AddPending = "http://mapi.fusion.ps/api/Users/AddPending?userid=082853838&hamlaid=104&speedid=120&Month=12"
    
}
