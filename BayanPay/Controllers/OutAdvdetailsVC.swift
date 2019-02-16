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
    
    @IBOutlet weak var Scroll: UIScrollView!
    var advData:AdvModel!
    var PriceItem: [PriceModel] = []
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Conditions: UITextView!
    @IBOutlet weak var Deatails: UITextView!
    @IBOutlet weak var ExpDate: UILabel!
    @IBOutlet weak var PricesCollection: UICollectionView!
    var id:Int!
    
    override func viewDidLoad() {
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
    func detalis(){
        let url = URL(string:"http://acc.fusion.ps/images/shortImg/" + advData.Image)
        Image.sd_setImage(with: url)
        Conditions.text = advData.Conditions
        Deatails.text = advData.Deatails
        ExpDate.text = advData?.ExpireDate
        self.id = advData?.ID
        
    }
    func getprices() {
        Services.GetPrice(id: id){(error:Error? , PriceData:[PriceModel]?) in
            let id = self.id
            if let Prices = PriceData {
                self.PriceItem = Prices
                self.PricesCollection.reloadData()
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
        //cell.g?.text = PriceItem[indexPath.row].name
        cell.giga.text = PriceItem[indexPath.row].group
        return cell
    }
    
    
    
    
    
}
