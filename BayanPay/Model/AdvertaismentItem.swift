//
//  AdvertaismentItem.swift
//  BayanPay
//
//  Created by Mohanad on 1/21/19.
//  Copyright © 2019 Paypal. All rights reserved.
//


import UIKit

struct AdvModel {
    var ID : Int
    var type : String
    var ShortImage : String
    var name :String
    var Image: String
    var Deatails: String
    var Conditions: String
    var ExpireDate: String

    init(_ item: [String:Any]){
        ID         = item["id"] as? Int ?? 0
        type       = item["type"] as? String ?? ""
        ShortImage = item["ShortImage"] as? String ?? "https://cdn.wallpaper.com/main/styles/fp_922x565/s3/2019/01/coppindockray-ahmhouse-_00271_edit.jpg"
        name       = item["name"] as? String ?? ""
        Image      = item["Image"] as? String ?? ""
        Deatails   = item["Deatails"] as? String ?? ""
        Conditions = item["Conditions"] as? String ?? ""
        ExpireDate = item["ExpireDate"] as? String ?? ""
    }
}

