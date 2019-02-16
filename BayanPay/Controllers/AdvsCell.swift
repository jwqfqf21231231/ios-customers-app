//
//  AdvsCell.swift
//  BayanPay
//
//  Created by Mohanad on 12/30/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit

class AdvsCell: UICollectionViewCell {
    
    @IBOutlet weak var UIImg: UIImageView!
    var ID:Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        UIImg.setRounded()
    }
}
