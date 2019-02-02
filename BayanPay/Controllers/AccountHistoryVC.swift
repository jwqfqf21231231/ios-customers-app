//
//  AccountHistoryVC.swift
//  BayanPay
//
//  Created by Mohanad on 1/31/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AccountHistoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 var AccountHistory = [AccountHistoryModel]()
   @IBOutlet weak var AccountHistoryTB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AccountHistoryTB.delegate = self
        AccountHistoryTB.dataSource = self
        AccountData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    func AccountData(){
        Services.AccountHistory{(error:Error? , AccountHistory:[AccountHistoryModel]?) in
            if let AccountItem = AccountHistory {
                self.AccountHistory = AccountItem
                self.AccountHistoryTB.reloadData()
                print(AccountItem)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AccountHistory.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountHistoryCell",for: indexPath) as! AccountHistoryCell
            cell.IPAddress?.text = AccountHistory[indexPath.row].IP
            cell.AccDate?.text = AccountHistory[indexPath.row].AcctDate
        
            let down = AccountHistory[indexPath.row].Download
            cell.Download?.text = "\(down)"
            let upload = AccountHistory[indexPath.row].Upload
            cell.Upload?.text = "\(upload)"
            cell.Speed?.text = AccountHistory[indexPath.row].Speed
            cell.Time?.text = AccountHistory[indexPath.row].Time
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }

}
