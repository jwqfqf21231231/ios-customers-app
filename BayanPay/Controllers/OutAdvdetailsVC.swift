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
    var advData:AdvModel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Conditions: UITextView!
    @IBOutlet weak var Deatails: UITextView!
    @IBOutlet weak var ExpDate: UILabel!
        override func viewDidLoad() {
        super.viewDidLoad()
       detalis()
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
    

}
