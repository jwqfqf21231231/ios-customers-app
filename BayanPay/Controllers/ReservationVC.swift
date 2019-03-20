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
    
    var hamlaID:Int = 0
    var SpeedID:Int = 0
    var PeriodID:Int = 0
    var messages = String()
    
    @IBOutlet weak var PeriodPK: UIPickerView!
    @IBOutlet weak var HamlaPK: UIPickerView!
    @IBOutlet weak var SpeedPK: UIPickerView!
    
     var GetHamlaList_Var = [HamlaList]()
     var GetHamlaSpeed_Var = [HamlaSpeed]()
     var GetHamlaPeriod_Var = [HamlaPeriod]()
     var AddpendingMsg = [AddpendingMessage]()
    
    override func viewDidLoad() {
        self.navigationItem.hideBackWord()
        self.title = "حجز البطاقة"

        super.viewDidLoad()
        self.HamlaPK.dataSource = self
        self.HamlaPK.delegate = self
        
        self.SpeedPK.dataSource = self
        self.SpeedPK.delegate = self
        
        self.PeriodPK.dataSource = self
        self.PeriodPK.delegate = self
        
          GetHamlaList()
    }
    
    func Addpending(){
        Services.AddpendingMessageClass(hamlaID: hamlaID, SpeedID: SpeedID, PeriodID: PeriodID){(error:Error? , AddpendingMsg:[AddpendingMessage]?) in
        if let add = AddpendingMsg {
            self.AddpendingMsg = add
            let add :AddpendingMessage = add[0]
            self.displayErrorMessage(message: add.Message)
          }}}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func GetHamlaList(){
        Services.GetHamlaListPost{(error:Error? , HamlaList:[HamlaList]?) in
            if let HamlaItem = HamlaList {
                self.GetHamlaList_Var = HamlaItem
                self.SpeedPK.reloadAllComponents()
                self.HamlaPK.reloadAllComponents()
                print(HamlaItem)
                
            }
        }
    }
    
    func GetHamlaSpeed(_ id:Int){
        Services.GetHamlaSpeedGet(HamlaID: id){(error:Error? , HamlaSpeed:[HamlaSpeed]?) in
            if let SpeedItem = HamlaSpeed {
                self.GetHamlaSpeed_Var = SpeedItem
                self.SpeedPK.reloadAllComponents()
                 self.PeriodPK.reloadAllComponents()
                print(SpeedItem)
                
            }
        }
    }
    
    func GetHamlaPeriod(_ speed:Int, _ Hamla:Int){
        Services.GetHamlaPeriodGet(Speed: speed, Hamla: Hamla){(error:Error? , HamlaPeriod:[HamlaPeriod]?) in
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
            hamlaID = GetHamlaList_Var[row].id
            GetHamlaSpeed(hamlaID)
            
            return GetHamlaList_Var[row].name
            
            
        }
        else if(pickerView.tag == 1){
            SpeedID = GetHamlaSpeed_Var[row].ID
            GetHamlaPeriod(SpeedID,hamlaID)
            
            return self.GetHamlaSpeed_Var[row].Title
            
        } else {
           PeriodID = GetHamlaPeriod_Var[row].ID
          return self.GetHamlaPeriod_Var[row].Title
        }
        
    }
    
    @IBAction func AddPending(_ sender: Any) {
        Addpending()
        
    }
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "موافق", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }
    
    func displaySuccessMessage(message:String,title:String) {
        let alertView = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title:"موافق", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }

}
