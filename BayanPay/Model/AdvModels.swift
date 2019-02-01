////
////  AdvModels.swift
////  BayanPay
////
////  Created by Mohanad on 1/27/19.
////  Copyright © 2019 Paypal. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SwiftyJSON
//class AdvModels: NSObject, NSCopying{
//    
//    func copy(with zone: NSZone? = nil) -> Any {
//        let copiedTask = AdvModel(self.ID)
//        return copiedTask
//    }
//    
//    var ID : Int
//    var type : String
//    var ShortImage : String
//    var name :String
//    var Image: String
//    var Deatails: String
//    var Conditions: String
//    var ExpireDate: String
//    
//    init(ID: Int = 0, type: String,ShortImage: String, name:String, Image:String,Deatails:String,Conditions:String,ExpireDate:String) {
//        self.ID = ID
//        self.Conditions = Conditions
//        self.ShortImage = ShortImage
//        self.Image = Image
//        self.Deatails = Deatails
//        self.ExpireDate = ExpireDate
//        self.type = type
//    }
//    init?(dict: [String: JSON]) {
//        guard let ID = dict["ID"]?.to Int, let Adv = dict["Adv"]?.string else { return nil }
//        
//        self.ID = ID
//        self.ShortImage = dict["ShortImage"]?.string ?? ""
//        self.ShortImage = dict["Image"]?.string ?? ""
//        self.Conditions = dict["Conditions"]?.string ?? ""
//        self.Deatails = dict["Deatails"]?.string ?? ""
//    }
//}
