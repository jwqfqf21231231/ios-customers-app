//
//  ActivityVC.swift
//  Paypal
//
//  Created by Suzan Amassy on 3/31/18.
//  Copyright © 2018 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ActivityVC: UIViewController, UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var ActivaityTB: UITableView!
    var ActivityItem = [ActivityModel]()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        self.title = "الشحن"

          self.navigationItem.hideBackWord()
        ActivaityTB.dataSource = self
        ActivaityTB.delegate = self
        ActivityData()
    }
    
    func ActivityData(){
        Services.Activity{(error:Error? , Actity:[ActivityModel]?) in
            if let activity = Actity {
                self.ActivityItem = activity
                self.ActivaityTB.reloadData()
                print(activity)
             }}}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
  
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActivityItem.count
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        cell.ExpireDate?.text = ActivityItem[indexPath.row].NewExpiryDate
        cell.GroupName!.text = ActivityItem[indexPath.row].GroupName
        let date = ActivityItem[indexPath.row].Serial
        cell.Serial.text = "\( date)"
        cell.UseDate?.text = ActivityItem[indexPath.row].UseDate
        cell.Point?.text = ActivityItem[indexPath.row].point
        let priceData = ActivityItem[indexPath.row].Price
        cell.Price?.text = "السعر: \(priceData)"
        
        return cell
    }
    

}



