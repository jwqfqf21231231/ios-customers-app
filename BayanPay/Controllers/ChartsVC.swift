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
    var x:Int = 0
    var y:Int = 0
    var ChartItem = [Chart]()
    @IBOutlet weak var PieChartView: PieChartView!
    
    var DataEntryX = PieChartDataEntry(value: 60)
    var DataEntryY = PieChartDataEntry(value: 200)
    var NumberOfRows = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
        PieChartView.chartDescription?.text = ""
//        PieChartView.isUserInteractionEnabled = false
       
        //UpdateData()
    }
    
    //function set and show data
    func UpdateData(){
        //Configration of chart and set data of x , y
        DataEntryX.value = Double(self.x)
        DataEntryY.value = Double(self.y)
        DataEntryY.label = "نسبة التحميل"
        DataEntryX.label = "نسة المتبقي"
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
                case .failure(let error):
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
                        self.x = self.x + Chartitem.x
                        Chartitem.y = data["y"]?.int ?? 0
                        self.y = self.y + Chartitem.y
                        Charts.append(Chartitem)
                        print("Chart",data)
                    }
                    //set Data after load from api
                    self.UpdateData()
                }
        }
        
    }
    }
    
    

