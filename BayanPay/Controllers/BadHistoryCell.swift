//
//  BadHistoryCell.swift
//  BayanPay
//
//  Created by Mohanad on 2/3/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class BadHistoryCell: UITableViewCell {
    @IBOutlet weak var BadHistoryView: UIView!
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var DownloadPerDay: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BadHistoryView.setRounded(radius: 10)
        BadHistoryView.setBorder(width: CGFloat(1.0), color: UIColor.white)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
