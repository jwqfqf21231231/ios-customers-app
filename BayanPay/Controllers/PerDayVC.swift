//
//  PerDayVC.swift
//  BayanPay
//
//  Created by Mohanad on 3/9/19.
//  Copyright © 2019 Paypal. All rights reserved.
//

import UIKit
import Charts

class PerDayVC: UIViewController {
    var limit:Double = 0.0
    var download:Double = 0.0
    @IBOutlet weak var PieChart: PieChartView!
     var PerDays = [PerDay]()
    var DataEntryLimit = PieChartDataEntry(value: 60)
    var DataEntryDownload = PieChartDataEntry(value: 200)
    var NumberOfRows = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        self.title = "نسبة التحميل اليوم"

        super.viewDidLoad()
        PieChart.chartDescription?.text = ""
        ActivityData()
    }
    
    func ActivityData(){
        Services.GetChartperDay{(error:Error? , PerDays:[PerDay]?) in
            if let char = PerDays {
                self.PerDays = char
                let limit:PerDay = char[0]
                let download:PerDay = char[0]
                self.limit = limit.limit
                self.download = download.download
                print(char)
                self.UpdateData()
            }
        }
    }
    
    
    //function set and show data
    func UpdateData(){
        //Configration of chart and set data of x , y
        DataEntryLimit.value = self.limit
        DataEntryDownload.value = self.download
        DataEntryLimit.label = "نسبة الكلية "
        DataEntryDownload.label = "نسبة التحميل المستهلك"
        NumberOfRows = [DataEntryLimit,DataEntryDownload]
        
        let chartDataSet = PieChartDataSet(values:NumberOfRows, label:nil)
        let ChartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "iosColor"),UIColor(named: "macColor")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        PieChart.data = ChartData
        
        
    }


}
