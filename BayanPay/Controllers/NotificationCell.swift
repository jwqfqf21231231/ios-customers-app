//
//  NotificationCell.swift
//  BayanPay
//
//  Created by Mohanad on 3/31/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        BadHistoryView.setRounded(radius: 10)
//        BadHistoryView.setBorder(width: CGFloat(1.0), color: UIColor.white)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
