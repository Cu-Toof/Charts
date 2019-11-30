//
//  BubbleChartViewController.swift
//  ChartsDemo-iOS
//
//  Created by Jacob Christie on 2017-07-09.
//  Copyright © 2017 jc. All rights reserved.
//

import UIKit
import Charts

class BubbleChartViewController: DemoBaseViewController {
    
    @IBOutlet var chartView: BubbleChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Bubble Chart"
        self.options = [.toggleValues,
                        .toggleIcons,
                        .toggleHighlight,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .saveToGallery,
                        .togglePinchZoom,
                        .toggleAutoScaleMinMax,
                        .toggleData]
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = false
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 200
        chartView.pinchZoomEnabled = true
        chartView.legend.enabled = false
        
        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        chartView.leftAxis.spaceTop = 0.3
        chartView.leftAxis.spaceBottom = 0.3
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.labelCount = 7
        chartView.leftAxis.granularity = 4
        
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        sliderX.value = 10
        sliderY.value = 50
        slidersValueChanged(nil)
    }
    
    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setDataCount(7, range: UInt32(sliderY.value))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        var yVals1 = (0..<count).map { (i) -> BubbleChartDataEntry in
            return BubbleChartDataEntry(x: Double(i), y: 5, size: 5)
        }
        yVals1.append(BubbleChartDataEntry(x: Double(yVals1.count-1), y: 0, size: 0))
        
        var yVals2 = (0..<count).map { (i) -> BubbleChartDataEntry in
            return BubbleChartDataEntry(x: Double(i), y: 12, size: 5)
        }
        yVals2.append(BubbleChartDataEntry(x: Double(yVals1.count-1), y: 0, size: 0))
        
        var yVals3 = (0..<count).map { (i) -> BubbleChartDataEntry in
            return BubbleChartDataEntry(x: Double(i), y: 20, size: 5)
        }
        yVals3.append(BubbleChartDataEntry(x: Double(yVals1.count-1), y: 0, size: 0))
        
        let set3 = BubbleChartDataSet(entries: yVals3, label: "DS 3")
        set3.drawValuesEnabled = true
        set3.drawBarGradientEnabled = true
        set3.gradientPositions = [0, 100]
        set3.colors = [
            UIColor.black,
            UIColor(red: 255/255, green: 14/255, blue: 19/255, alpha: 1)
        ]
        
        let data = BubbleChartData(dataSets: [set3])
        data.setDrawValues(false)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 7)!)
        data.setHighlightCircleWidth(1.5)
        data.setValueTextColor(.white)
        
        chartView.data = data
    }
    
    override func optionTapped(_ option: Option) {
        super.handleOption(option, forChartView: chartView)
    }
    
    // MARK: - Actions
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
