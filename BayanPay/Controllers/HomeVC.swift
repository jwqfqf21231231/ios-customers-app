//
//  HomeVC.swift
//  Paypal
//
//  Created by Suzan Amassy on 3/31/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    var CheckExitOverDownload:[CheckExit] = []
    var ExitOverDown:[ExitOverDownload] = []
    
    var total:Int = 000
    var Status:Int = 000
    
    var Msg:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertCheckOver()
//        ExitOver()
    }
    
    @IBAction func unwindToHomeVC(segue:UIStoryboardSegue) { }
    
    @IBAction func UserProfile(_ sender: Any) {
        
        
    }
    func ExitOver(){
        Services.ExitOverDown{(error:Error? , ExitOver:[ExitOverDownload]?) in
            if let ExitOverItem = ExitOver {
                let Msg:ExitOverDownload = ExitOverItem[0]
                self.Msg = Msg.Message
            }
        }
    }
    func alertCheckOver(){
        Services.CheckExitOverDownload{(error:Error? , CheckExit:[CheckExit]?) in
            if let CheckExitOverDownload = CheckExit {
                let Total :CheckExit = CheckExitOverDownload[0]
                self.total = Total.Total
                self.Status = Total.Status
                print(self.Status)
                print(self.total)
                
                
            }
        }
    }
    
    
    @IBAction func CheckExitOverDownload(_ sender: Any) {
        CheckExitOver(message:"لديك \(self.total) محاولات للخروج من الاستخدام العادل")
    }
    
    func CheckExitOver(message:String) {
        let alertView = UIAlertController(title:"", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع", style: .default) { (action:UIAlertAction) in
            
        }
        let ExitOverAction = UIAlertAction(title: "أضغط هنا للخروج من سياسة", style: .default) { (action:UIAlertAction) in
            self.ExitOver()
            self.ExitOverDownload(message: "تمت عملية الخروج بنجاح ")
            
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        alertView.addAction(ExitOverAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
            
        }
        self.present(alertView, animated: true, completion:nil) }
    
    
    
    func ExitOverDownload(message:String) {
        let alertView = UIAlertController(title:"", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع", style: .default) { (action:UIAlertAction) in
            
        }
        let ExitOverAction = UIAlertAction(title: "الخروج من سياسة الاستخدام", style: .default) { (action:UIAlertAction) in
            
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
  
        self.present(alertView, animated: true, completion:nil) }
    
}
