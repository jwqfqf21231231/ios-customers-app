//
//  ConfairmVC.swift
//  BayanPay
//
//  Created by Mohanad on 12/16/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConfairmVC:RegisterVC {

    @IBOutlet weak var CodeV: UITextField!
    var MobileNo:String = ""
    var EmailNo:String = ""
    var passwordNo:String = ""
    var ConfirmPasswordNo:String = ""
    var hamlaidNo:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.navigationItem.hideBackWord()

    }
    
    @IBAction func SendCode(_ sender: Any) {
        guard  ((CodeV.text) != nil)else {
            return self.displayErrorMessageForConfirm(message: "تأكد من رمز التفعيل")
        }
        VeriyficationCode()
    }
    
    func VeriyficationCode(){
       
        let url = Urls.VireyficationCode
        let Code = CodeV.text!
        let Mobile = MobileNo
        let veryfication = url + "\(Mobile)" +  "&VerficationCode=" + Code
        print(veryfication)
        Alamofire.request(veryfication, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<500)
            .responseJSON { response  in
                switch response.result {
                case .failure( _):
                    self.displayErrorMessageForConfirm(message: "تأكد من رمز التفعيل")
                case .success(let value):
                    let json = JSON(value)
                    self.RegisterNewUser(email: self.EmailNo, password: self.passwordNo, confirmpassword: self.ConfirmPasswordNo )
                    self.RegisterHamla(email: self.EmailNo, hamlaid: self.hamlaidNo)
                    print(json)
                }}
        
    }

    
    override func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
         navigationController?.pushViewController(viewController, animated: true) }
    

    
     func displayErrorMessageForConfirm(message:String) {
        let alertView = UIAlertController(title: "خطأ بالأدخال", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع ", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }
}

    

