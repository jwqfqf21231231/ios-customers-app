//
//  NewPasswordVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/5/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewPasswordVC: UIViewController {

    @IBOutlet weak var ConfirmNewPassword: UITextField!
    @IBOutlet weak var PasswordNew: UITextField!
    var MobileNumber:String = ""
    var Code:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hideBackWord()

    }

    func GetCode(){
        let NewPassword = PasswordNew.text!
        let url = Urls.Newpassword + "\(MobileNumber)" + "&VerficationCode=" + "\(Code)" + "&Newpassword=" + NewPassword
        print(url)
        Alamofire.request(url, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure( _):
                    self.displayErrorMessage(message: "أدخل رقم جوال فعال", title: "خطأ بالأدخال")
                case .success(let value):
                    let json = JSON(value)
                    if json == "1"{
                self.loadLoginScreen()
                    }
                    self.loadLoginScreen()
                    print(json)
                }}}

    
    @IBAction func NewPassword(_ sender: Any) {
        if(ConfirmNewPassword.text == nil || ConfirmNewPassword.text == "" || PasswordNew.text == nil || PasswordNew.text == "" ){
            displayErrorMessage(message: "قم بإدخال رقم التحقق ", title: "خطأ بالأدخال")
        }else{
            GetCode()
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
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        navigationController?.pushViewController(viewController, animated: true) }

    

}
