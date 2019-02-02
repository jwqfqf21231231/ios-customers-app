//
//  OutAdvdetailsVC.swift
//  BayanPay
//
//  Created by Mohanad on 1/27/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import SDWebImage
class OutAdvdetailsVC: UIViewController {
    @IBOutlet weak var Scroll: UIScrollView!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price4: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var price12: UILabel!
    @IBOutlet weak var price6: UILabel!
    @IBOutlet weak var g1: UILabel!
    @IBOutlet weak var g2: UILabel!
    @IBOutlet weak var g3: UILabel!
    @IBOutlet weak var g6: UILabel!
    @IBOutlet weak var g12: UILabel!
    @IBOutlet weak var g4: UILabel!
    
    var advData:AdvModel!
    var PriceItem: [PriceModel] = []
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Conditions: UITextView!
    @IBOutlet weak var Deatails: UITextView!
    @IBOutlet weak var ExpDate: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
           detalis()
           getprices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        Scroll.alwaysBounceVertical = true
        
    }
    
    func detalis(){
        let url = URL(string:"http://acc.fusion.ps/images/shortImg/" + advData.Image)
        Image.sd_setImage(with: url)
        Conditions.text = advData.Conditions
        Deatails.text = advData.Deatails
        ExpDate.text = advData?.ExpireDate
        
    }
    
    func getprices() {
        Services.GetPrice{(error:Error? , PriceData:[PriceModel]?) in
            if let Prices = PriceData {
                self.PriceItem = Prices
                let price:PriceModel = Prices[0]
                let price1 = price.price1 as Int
                self.price1.text = "\(price1)"
                
                let price2 = price.price2 as Int
                self.price2.text = "\(price2)"
                
                let price3 = price.price3 as Int
                self.price3.text = "\(price3)"
                
                let price4 = price.price4 as Int
                self.price4.text = "\(price4)"
                
                let price6 = price.price6 as Int
                self.price6.text = "\(price6)"
                
                let price12 = price.price1 as Int
                self.price12.text = "\(price12)"
                
                let _ :PriceModel = Prices[0]
                self.g1.text = price.group
                self.g2.text = price.group
                self.g3.text = price.group
                self.g4.text = price.group
                self.g6.text = price.group
                self.g12.text = price.group
                
            }
            }
        
    }
    
    

}
