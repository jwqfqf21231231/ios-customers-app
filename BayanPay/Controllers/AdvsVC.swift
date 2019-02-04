//
//  AdvsVC.swift
//  BayanPay
//
//  Created by Mohanad on 12/30/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit

class AdvsVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var CollectionViewAdvs: UICollectionView!
    var items: [UIImage] = [
        UIImage(named: "advs")!,
        UIImage(named: "advs2")!,
        UIImage(named: "advs")!,
        UIImage(named: "advs2")!,
        UIImage(named: "advs")!,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewAdvs.dataSource = self
        CollectionViewAdvs.delegate = self
        let layout = self.CollectionViewAdvs as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5)
        layout?.minimumInteritemSpacing = 5
        layout?.itemSize = CGSize(width: (CollectionViewAdvs.frame.size.width-20)/2, height: self.CollectionViewAdvs.frame.size.height/3)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proCell", for: indexPath) as! AdvsCell
        cell.UIImg.image =    items[indexPath.row]
        return cell
        
        
    }
    
}
