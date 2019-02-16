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
    
    class func SaveTell()-> String?{
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
        guard let api_User = Services.SaveTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
//            "userID": "082853838@gfusion"
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
        guard let api_User = Services.SaveTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
//            "userID": "082853838@gfusion"
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
                        print(ProfileItem)
                        
                        
                    }
                    completion(nil, ProfileModel)
                }
                
        }
    }
    
    //    Account History
    
    class func AccountHistory(completion: @escaping(_ error: Error?, _ AccountHistory: [AccountHistoryModel]?)->Void){
        let url = Urls.AccountHisotry
        guard let api_User = Services.SaveTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
//            "userID": "082853838@gfusion"
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
        guard let api_User = Services.getApiUser() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
            "id": id
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
                        getPriceModel.append(priceItem)
                    }
                    completion(nil, getPriceModel)
                }
        }
        
    }
    
    class func BadHistory(completion: @escaping(_ error: Error?, _ BadHistoryModel: [BadHistoryModel]?)->Void){
        let url = Urls.BadHistory
        guard let api_User = Services.SaveTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
//            "userID": "082853838@gfusion"
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
                        print(GetBadHistoryModel)
                    }
                    completion(nil, GetBadHistoryModel)
                }
        }
        
    }
    //    Check Exit OverDownload
    class func CheckExitOverDownload(completion: @escaping(_ error: Error?, _ CheckExit: [CheckExit]?)->Void){
        let url = Urls.CheckExit
        guard let api_User = Services.SaveTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
            "userID" : api_User
//            "userID": "082853838@gfusion"
        ]
        print("param", Params)
        Alamofire.request(url, method: .get, parameters:Params ,encoding: URLEncoding.default, headers: Urls.header)
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
        guard let api_User = Services.SaveTell() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
            "userID" : api_User
//            "userID": "082853838@gfusion"
        ]
        print("param", Params)
        Alamofire.request(url, method: .post, parameters:Params ,encoding: URLEncoding.default, headers: Urls.header)
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
        guard let api_User = Services.getApiUser() else {
            completion(nil,nil)
            return
        }
        print("",api_User)
        
        let Params:[String: Any] = [
            "userID": api_User
        ]
        print("param", Params)
        Alamofire.request(url, method: .post, parameters:Params ,encoding: URLEncoding.default, headers: Urls.header)
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
                    }
                    completion(nil, GetCheckUser)
                }
        }
        
    }
    
    
}
