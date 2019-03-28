//
//  VerficationCodeVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/5/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VerficationCodeVC: UIViewController {

    @IBOutlet weak var MobileNo: UITextField!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hideBackWord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func IsAccount(){
        let Mobile = MobileNo.text
        let url = Urls.IsAccountExist + Mobile!
        print(url)
        Alamofire.request(url, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure( _):
                    self.displayErrorMessage(message: "ليس لديك حساب لدينا", title: "خطأ بالأدخال")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                }}}
    
    func GetCode(){
        let Mobile = MobileNo.text
        let url = Urls.CheckUserVerifiy + Mobile!
        print(url)
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure( _):
                    self.displayErrorMessage(message: "أدخل رقم جوال فعال", title: "خطأ بالأدخال")
                case .success(let value):
                    let json = JSON(value)
                    self.loadLoginScreen()
                    print(json)
                }}}

    
    @IBAction func SendNumber(_ sender: Any) {
        if(MobileNo.text == nil || MobileNo.text == "" ){
            displayErrorMessage(message: "أدخل رقم جوال فعال", title: "خطأ بالأدخال")
           
        } else {
            
          GetCode()
        
        }
    }
    
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
        let viewController = storyBoard.instantiateViewController(withIdentifier: "CodeVC") as! CodeVC
         viewController.MobileNumber = self.MobileNo.text!
       
        navigationController?.pushViewController(viewController, animated: true) }
    

}
