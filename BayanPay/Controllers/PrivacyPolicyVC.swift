//
//  PrivacyPolicyVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/20/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var PPWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationItem.hideBackWord()
         self.title = "سياسة الخصوصية"
        let webUrl : NSURL = NSURL(string: "https://www.websitepolicies.com/policies/view/kQQXYro0?fbclid=IwAR3du5iSGHi6Bu_b7NkpBSxymJ0QGKVBnpy5hKQGKf1S519-JP5p3csbNYA")!
        let webRequest : NSURLRequest = NSURLRequest(url: webUrl as URL)
        PPWebView.loadRequest(webRequest as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
 

}
