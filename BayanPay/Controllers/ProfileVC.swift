//
//  ProfileVC.swift
//  BayanPay
//
//  Created by Mohanad on 1/30/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //    var ProfileData:[Profile]
    var ProfileData:[Profile] = []
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var IsBad: UILabel!
    @IBOutlet weak var Advs: UILabel!
    @IBOutlet weak var Mobile: UILabel!
    @IBOutlet weak var Numbers: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var ExpDate: UILabel!
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         Profile()
        
    }
 
    func Profile(){
        Services.UserProfile{(error:Error? , ProfileData:[Profile]?) in
            if let User = ProfileData {
                self.ProfileData = User
                
                let name :Profile = User[0]
                self.Name.text = name.UserName
                
                let _ :Profile = User[0]
                self.Email.text = name.Email
                
                let _ :Profile = User[0]
                self.ExpDate.text = name.ExpiryDate
                
                let _ :Profile = User[0]
                let status = name.UserOnline as Bool
                
                if (status == false){
                    self.Status.text = "غير فعال"
                } else {
                    self.Status.text = "فعال"
                }
                
                let UserIs = name.Isbad as Bool
                if(UserIs == false){
                    
                    self.IsBad.text = "ليس ضمن الاستخدام العادل"
                } else{
                    
                    self.IsBad.text = "ضمن الاستخدام العادل"
                }
                
                
                let _ :Profile = User[0]
                self.Mobile.text = name.Mobile
                
                let _ :Profile = User[0]
                self.Password.text = name.Password
                
                
                let _ :Profile = User[0]
                self.Numbers.text = name.UserID
                
                let _ :Profile = User[0]
                self.Advs.text = name.Hamla
                
                
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
