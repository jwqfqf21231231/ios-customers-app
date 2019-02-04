//
//  OutAdvsVS.swift
//  BayanPay
//
//  Created by Mohanad on 1/15/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage

class OutAdvsVS: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var CollectionAdvsOut: UICollectionView!
    var AdvertaismentItems:[AdvModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionAdvsOut.dataSource = self
        CollectionAdvsOut.delegate = self
        Load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AdvertaismentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutCell", for: indexPath) as! OutAdvsCell
    
        let item = AdvertaismentItems[indexPath.row]
        let url = URL(string:"http://acc.fusion.ps/images/shortImg/" + item.ShortImage)
        cell.imgAdvs.sd_setImage(with: url)
        cell.ID = AdvertaismentItems[indexPath.row].ID
        return cell
        print(cell)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "Deatails") as? OutAdvdetailsVC
        detailsVC?.advData = AdvertaismentItems[indexPath.row]
        
        self.navigationController?.pushViewController(detailsVC!, animated: true)
        
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "خطأ في الأدخال", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع ", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }
    
    func Load(){
        Alamofire.request(Urls.getOutAdvs, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<500)
            .responseJSON
            { response in
                
                if let resp = response.result.value as? NSDictionary {
                    let items = resp.value(forKey: "data") as? [[String:Any]]
                    
                    for i in items! {
                        self.AdvertaismentItems.append(AdvModel(i))
                        print(i.values)
                    }
                    self.CollectionAdvsOut.reloadData()
                } else {
                    print("error")
                    
                }
                
        }
    }
}


