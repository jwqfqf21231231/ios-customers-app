import UIKit
import Alamofire
import SwiftyJSON
class LoginVC: UIViewController {
    var Checkuser:[CheckUser] = []

    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Password: UITextField!
    var msg:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hideBackWord()
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        
        
  }


    func Check(){
        Services.GetCheckUser{(error:Error? , _ GetCheckuser:[CheckUser]?) in
            if let User = GetCheckuser {
                self.Checkuser = User
                let name :CheckUser = User[0]
                self.msg = name.Message as String
                Services.SaveTell(Tell: self.msg)
            }
        }
    }
    
    @IBAction func LoginAc(_ sender: Any) {
        
        guard  (UserName.text != nil)  &&  (Password.text != nil)else {
            return self.displayErrorMessage(message: "قم بإدخال رقم الجوال وكلمة المرور")
        }
        
        let parameters: [String: String]=[
            "username":UserName.text!,
            "Password":Password.text!,
            "grant_type": "password"
            ]
        Alamofire.request(Urls.login, method: .post,parameters:parameters, encoding: URLEncoding.default, headers: Urls.header)
            .validate(statusCode: 200..<300)
            .responseJSON { response  in
                
                switch response.result {
                     case .success(let value):
                        let json = JSON(value)
                        if let access_token = json["access_token"].string,
                           let UserName = json["userName"].string {
                        Services.saveSessions(access_token: access_token)
                        Services.SaveUser(UserName: UserName)
                        self.loadLoginScreen()
                            
                        print(access_token)
                            self.Check()
                        } else {
                        print("error .. !")
                        self.displayErrorMessage(message: "أدخل كلمة مرور صحيحة")
                        }
                        
                        print(response)
                    case .failure(let error):
                        self.displayErrorMessage(message: "عذرا قم بالتأكد من إدخالك رقم الجوال وكلمة السر /n رقم الجوال يحتوي علي ")
                        print(error)
                }
        }
        
    }
    
   
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "خطأ في الأدخال", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "رجوع ", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil) }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "TbBarVS") as! TbBarVS
        self.present(viewController, animated: true, completion: nil) }

}


        
       

    


