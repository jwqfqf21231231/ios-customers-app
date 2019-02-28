//
//  AdvsVC.swift
//  BayanPay
//
//  Created by Mohanad on 12/30/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SDWebImage

class AdvsVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var CollectionViewAdvs: UICollectionView!
     var Advtems:[AdvsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewAdvs.dataSource = self
        CollectionViewAdvs.delegate = self
        let layout = self.CollectionViewAdvs as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5)
        layout?.minimumInteritemSpacing = 5
        layout?.itemSize = CGSize(width: (CollectionViewAdvs.frame.size.width-20)/2, height: self.CollectionViewAdvs.frame.size.height/3)
        Load()
        self.navigationItem.hideBackWord()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Advtems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! AdvsCell
        
        let item = Advtems[indexPath.row]
        let url = URL(string:"http://acc.fusion.ps/images/shortImg/" + item.ShortImage)
        cell.UIImg.sd_setImage(with: url)
        cell.ID = Advtems[indexPath.row].ID
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "AdvdetailsVS") as? AdvdetailsVS
        
        detailsVC?.advData = Advtems[indexPath.row]

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
                        self.Advtems.append(AdvsModel(i))
                        print(i.values)
                    }
                        self.CollectionViewAdvs.reloadData()
                    } else {
                        print("error")
                    
                }
                
        }
    }
    
}
