//
//  AdvdetailsVS.swift
//  BayanPay
//
//  Created by Mohanad on 12/16/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AdvdetailsVS: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var advData:AdvsModel!
    var PriceItem: [PriceModel] = []
    var CheckHamlData:[CheckHamla] = []
    var ChargeHamladata:[ChargeHamla] = []
    
    @IBOutlet weak var pricesCollection: UICollectionView!
    @IBOutlet weak var ImgAdv: UIImageView!
    @IBOutlet weak var conditionsAdvs: UITextView!
    @IBOutlet weak var detailsAdv: UITextView!
    @IBOutlet weak var ExpDate: UILabel!
    var id:Int!
    var groupid:Int!
    var choices = ["",""]
    var pickerView = UIPickerView()
    var messages = String()
    var typeValue = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pricesCollection.dataSource = self
        pricesCollection.delegate = self
        detalis()
        getprices()
            
        }
        
    override func viewWillAppear(_ animated: Bool) {
        //  CheckHamlaFunc()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    func CheckHamlaFunc(gID:Int){
        Services.CheckHamlat(id: id, groupid: gID){(error:Error? , CheckHamlData:[CheckHamla]?) in
            if let Hamla = CheckHamlData {
            self.CheckHamlData = Hamla
            let Hamla :CheckHamla = Hamla[0]
                self.choices = [Hamla.Message]
                }}}
    
    func ChargeHamla() {
        Services.ChargeHamlaFunc(id: id, groupid: groupid!){(error:Error?, ChargeHamladata:[ChargeHamla]?) in
            if let Charge = ChargeHamladata {
                self.ChargeHamladata = Charge
                let Charge :ChargeHamla = Charge[0]
                self.messages = Charge.Message
            }}}
    
    
    
    @IBAction func ChooseHamla(_ sender: Any) {
     
      PopUpChoose()
       
        
    }
    
    func PopUpChoose(){
        let alert = UIAlertController(title: "اختر الحملة", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        
        alert.view.addSubview(pickerFrame)
        pickerFrame.dataSource = self as UIPickerViewDataSource
        pickerFrame.delegate = self as UIPickerViewDelegate
        
        alert.addAction(UIAlertAction(title: "ألغاء", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: { (UIAlertAction) in
            print("You selected " + self.typeValue )
            self.ChargeHamla()
            self.ChargeHamlaAlert(message: self.messages)
            
            
        }))
        self.present(alert,animated: true, completion: nil )
        
    }
    
    //    ChargeHamla
    func ChargeHamlaAlert(message:String) {
        let alertView = UIAlertController(title:"", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "تم", style: .default) { (action:UIAlertAction) in
            
        }
        _ = UIAlertAction(title: "شحن للحملة ", style: .default) { (action:UIAlertAction) in
            
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        
        self.present(alertView, animated: true, completion:nil) }
    
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Cairo", size: 14)
            pickerLabel?.textAlignment = .center }
            pickerLabel?.text = choices[row]
            pickerLabel?.textColor = UIColor.blue
        return pickerLabel!
    }

    
    
    
    func detalis(){
        let url = URL(string:"http://acc.fusion.ps/images/shortImg/" + advData.Image)
        ImgAdv.sd_setImage(with: url)
        conditionsAdvs.text = advData.Conditions
        detailsAdv.text = advData.Deatails
        ExpDate.text = advData?.ExpireDate
        self.id = advData?.ID
        
    }
    func getprices() {
        Services.GetPrice(id: id){(error:Error? , PriceData:[PriceModel]?) in
            _ = self.id
            if let Prices = PriceData {
                self.PriceItem = Prices
                
                self.pricesCollection.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return PriceItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pricesCollection.dequeueReusableCell(withReuseIdentifier: "InGetPriceCell", for: indexPath) as! InGetPriceCell
        let price1 = PriceItem[indexPath.row].price1
        let price2 = PriceItem[indexPath.row].price2
        let price3 = PriceItem[indexPath.row].price3
        let price4 = PriceItem[indexPath.row].price4
        let price6 = PriceItem[indexPath.row].price6
        let price12 = PriceItem[indexPath.row].price12
        self.groupid = PriceItem[indexPath.row].q
        CheckHamlaFunc(gID: self.groupid)
        
        if price1 >= 1{
            cell.Price1?.text = "\(price1) شهر"
        }else{ cell.Price1?.text = "" }
        
        if price2 >= 1{
            cell.Price2?.text = "\(price2) شهرين"
        }else{ cell.Price2?.text = "" }
        
        if price3 >= 1{
            cell.Price3?.text = "\(price3)ثلاث شهور"
        }else{ cell.Price3?.text = "" }
        
        if price4 >= 1{
            cell.Price4?.text = "\(price4) اربعة شهور"
        }else{ cell.Price4?.text = "" }
        
        if price6 >= 1{
            cell.Price6?.text = "\(price6) ستة شهور"
        }else{ cell.Price6?.text = "" }
        if price12 >= 1{
            cell.Price12?.text = "\(price12) سنة"
        }else{ cell.Price12?.text = "" }
        cell.Giga.text = PriceItem[indexPath.row].group
        return cell
    }
    


}
