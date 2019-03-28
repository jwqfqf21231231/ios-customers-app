//
//  AccountHistoryCell.swift
//  BayanPay
//
//  Created by Mohanad on 1/31/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class AccountHistoryCell: UITableViewCell {
    
    @IBOutlet weak var ViewAccount: UIView!
    
    @IBOutlet weak var IPAddress: UILabel!
    @IBOutlet weak var Upload: UILabel!
    @IBOutlet weak var Download: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Speed: UILabel!
    @IBOutlet weak var AccDate: UILabel!
    @IBOutlet weak var TDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewAccount.setRounded(radius: 10)
        ViewAccount.setBorder(width: CGFloat(1.0), color: UIColor.white)

    }
    
   


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
