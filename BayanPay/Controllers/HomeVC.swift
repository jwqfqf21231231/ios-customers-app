//
//  HomeVC.swift
//  Paypal
//
//  Created by Suzan Amassy on 3/31/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    var window: UIWindow?
    var total:Int = 000
    var Status:Int = 000
    var Msg:String = ""
    var CheckExitOverDownload:[CheckExit] = []
    var ExitOverDown:[ExitOverDownload] = []
    
    var array = [UIImage]()
    
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var SliderImage: UIImageView!
    
    
    @IBAction func Back(_ sender: Any) {
        Slider.value -= 1
        SliderImage.image = array[Int(Slider.value)]
    }
    @IBAction func Next(_ sender: Any) {
        Slider.value += 1
        SliderImage.image = array[Int(Slider.value)]
        
    }
    
    @IBAction func MySlider(_ sender: UISlider) {
        var value = Int(sender.value)
        SliderImage.image = array[value]
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        alertCheckOver()
       array = [#imageLiteral(resourceName: "slide0"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide2"),#imageLiteral(resourceName: "slide3"),#imageLiteral(resourceName: "slide4"),#imageLiteral(resourceName: "slide5")]
        self.navigationItem.hideBackWord()
        ExitOver()
    }
    
    @IBAction func unwindToHomeVC(segue:UIStoryboardSegue) { }
    
    
    @IBAction func LogOut(_ sender: Any) {
        Services.removeUser()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(ViewController, animated: true, completion: nil)
//        (ViewController, animated: true)
    }
    
    @IBAction func UserProfile(_ sender: Any) { }
    
// Services Start
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
    
//    Services End
    
    @IBAction func CheckExitOverDownload(_ sender: Any) {
//        CheckExitOver(message:"لديك \(self.total) محاولات للخروج من الاستخدام العادل")
        CheckExitOver(message: Msg)
    }
    
    //    BSA Action
    @IBAction func BSA(_ sender: Any) {
        guard let code = Services.getApiTell() else  {return}
        let first4 = String((code.prefix(2)))
        
        if first4 == "08" {
            loadMenuScreen()
            print("This is Tell",first4)
        } else if(first4 == "05"){
            displayBSAMessage(message: "عذرا انت مشترك انترنت بدون خط نفاذ", title: "اهلا بك")
            print ("this is Not Tell", first4)
        } else{
            displayBSAMessage(message: "عذرا انت غير مشترك حاليا قم بالاتصال علي رقم 1700100800", title: "اهلا بك")
            print ("this is Not Tell", first4)
        }
    }
    
    @IBAction func VDS(_ sender: Any) {
     guard let code = Services.getApiTell() else  {return}
        let first4 = String((code.prefix(2)))
        
        if first4 == "05" {
            loadMenuScreen()
            print("This is Tell",first4)
        } else if(first4 == "08"){
            displayBSAMessage(message: "عذرا انت مشترك انترنت بدون خط نفاذ", title: "اهلا بك")
            print ("this is Not Tell", first4)
        }else{
            displayBSAMessage(message: "عذرا انت غير مشترك حاليا قم بالاتصال علي رقم 1700100800", title: "اهلا بك")
            print ("this is Not Tell", first4)
        }
        
    }
    
    
    //    Load Menu From Home
    func loadMenuScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyBoard.instantiateViewController(withIdentifier: "Menus")
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
//    Display Message for Action BSA and VDSL
    func displayBSAMessage(message:String,title:String) {
        let alertView = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "استمرار", style: .default) { (action:UIAlertAction) in
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
            self.ExitOver()
            self.ExitOverDownload(message: "لديك \(self.total) للخروج من سياسة الاستخدام" )
            
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
    
}
