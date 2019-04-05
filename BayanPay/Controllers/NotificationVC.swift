//
//  NotificationVC.swift
//  BayanPay
//
//  Created by Mohanad on 12/30/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var NotificationTable: UITableView!
     var NotificationsVar = [NotficationModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationTable.delegate = self
        NotificationTable.dataSource = self
        NotificationsData()
      }
    
    func NotificationsData(){
        Services.GetNotification{(error:Error? , NotificationsVar:[NotficationModel]?) in
            if let NotiItem = NotificationsVar {
                self.NotificationsVar = NotiItem
                self.NotificationTable.reloadData()
                print(NotiItem)
            }}
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationsVar.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell",for: indexPath) as! NotificationCell
        cell.title?.text = NotificationsVar[indexPath.row].date
        cell.body?.text = NotificationsVar[indexPath.row].message
         return cell
    }}
