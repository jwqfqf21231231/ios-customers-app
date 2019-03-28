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

class ConfairmVC: UIViewController {

    @IBOutlet weak var CodeV: UITextField!
    var MobileNo:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
          self.navigationItem.hideBackWord()

    }
    
    @IBAction func SendCode(_ sender: Any) {
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
                    self.displayErrorMessage(message: "تأكد من رمز التفعيل")
                case .success(let value):
                    let json = JSON(value)
                    self.loadLoginScreen()
                    print(json)
                }}
        
    }
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    if  let _ = json["1"].string{
//
//                            self.loadLoginScreen()
//
//                    } else {
//                        self.displayErrorMessage(message: "قم بإدخال رقم التحقق الذي تم أرسالة لك")
//                    }
//                    print(response)
//                case .failure(let error):
//
//                    self.displayErrorMessage(message: "حاول مرة أخرى")
//                    print(error)
//                }
//        }
//    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
         navigationController?.pushViewController(viewController, animated: true) }
    

    
    func displayErrorMessage(message:String) {
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

    

