//
//  ChartsVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/1/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class ChartsVC: UIViewController {
    var x:Double = 0
    var y:Double = 0
    var ChartItem = [Chart]()
    @IBOutlet weak var PieChartView: PieChartView!
    
    var DataEntryX = PieChartDataEntry(value: 60)
    var DataEntryY = PieChartDataEntry(value: 200)
    var NumberOfRows = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
        PieChartView.chartDescription?.text = ""
    }
    
    
    //function set and show data
    func UpdateData(){
        //Configration of chart and set data of x , y
        DataEntryX.value = self.x
        DataEntryY.value = self.y
        DataEntryY.label = "نسبة المتبقي"
        DataEntryX.label = "نسبة التحميل"
        NumberOfRows = [DataEntryX,DataEntryY]
    
        let chartDataSet = PieChartDataSet(values:NumberOfRows, label:nil)
        let ChartData = PieChartData(dataSet: chartDataSet)
       
        let colors = [UIColor(named: "iosColor"),UIColor(named: "macColor")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        PieChartView.data = ChartData
        
        
    }
    
    func GetData(){
        guard let api_User = Services.getApiTell() else {
            return }
        let url = Urls.GetUserDownloadChart
        let ChartURL = url + api_User
        Alamofire.request(ChartURL, method: .get, encoding: URLEncoding.default, headers: Urls.header)
            .responseJSON { response in
                switch response.result {
                case .failure( _):
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
                        self.x = self.x + Double(Chartitem.x) * 100
                        Chartitem.y = data["y"]?.int ?? 0
                        self.y = self.y + Double(Chartitem.y) * 100
                        Charts.append(Chartitem)
                        print("Chart",data)
                    }
                    
                    //set Data after load from api
                    self.UpdateData()
                }
        }
        
    }
    }
    
    

