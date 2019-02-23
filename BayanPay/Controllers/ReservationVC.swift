//
//  ReservationVC.swift
//  BayanPay
//
//  Created by Mohanad on 2/21/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ReservationVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var PeriodPK: UIPickerView!
    @IBOutlet weak var HamlaPK: UIPickerView!
    @IBOutlet weak var SpeedPK: UIPickerView!
    
     var GetHamlaList_Var = [HamlaList]()
     var GetHamlaSpeed_Var = [HamlaSpeed]()
     var GetHamlaPeriod_Var = [HamlaPeriod]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HamlaPK.dataSource = self
        self.HamlaPK.delegate = self
        
        self.SpeedPK.dataSource = self
        self.SpeedPK.delegate = self
        
        self.PeriodPK.dataSource = self
        self.PeriodPK.delegate = self
        
          GetHamlaSpeed()
          GetHamlaList()
          GetHamlaPeriod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func GetHamlaList(){
        Services.GetHamlaListPost{(error:Error? , HamlaList:[HamlaList]?) in
            if let HamlaItem = HamlaList {
                self.GetHamlaList_Var = HamlaItem
                self.HamlaPK.reloadAllComponents()
                print(HamlaItem)
                
            }
        }
    }
    
    func GetHamlaSpeed(){
        Services.GetHamlaSpeedGet(HamlaID: "104"){(error:Error? , HamlaSpeed:[HamlaSpeed]?) in
            if let SpeedItem = HamlaSpeed {
                self.GetHamlaSpeed_Var = SpeedItem
                self.SpeedPK.reloadAllComponents()
                print(SpeedItem)
                
            }
        }
    }
    
    func GetHamlaPeriod(){
        Services.GetHamlaPeriodGet(Speed: "120", Hamla: "104"){(error:Error? , HamlaPeriod:[HamlaPeriod]?) in
            if let PeriodItem = HamlaPeriod {
                self.GetHamlaPeriod_Var = PeriodItem
                self.PeriodPK.reloadAllComponents()
                print("per",PeriodItem)
                
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0){
            
             return GetHamlaList_Var.count
        }
        else if(pickerView.tag == 1){
            
            return self.GetHamlaSpeed_Var.count
        } else {
            
            return self.GetHamlaPeriod_Var.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0){
            
            return GetHamlaList_Var[row].name
        }
        else if(pickerView.tag == 1){
            
            return self.GetHamlaSpeed_Var[row].Title
            
        } else {
            
          return self.GetHamlaPeriod_Var[row].Title
        }
        
    }
    
    @IBAction func AddPending(_ sender: Any) {
        
        let url = Urls.AddPending
        guard let api_User = Services.getApiTell() else { return }
        
        let parameters: [String: Any]=[
            "userid":api_User,
            "hamlaid":"104",
            "speedid": "120",
            "Month":"1"
        ]
//        parameters:parameters
        Alamofire.request(url, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<300)
            .responseJSON { response  in
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let MessageCode = json["data"]["MessageCode"].string,
                       let Message = json["data"]["Message"].string {

                        print(Message)
                        self.displaySuccessMessage(message: Message,title: MessageCode)
                    } else {
                        
                        print("error .. !")
                        self.displayErrorMessage(message: "خطأ بالادخال حاول مرة أخرى")
                    }
                    print(response)
                case .failure(let error):
                    self.displayErrorMessage(message: "")
                    print(error)
                }
        }
        
    }
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
    
    func displaySuccessMessage(message:String,title:String) {
        let alertView = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع ", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }

}
