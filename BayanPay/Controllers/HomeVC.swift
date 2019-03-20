//
//  HomeVC.swift
//  Paypal
//
//  Created by Suzan Amassy on 3/31/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
  
    var window: UIWindow?
    var UserMobile: [UserMobile] = []
    var array = [UIImage]()
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var SliderImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    override func viewWillAppear(_ animated: Bool) {
        array = [#imageLiteral(resourceName: "slide0"),#imageLiteral(resourceName: "slide1"),#imageLiteral(resourceName: "slide2"),#imageLiteral(resourceName: "slide3"),#imageLiteral(resourceName: "slide4"),#imageLiteral(resourceName: "slide5")]
        self.navigationItem.hideBackWord()
        GetUserMobile()
    }
    
    func GetUserMobile() {
        Services.CheckUserMobile{(error:Error? , UserMobile:[UserMobile]?) in
            if let Users = UserMobile {
                self.UserMobile = Users
                self.PopUpChoose()
            }}}
    
    func PopUpChoose(){
        let alert = UIAlertController(title: "أختر المستخدم", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self as UIPickerViewDataSource
        pickerFrame.delegate = self as UIPickerViewDelegate
        
        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { (UIAlertAction) in
            
        }))
        self.present(alert,animated: true, completion: nil )
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UserMobile.count
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ExsitUser = UserMobile[row].Message
        Services.SaveTell(Tell: ExsitUser)
        print(Services.getApiTell() ?? "hello telle")
        return ExsitUser
    }    
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
    
    
    @IBAction func unwindToHomeVC(segue:UIStoryboardSegue) { }
    
    
    @IBAction func UserProfile(_ sender: Any) { }
  
    
    //    BSA Action
    @IBAction func BSA(_ sender: Any) {
        let code = Services.getApiTell() ?? ""
        let first4 = String((code.prefix(2)))
        if (first4 == "") {
             PopUpChoose()
        }else if(first4 == "08"){
             loadMenuScreen()
        } else if(first4 == "05"){
            displayBSAMessage(message: "عذرا انت مشترك انترنت بدون خط نفاذ", title: "اهلا بك")
            print ("this is Not Tell", first4)
        } else{
            displayBSAMessage(message: "عذرا انت غير مشترك حاليا قم بالاتصال علي رقم 1700100800", title: "اهلا بك")
            print ("this is Not Tell", first4)
        }
    }
    
    
    @IBAction func VDS(_ sender: Any) {
        
        let code = Services.getApiTell() ?? ""
        let first4 = String((code.prefix(2)))
        if (first4 == "") {
            PopUpChoose()
        }else if(first4 == "05"){
            loadMenuScreen()
        } else if(first4 == "08"){
            displayBSAMessage(message: "عذرا انت مشترك انترنت مع خط نفاذ", title: "اهلا بك")
            print ("this is Not Tell", first4)
        } else{
            displayBSAMessage(message: "عذرا انت غير مشترك حاليا قم بالاتصال علي رقم 1700100800", title: "اهلا بك")
            print ("this is Not Tell", first4)
        }
        
    }
    
    
    //  Load Menu From Home
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

}
