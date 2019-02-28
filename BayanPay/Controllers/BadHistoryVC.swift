//
//  BadHistoryVC.swift
//  BayanPay
//
//  Created by Mohanad on 2/3/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class BadHistoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 var BadHistory = [BadHistoryModel]()
    @IBOutlet weak var BadHistoryTB: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BadHistoryTB.delegate = self
        BadHistoryTB.dataSource = self
        GetBadHistory()
    }
    
    
    func GetBadHistory(){
        Services.BadHistory{(error:Error? , BadHistory:[BadHistoryModel]?) in
            if let BadItem = BadHistory {
                self.BadHistory = BadItem
                self.BadHistoryTB.reloadData()
                print(BadItem)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BadHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BadHistoryCell",for: indexPath) as! BadHistoryCell
        cell.ID?.text = BadHistory[indexPath.row].ID
        cell.Date?.text = BadHistory[indexPath.row].Date
        
        let DownloadPerDay = BadHistory[indexPath.row].DownloadPerDay
        cell.DownloadPerDay?.text = "\(DownloadPerDay) جيجا"
        print(DownloadPerDay)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }


}
