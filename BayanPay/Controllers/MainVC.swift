//
//  MainVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/8/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    var window: UIWindow?
    var total:Int =  00
    var Status:Int = 000
    var Msg:String = ""
    var CheckExitOverDownload:[CheckExit] = []
    var ExitOverDown:[ExitOverDownload] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hideBackWord()
        ExitOver()
        alertCheckOver()
        
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
            }}}
    
    //    ExitOverDownload Action
    func ExitOverDownload(message:String) {
        let alertView = UIAlertController(title:"", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "موافق", style: .default) { (action:UIAlertAction) in
            
        }
        let ExitOverAction = UIAlertAction(title: "الخروج من سياسة الاستخدام", style: .default) { (action:UIAlertAction) in
            
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        
        self.present(alertView, animated: true, completion:nil) }
    
    //    CheckExitOver Action
    func CheckExitOver(message:String) {
        let alertView = UIAlertController(title:"", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "موفق", style: .default) { (action:UIAlertAction) in
            
        }
        let ExitOverAction = UIAlertAction(title: "أضغط هنا للخروج من سياسة", style: .default) { (action:UIAlertAction) in
            self.alertCheckOver()
            self.ExitOver()
            self.ExitOverDownload(message: "لديك \(self.total) محاولات للخروج من سياسة الاستخدام العادل" )
            
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
    
    func loadLoginScreen(){
        let wind = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: "StoryboardVC")
        window?.rootViewController = wind
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier:"LoginVC") as! LoginVC
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    func Move(){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            if let navigator = navigationController {
                viewController.hidesBottomBarWhenPushed = true
                navigator.pushViewController(viewController, animated: false)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ExitOverDownload(_ sender: Any) {
        CheckExitOver(message: Msg)

    }
    
     func clearUserData(){
        UserDefaults.standard.removeObject(forKey: "Message")
        UserDefaults.standard.removeObject(forKey: "UserName")
    }
    
    @IBAction func Exit(_ sender: Any) {
        Services.removeUser()
        clearUserData()
        Move()
       
    }
}
