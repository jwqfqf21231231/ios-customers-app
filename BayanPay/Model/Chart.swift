//
//  Chart.swift
//  BayanPay
//
//  Created by Mohanad on 2/24/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import Foundation
class Chart: NSObject {
    
    var x:Double = 0
    var y:Double = 0
}

class Ticket:NSObject{
    var userid:Int = 0
    var Mobile:String = ""
    var Name:String = ""
    var Note:String = ""
}

class PerDay:NSObject{
    var limit:Double = 0.0
    var download:Double = 0.0
}
