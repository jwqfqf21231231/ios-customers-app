//
//  SpeedVC.swift
//  BayanPay
//
//  Created by Mohanad on 2/28/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import WebKit
class SpeedVC: UIViewController,UIWebViewDelegate  {
    
    @IBOutlet weak var WebSpeed: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webUrl : NSURL = NSURL(string: "https://fast.com/")!
        let webRequest : NSURLRequest = NSURLRequest(url: webUrl as URL)
        WebSpeed.loadRequest(webRequest as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
