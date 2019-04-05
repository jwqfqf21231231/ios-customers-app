//
//  OutAdvdetailsVC.swift
//  BayanPay
//
//  Created by Mohanad on 1/27/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage

class OutAdvdetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var actvitiyLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var Scroll: UIScrollView!
    @IBOutlet weak var Conditions: UILabel!
    var advData:AdvModel!
     var PriceItem: [PriceModel] = []
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Deatails: UILabel!
    @IBOutlet weak var ExpDate: UILabel!
    @IBOutlet weak var PricesCollection: UICollectionView!
    var id:Int!
    
    override func viewDidLoad() {
        actvitiyLoader.startAnimating()
        self.navigationItem.hideBackWord()
        super.viewDidLoad()
        PricesCollection.delegate = self
        PricesCollection.dataSource = self
        detalis()
        getprices()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        Scroll.alwaysBounceVertical = true
        
    }
    
    @IBAction func SendToRegister(_ sender: Any){

        loadRegisterScreen()
    }
    
    //    Load Menu From Home
    func loadRegisterScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        ViewController.Hamlaid = self.id
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
    func detalis(){
        let url = URL(string:"http://mapi.fusion.ps/images/img/" + advData.Image)
        Image.sd_setImage(with: url)
        
        if advData.Conditions == "" {
            Conditions.text = "الشروط غير متوفرة حاليا لهذه الحملة  "
        }else{
         Conditions.text = advData.Conditions
        }
        
        if  advData.Deatails == "" {
            
            Conditions.text = "التفاصيل غير متوفرة حاليا لهذه الحملة"
        }else{
             Deatails.text = advData.Deatails
        }
       
       
        ExpDate.text = advData?.ExpireDate
        self.id = advData?.ID
        
    }
    func getprices() {
        Services.GetPrice(id: id){(error:Error? , PriceData:[PriceModel]?) in
            _ = self.id
            if let Prices = PriceData {
                self.PriceItem = Prices
                self.PricesCollection.reloadData()
                print(Prices)
                 self.actvitiyLoader.stopAnimating()
            }
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PriceItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = PricesCollection.dequeueReusableCell(withReuseIdentifier: "GetPriceCell", for: indexPath) as! GetPriceCell
        let price1 = PriceItem[indexPath.row].price1
        let price2 = PriceItem[indexPath.row].price2
        let price3 = PriceItem[indexPath.row].price3
        let price4 = PriceItem[indexPath.row].price4
        let price6 = PriceItem[indexPath.row].price6
        let price12 = PriceItem[indexPath.row].price12
        
        if price1 >= 1{
            cell.price1?.text = "\(price1) شهر"
        }else{ cell.price1?.text = "" }
        
        if price2 >= 1{
            cell.price2?.text = "\(price2) شهرين"
        }else{ cell.price2?.text = "" }
        
        if price3 >= 1{
            cell.price3?.text = "\(price3)ثلاث شهور"
        }else{ cell.price3?.text = "" }
        
        if price4 >= 1{
            cell.price4?.text = "\(price4) اربعة شهور"
        }else{ cell.price4?.text = "" }
        
        if price6 >= 1{
            cell.price6?.text = "\(price6) ستة شهور"
        }else{ cell.price6?.text = "" }
        if price12 >= 1{
            cell.price12?.text = "\(price12) سنة"
        }else{ cell.price12?.text = "" }
        cell.giga.text = PriceItem[indexPath.row].group
        return cell
    }
    
    
    
    
    
}
