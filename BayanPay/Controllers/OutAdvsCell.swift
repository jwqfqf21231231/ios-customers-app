//
//  OutAdvsCell.swift
//  BayanPay
//
//  Created by Mohanad on 1/15/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class OutAdvsCell: UICollectionViewCell {
    
    @IBOutlet weak var imgAdvs: UIImageView!
    var ID:Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgAdvs.setRounded()
    }
}
