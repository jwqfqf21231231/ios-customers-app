//
//  ActivityCell.swift
//  BayanPay
//
//  Created by Mohanad on 1/29/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    @IBOutlet weak var GroupName: UILabel?
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Point: UILabel!
    @IBOutlet weak var ExpireDate: UILabel!
    @IBOutlet weak var Serial: UILabel!
    @IBOutlet weak var UseDate: UILabel!
    
    @IBOutlet weak var ViewActivity: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewActivity.setRounded(radius: 8)
        ViewActivity.setBorder(width: CGFloat(1.0), color: UIColor.gray)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
