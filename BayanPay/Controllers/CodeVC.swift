//
//  CodeVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/5/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CodeVC: UIViewController {

    @IBOutlet weak var CodeSMS: UITextField!
    
    var MobileNumber:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hideBackWord()

    }
    func CheckCode(){
        let Mobile = MobileNumber
        let url = Urls.chekCode + Mobile + "&VerficationCode=" + "\(CodeSMS.text!)"
        print(url)
        Alamofire.request(url, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure( _):
                    self.displayErrorMessage(message: "أدخل رقم تحقق فعال", title: "خطأ بالأدخال")
                case .success(let value):
                    let json = JSON(value)
                    if(json == "1"){
                    self.loadLoginScreen()
                    }else{
                    self.displayErrorMessage(message: "أدخل رقم تحقق فعال", title: "خطأ بالأدخال")
                    }
                    print(json)
                }}}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SendCode(_ sender: Any) {
        if(CodeSMS.text == nil || CodeSMS.text == "" ){
           displayErrorMessage(message: "قم بإدخال رقم التحقق ", title: "خطأ بالأدخال")
        }else{
            CheckCode()
        }}
    
        
    
    
    func displayErrorMessage(message:String, title:String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "موافق", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier:
            
            "NewPasswordVC") as! NewPasswordVC
         viewController.MobileNumber = MobileNumber
        viewController.Code = CodeSMS.text!
        navigationController?.pushViewController(viewController, animated: true) }

}
