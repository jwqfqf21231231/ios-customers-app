//
//  LoginVC.swift
//  Paypal
//
//  Created by Suzan Amassy on 3/31/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LoginVC: UIViewController {

    @IBOutlet weak var UserName: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserName.text = "0599986181"
        Password.text = "Mmoh@123"
     
    }
    
    @IBAction func LoginAc(_ sender: Any) {
        
        guard  (UserName.text != nil)  &&  (Password.text != nil)else {
            return self.displayErrorMessage(message: "قم بإدخال الايميل وكلمة المرور وتأكيد كلمة المرور")
        }
        
        let parameters: [String: String]=[
            "username":UserName.text!,
            "Password":Password.text!,
            "grant_type": "password"
            ]
        Alamofire.request(Urls.login, method: .post,parameters:parameters, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<300)
            .responseJSON { response  in
                
                switch response.result {
                     case .success(let value):
                        let json = JSON(value)
                        if let access_token = json["access_token"].string,
                           let UserName = json["userName"].string {
                        Services.saveSessions(access_token: access_token)
                        Services.SaveUser(UserName: UserName)
                        self.loadLoginScreen()
                        print(access_token)
                        } else {
                        print("error .. !")
                        self.displayErrorMessage(message: "أدخل كلمة مرور صحيحة")
                        }
                        
                        print(response)
                    case .failure(let error):
                        self.displayErrorMessage(message: "عذرا قم بتأكد من  إدخالك الايميل و كلمة المرور تحتوي حروف وارقام و رموز")
                        print(error)
                }
        }
        
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TbBarVS") as! TbBarVS
        self.present(viewController, animated: true, completion: nil) }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "خطأ في الأدخال", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع ", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }


}


        
       

    


