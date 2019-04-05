//
//  RegisterVC.swift
//  BayanPay
//
//  Created by Mohanad on 12/17/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterVC: UIViewController {
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var Password: UITextField!
    var Hamlaid:Int = 0
    
    override func viewDidLoad() {
        self.title = "تسجيل مستخدم جديد"
        super.viewDidLoad()
        self.view.endEditing(true)
        print("HAMLAID",Hamlaid)
        self.navigationItem.hideBackWord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func RegisterBtn(_ sender: Any) {
    guard  ((Email.text) != nil) && ((Password.text) != nil) && ((ConfirmPassword.text) != nil) else {
        return self.displayErrorMessage(message: "قم بتعبئة الحقول")
    }
     self.isUser()
  }
    public  func RegisterNewUser(email:String, password:String, confirmpassword:String){
        let parameters: [String: String]=[
            "Mobile":email,
            "Password":password,
            "ConfirmPassword":confirmpassword,
            ]
        
        Alamofire.request(Urls.Register, method: .post,parameters:parameters, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<500)
            .responseJSON { response  in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if  let _ = json["result"].string,
                        let _ = json["result"].string {
                     
                         self.loadLoginScreen()
                        
                    } else  {
                        print("error .. !")
                        self.displayErrorMessage(message: "عذرا قم بتأكد من إدخال رقم موبيل فعال")
                    }
                    print(response)
                case .failure(let error):
                    self.displayErrorMessage(message: "عذرا قم بإدخال رقم موبيل فعال مبدوء 05 \n وكلمة المرور مكونة من 6 حقول")
                    print(error)
                }
        }
    }
    
    
    public func RegisterHamla(email:String, hamlaid:Int){
        let url = Urls.RegisterHamla
        let RegisterHamla = url + "\(email)" + "&Hamlaid=" + "\(hamlaid)"
        print("RegisterHamla",RegisterHamla)
        Alamofire.request(RegisterHamla, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<500)
            .responseJSON { response  in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if  let _ = json["result"].string,
                        let _ = json["result"].string {
                        
                    } else {
                        print("error .. !")
                    }
                    print(response)
                case .failure(let error):
                    self.displayErrorMessage(message: "عذرا قم بإدخال رقم موبيل فعال مبدوء 05 \n وكلمة المرور مكونة من 6 حقول")
                    print(error)
                }
        }
        
    }
    
    func isUser(){
          let Mobile = Email.text
          let isUserExit = Urls.isUserExist + Mobile!
        print(isUserExit)
        Alamofire.request(isUserExit, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure( _):
                   
                    self.displayErrorMessage(message: "أدخل رقم جوال فعال")
                case .success(let value):
                    let json:Int = response.result.value as! Int
                    print(json)
                    if json == 0 {
                        print(json)
                        self.GetCode()
                    }else{
                        self.displayErrorMessage(message: "قم بإدخال رقم موبيل فعال")
                    }
                 }}}
    
    func GetCode(){
        let Mobile = Email.text
        let url = Urls.CheckUserVerifiy + Mobile!
        print(url)
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure( _):
                    self.displayErrorMessage(message: "أدخل رقم جوال فعال")
                case .success(let value):
                    let json = JSON(value)
                      self.loadConfirmVCScreen()
                    print(json)
                }}}
    
   

    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(viewController, animated: true) }
    
    func loadConfirmVCScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ConfairmVC") as! ConfairmVC
            viewController.MobileNo = Email.text!
            viewController.ConfirmPasswordNo = ConfirmPassword.text!
            viewController.EmailNo = Email.text!
            viewController.passwordNo = Password.text!
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

