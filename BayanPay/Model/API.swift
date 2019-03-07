//
//  API.swift
//  BayanPay
//
//  Created by Mohanad on 1/16/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Services: NSObject {
     var window: UIWindow?
    
    class func restartapp(){
        guard let window = UIApplication.shared.keyWindow else { return }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController
        if lunched() != nil {
            vc = sb.instantiateViewController(withIdentifier: "TbBarVS")
        }else {
            vc = sb.instantiateViewController(withIdentifier: "login")
        }
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func removeSessions(session_id:String){
        let defualt = UserDefaults.standard
        defualt.removeObject(forKey: "UserName")
        defualt.synchronize()
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "UserName")
        defaults.removeObject(forKey: "Message")
        defaults.synchronize()
    }
    
    
    class func lunched() -> String? {
        let defualt = UserDefaults.standard
        return defualt.object(forKey: "UserName") as? String
        defualt.synchronize()
        
    }
    class func cleansession() -> String? {
        let defualt = UserDefaults.standard
        return defualt.object(forKey: "") as? String
        defualt.synchronize()
        
    }
    
    class func removeUser() -> String? {
        let defaults = UserDefaults.standard
        return defaults.removeObject(forKey: "UserName") as? String
        defaults.synchronize()
    }
    
    class func saveSessions(access_token:String){
        let defualt = UserDefaults.standard
        defualt.setValue(access_token, forKey: "access_token")
        defualt.synchronize()
    }
    
    class func SaveUser(UserName:String){
        let defualt = UserDefaults.standard
        defualt.setValue(UserName, forKey: "UserName")
        defualt.synchronize()
    }
    
    class func SaveTell(Tell:String){
        let defualt = UserDefaults.standard
         defualt.setValue(Tell, forKey: "Message")
         defualt.synchronize()
     
    }
    class func getApiTell()-> String?{
        let defualt = UserDefaults.standard
        return defualt.object(forKey: "Message") as? String
        
    }
    
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "access_token") as? String
    }
    class func getApiUser() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "UserName") as? String
    }
    
    //    Activity Request
    
    class func Activity(completion: @escaping(_ error: Error?, _ Actity: [ActivityModel]?)->Void){
        let url = Urls.getBinHistory
        guard let api_User = Services.getApiTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
            "userID" : api_User
        ]
        print("param", Params)
        Alamofire.request(url, method: .get, parameters:Params ,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    print(url)
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var Activity = [ActivityModel]()
                    for data in dataArr {
                        
                        guard let data = data.dictionary else { return }
                        let activity = ActivityModel()
                        activity.GroupName = data["GroupName"]?.string ?? ""
                        activity.NewExpiryDate = data["NewExpiryDate"]?.string ?? ""
                        activity.point = data["point"]?.string ?? ""
                        activity.Price = data["Price"]?.int ?? 0
                        activity.Serial = data["Serial"]?.int ?? 0
                        activity.UseDate = data["UseDate"]?.string ?? ""
                        Activity.append(activity)
                        print([Activity])
                    }
                    
                    completion(nil, Activity)
                }
                
        }
    }
    
    
    // Profile Request
    
    class func UserProfile(completion: @escaping(_ error: Error?, _ Profile: [Profile]?)->Void){
        let url = Urls.userProfile
        guard let api_User = Services.getApiTell() else {
            completion(nil,nil)
            return
        }
        print("api",api_User)
        
        let Params:[String: Any] = [
            "userID" : api_User
            
        ]
        print("param", Params)
        Alamofire.request(url, method: .get, parameters:Params ,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    print(url)
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else {
                        return }
                    var ProfileModel:[Profile] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        var ProfileItem = Profile()
                        ProfileItem.UserID = data["UserID"]?.string ?? ""
                        ProfileItem.UserName = data["UserName"]?.string ?? ""
                        ProfileItem.Mobile = data["Mobile"]?.string ?? ""
                        ProfileItem.Password = data["Price"]?.string ?? ""
                        ProfileItem.Hamla = data["Hamla"]?.string ?? ""
                        ProfileItem.ExpiryDate = data["ExpiryDate"]?.string ?? ""
                        ProfileItem.UserOnline = data["UserOnline"]?.bool ?? true
                        ProfileItem.Isbad = data["Isbad"]?.bool ?? false
                        ProfileItem.Email = data["Email"]?.string ?? ""
                        ProfileModel.append(ProfileItem)
                        
                    }
                    completion(nil, ProfileModel)
                }
                
        }
    }
    
    //    Account History
    
    class func AccountHistory(completion: @escaping(_ error: Error?, _ AccountHistory: [AccountHistoryModel]?)->Void){
        let url = Urls.AccountHisotry
        guard let api_User = Services.getApiTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
            "userID" : api_User
        ]
        print("param", Params)
        Alamofire.request(url, method: .get, parameters:Params ,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    print(url)
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else {
                        return }
                    var AccountHistory:[AccountHistoryModel] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let AccountItem = AccountHistoryModel()
                        
                        AccountItem.IP = data["IP"]?.string ?? ""
                        AccountItem.AcctDate = data["AcctDate"]?.string ?? ""
                        AccountItem.Download = data["Download"]?.string ?? ""
                        AccountItem.Upload = data["Upload"]?.string ?? ""
                        AccountItem.Speed = data["Speed"]?.string ?? ""
                        AccountItem.Time = data["Time"]?.string ?? ""
                        AccountHistory.append(AccountItem)
                        print(AccountItem)
                    }
                    completion(nil, AccountHistory)
                }
                
        }
    }
    //     Get Hamla Price Out Price
    
    class func GetPrice( id:Int ,completion: @escaping(_ error: Error?, _ PriceModel: [PriceModel]?)->Void){
        let url = Urls.Price
    let PriceURL = url + "\(id)"
        print(PriceURL)
        Alamofire.request(PriceURL, method: .get, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    print(url)
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else {
                        return }
                    var getPriceModel:[PriceModel] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let priceItem = PriceModel()
                        priceItem.ID = data["ID"]?.int ?? 0
                        priceItem.name = data["name"]?.string ?? ""
                        priceItem.price1 = data["price1"]?.int ?? 0
                        priceItem.price2 = data["price2"]?.int ?? 0
                        priceItem.price3 = data["price3"]?.int ?? 0
                        priceItem.price4 = data["price4"]?.int ?? 0
                        priceItem.price6 = data["price6"]?.int ?? 0
                        priceItem.price12 = data["price12"]?.int ?? 0
                        priceItem.group = data["group"]?.string ?? ""
                         priceItem.q = data["q"]?.int ?? 0
                        getPriceModel.append(priceItem)
                    }
                    completion(nil, getPriceModel)
                }
        }
        
    }
    
    
    class func BadHistory(completion: @escaping(_ error: Error?, _ BadHistoryModel: [BadHistoryModel]?)->Void){
        let url = Urls.BadHisotry
        guard let api_User = Services.getApiTell() else {
            completion(nil,nil)
            return
        }

        let BadhistoryUrl = url + "userID=" + api_User + "@gfusion"
        Alamofire.request(BadhistoryUrl, method: .get ,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else {
                        return }
                    var GetBadHistoryModel:[BadHistoryModel] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let BadItem = BadHistoryModel()
                        BadItem.ID = data["ID"]?.string ?? ""
                        BadItem.Date = data["Date"]?.string ?? ""
                        BadItem.DownloadPerDay = data["DownloadPerDay"]?.int ?? 0
                        GetBadHistoryModel.append(BadItem)
                    }
                    completion(nil, GetBadHistoryModel)
                }
        }
        
    }
    //    Check Exit OverDownload
    class func CheckExitOverDownload(completion: @escaping(_ error: Error?, _ CheckExit: [CheckExit]?)->Void){
        let url = Urls.CheckExit
        guard let api_User = Services.getApiTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
     let checkURL = url + api_User

        Alamofire.request(checkURL, method: .get ,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else {
                        return }
                    var GetCheckExit:[CheckExit] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let CheckExitItem = CheckExit()
                        CheckExitItem.Total = data["Total"]?.int ?? 0
                        CheckExitItem.Status = data["Status"]?.int ?? 0
                        
                        GetCheckExit.append(CheckExitItem)
                        print(GetCheckExit)
                    }
                    completion(nil, GetCheckExit)
                }
        }
        
    }
    
//    Exit Over Download
    class func ExitOverDown(completion: @escaping(_ error: Error?, _ ExitOverModel:[ExitOverDownload]?)->Void){
        let url = Urls.ExitOverDown
        guard let api_User = Services.getApiTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
      let exitURL = url + api_User
        Alamofire.request(exitURL, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var GetExit:[ExitOverDownload] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let ExitItem =  ExitOverDownload()
                        ExitItem.Message = data["Message"]?.string ?? ""
                        ExitItem.Total = data["Total"]?.string ?? ""

                        GetExit.append(ExitItem)
                        print(GetExit)
                    }
                    completion(nil, GetExit)
                }
        }
        
    }
    
    //    CheckUser
    class func GetCheckUser(completion: @escaping(_ error: Error?, _ CheckUser:[CheckUser]?)->Void){
        let url = Urls.CheckUser
        guard let api_User = Services.getApiUser() else { completion(nil,nil)
            return }

        Alamofire.request(url + "MobileNo=" + api_User, method: .post,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var GetCheckUser:[CheckUser] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let CheckUserItem =  CheckUser()
                        CheckUserItem.Message = data["Message"]?.string ?? ""
                        CheckUserItem.FullName = data["FullName"]?.string ?? ""
                        CheckUserItem.Usertype = data["Usertype"]?.int ?? 0
                        GetCheckUser.append(CheckUserItem)
                        print("tell",data)
                    }
                    completion(nil, GetCheckUser)
                }
        }
        
    }
    
//    Get Hamla List
    class func GetHamlaListPost(completion: @escaping(_ error: Error?, _ HamlaList:[HamlaList]?)->Void){
        let url = Urls.GetHamlaList
        guard let api_User = Services.getApiTell() else {
            completion(nil,nil)
            return
        }
        let HamlaListURL = url + api_User
        Alamofire.request(HamlaListURL, method: .post,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var GetHamlaList:[HamlaList] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let GetHamlaItem =  HamlaList()
                        GetHamlaItem.id = data["id"]?.int ?? 0
                        GetHamlaItem.name = data["name"]?.string ?? ""
                        GetHamlaItem.type = data["Type"]?.int ?? 0
                        GetHamlaList.append(GetHamlaItem)
                        print("tell",data)
                    }
                    completion(nil, GetHamlaList)
                }
        }
        
    }
    
//    GetHamlaListSpeed
    
    class func GetHamlaSpeedGet(HamlaID:Int ,completion: @escaping(_ error: Error?, _ HamlaSpeed:[HamlaSpeed]?)->Void){
        let url = Urls.GetHamlaSpeed
        let SpeedUrl = url + "\(HamlaID)"
        Alamofire.request(SpeedUrl, method: .get,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var GetHamlaSpeed:[HamlaSpeed] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let GetHamlaSpeedItem =  HamlaSpeed()
                        GetHamlaSpeedItem.ID = data["ID"]?.int ?? 0
                        GetHamlaSpeedItem.Title = data["Title"]?.string ?? ""
                        GetHamlaSpeed.append(GetHamlaSpeedItem)
                        print("tell",data)
                    }
                    completion(nil, GetHamlaSpeed)
                }
        }
        
    }
//    Get Period
    class func GetHamlaPeriodGet(Speed:Int, Hamla:Int, completion: @escaping(_ error: Error?, _ HamlaPeriod:[HamlaPeriod]?)->Void){
        let url = Urls.GetHamlaPeriod
        let PeriodUrl = url + "\(Hamla)" + "&speedid=" + "\(Speed)"
        print("URL SPEEED",PeriodUrl)
       Alamofire.request(PeriodUrl, method: .get,encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var GetHamlaPeriod:[HamlaPeriod] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let GetHamlaPeriodItem =  HamlaPeriod()
                        GetHamlaPeriodItem.ID = data["ID"]?.int ?? 0
                        GetHamlaPeriodItem.Title = data["Title"]?.string ?? ""
                        GetHamlaPeriod.append(GetHamlaPeriodItem)
                        print("tell",data)
                    }
                    completion(nil, GetHamlaPeriod)
                }
        }
        
    }
    
//    add Ticket
    
    class func AddTicketPost(Mobile:String, Note:String,Name:String, completion: @escaping(_ error: Error?, _ Ticket:[Ticket]?)->Void){
        let url = Urls.AddTicket
          guard let api_User = Services.getApiTell() else { completion(nil,nil)
            return }
        let AddTicketURL = url + "\(api_User)" + "&name=" + "\(Name)" + "&mobile=" + "\(Mobile)" + "&nots=" + "\(Note)"
        print("URL SPEEED", AddTicketURL)
        Alamofire.request(AddTicketURL, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var AddTicket:[Ticket] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let AddTicketItem =  Ticket()
                        AddTicketItem.userid = data["userid"]?.int ?? 0
                        AddTicketItem.Name = data["Name"]?.string ?? ""
                        AddTicketItem.Mobile = data["Mobile"]?.string ?? ""
                        AddTicketItem.Note = data["Note"]?.string ?? ""
                        AddTicket.append(AddTicketItem)
                        print("tell",data)
                    }
                    completion(nil, AddTicket)
                }
        }
        
    }
//    Check Hamla
    
    class func CheckHamlat(id:Int, groupid:Int, completion: @escaping(_ error: Error?, _ CheckHamla:[CheckHamla]?)->Void){
        guard let api_User = Services.getApiTell() else {
            return }
        //        082853838&HamlaID=104&Groupid=22
        let url = Urls.CheckHamla
        let RegisterHamla = url + api_User + "&&HamlaID=" + "\(id)" + "&Groupid=" + "\(groupid)"
        print("RegisterHamla",RegisterHamla)
        Alamofire.request(RegisterHamla, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var Check:[CheckHamla] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let CheckItem =  CheckHamla()
                        CheckItem.Message = data["Message"]?.string ?? ""
                        Check.append(CheckItem)
                        print("tell",data)
                    }
                    completion(nil, Check)
                }
        }
        
    }
    
//    ChargeHamla
    class func ChargeHamlaFunc(id:Int, groupid:Int, completion: @escaping(_ error: Error?, _ ChargeHamla:[ChargeHamla]?)->Void){
        guard let api_User = Services.getApiTell() else {
            return }
        //        082853838&HamlaID=104&Groupid=22
        let url = Urls.ChargeHamla
        let Charge = url + api_User + "&&HamlaID=" + "\(id)" + "&Groupid=" + "\(groupid)"
        print("RegisterHamla",Charge)
        Alamofire.request(Charge, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var Charge:[ChargeHamla] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let ChargeItem =  ChargeHamla()
                        ChargeItem.Message = data["Message"]?.string ?? ""
                        Charge.append(ChargeItem)
                        print("tell",data)
                    }
                    completion(nil, Charge)
                }
        }
        
    }
    
    //    ChargeHamla
    class func GetChartHamla(completion: @escaping(_ error: Error?, _ Chart:[Chart]?)->Void){
        guard let api_User = Services.getApiTell() else {
            return }
        let url = Urls.GetUserDownloadChart
        let ChartURL = url + api_User
        Alamofire.request(ChartURL, method: .get, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var Charts:[Chart] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        let Chartitem =  Chart()
                        Chartitem.x = data["x"]?.int ?? 0
                        Chartitem.y = data["y"]?.int ?? 0
                        Charts.append(Chartitem)
                        print("tell",data)
                        }
                    completion(nil, Charts)
                }}}
    
    class func CheckUserMobile(completion: @escaping(_ error: Error?, _ UserMobile:[UserMobile]?)->Void){
        guard let api_User = Services.getApiUser() else {
            return }
        let url = Urls.CheckUserMobile
        let ChartURL = url + api_User
        Alamofire.request(ChartURL, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var Users:[UserMobile] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        var UsersItem =  UserMobile()
                        UsersItem.FullName = data["FullName"]?.string ?? ""
                        UsersItem.Message = data["Message"]?.string ?? ""
                          UsersItem.Usertype = data["Usertype"]?.int ?? 0
                        Users.append(UsersItem)
                        print("tell",data)
                    }
                    completion(nil, Users)
                }}}
    
    
//
    class func AddpendingMessageClass(MessageError:String,MessageCode:String, hamlaID:Int,SpeedID:Int, PeriodID:Int, completion: @escaping(_ error: Error?, _ AddpendingMessage:[AddpendingMessage]?)->Void){
        var Msgs = MessageError
        let url = Urls.AddPending
        guard let api_User = Services.getApiTell() else { return }
        let AddPending =  url + api_User + "&hamlaid=" + "\(hamlaID)" + "&speedid=" + "\(SpeedID)" + "&Month=" + "\(PeriodID)"
        
        print(AddPending)
        Alamofire.request(AddPending, method: .post, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(error,nil)
                    print("error")
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    guard let dataArr = json["data"].array else { return }
                    
                    var Add:[AddpendingMessage] = []
                    for data in dataArr {
                        guard let data = data.dictionary else { return }
                        var AddItem =  AddpendingMessage()
                        AddItem.MessageCode = data["MessageCode"]?.string ?? ""
                        AddItem.Message = data["Message"]?.string ?? ""
                        Add.append(AddItem)
                        print("tell",data)
                    }
                    completion(nil, Add)
                }}}
    
 

}
