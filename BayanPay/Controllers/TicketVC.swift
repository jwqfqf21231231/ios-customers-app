//
//  TicketVC.swift
//  BayanPay
//
//  Created by Mohanad on 2/25/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class TicketVC: UIViewController {
    
    var TName:String = ""
    var TMobile:String = ""
    var TNote:String = ""
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Note: UITextField!
    @IBOutlet weak var Mobile: UITextField!
   

    override func viewDidLoad() {
        super.viewDidLoad()
  
        
       
    }
    
    func TicketSend(){
        TName = self.Name.text!
        TMobile = self.Mobile.text!
        TNote = self.Note.text!
        
        guard let api_User = Services.getApiTell() else {
            return }
        let url = Urls.AddTicket
        let AddTicketURL = url + api_User + "@gfusion" + "&name=" + "\(TName)" + "&mobile=" + "\(TMobile)" + "&nots=" + "\(TNote)"
        print("URL",AddTicketURL)
        Alamofire.request(AddTicketURL, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<500)
            .responseJSON { response  in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if  let _ = json["Success"].string,
                        let _ = json["Success"].string {
                        
                self.displayMessage(message: "قم بالتأكد من البيانات", Title: "خطأ بالادخال") } else {
                self.displayMessage(message: "سوف يتم التواصل معك باقرب وقت شكرا لتعاملك مع فيوجن", Title: "تم ارسال طلبك بنجاح")}
            print(response)
                case .failure(let error):
                    
                self.displayMessage(message: "قم بإعادة الارسال مرة أخرى", Title:"حدث خطأ ")
            print(error)
                }
        }
    }
    
    @IBAction func SendTicket(_ sender: Any) {
        if ((self.Name.text ) == "" || (self.Mobile.text == "") || (self.Note.text == ""))  {
            return displayMessage(message: "", Title: "قم بإدخال اسم والرقم والملاحظة")
        }else{
            self.Mobile.text = ""
            self.Name.text = ""
            self.Note.text = ""
            TicketSend()
        }
    }

    func displayMessage(message:String,Title:String) {
        let alertView = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "تم", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }
    



}
