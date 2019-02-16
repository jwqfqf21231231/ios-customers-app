//
//  AdvdetailsVS.swift
//  BayanPay
//
//  Created by Mohanad on 12/16/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit

class AdvdetailsVS: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var advData:AdvsModel!
    var PriceItem: [PriceModel] = []
    @IBOutlet weak var pricesCollection: UICollectionView!
    @IBOutlet weak var ImgAdv: UIImageView!
    @IBOutlet weak var conditionsAdvs: UITextView!
    @IBOutlet weak var detailsAdv: UITextView!
    @IBOutlet weak var ExpDate: UILabel!
    var id:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        pricesCollection.dataSource = self
        pricesCollection.delegate = self
        detalis()
        getprices()
        
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
            let id = self.id
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
