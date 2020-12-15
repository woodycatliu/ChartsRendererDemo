//
//  ViewController.swift
//  ChartsRendererDemo
//
//  Created by Woody on 2020/12/15.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    private lazy var chartView: LineChartView = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupCharView()
    }


}


// MARK: initView
extension ViewController {
    
    private func initView() {

        chartView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chartView)
        
        chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartView.widthAnchor).isActive = true
        
    }
}


// MARK: makeData
extension ViewController {
    
    private func makeDataModel() -> [DataModel] {
        var models: [DataModel] = []
        
        for _ in stride(from: 0, through: 50, by: 1) {
            models.append(DataModel(x: Double.random(in: 0...800), y: Double.random(in: 0...500)))
        }
        
        models.sort(by: {$0.x < $1.x})
        
        return models
    }
    
    private func makeChartViewData(models: [DataModel]) -> LineChartData {
        var chartEntries: [ChartDataEntry] = []
        models.forEach {
            chartEntries.append(ChartDataEntry(x: $0.x, y: $0.y))
        }
        
        let dataSet = LineChartDataSet(entries: chartEntries, label: "OhYa")
        
        dataSet.circleHoleColor = .white
        dataSet.circleRadius = 4
        dataSet.circleHoleRadius = 2
        dataSet.setCircleColor(.systemBlue)
        
        dataSet.lineWidth = 1
        dataSet.highlightLineWidth = 1.5
        dataSet.setColor(.darkGray)
        
        
        dataSet.drawValuesEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.axisDependency = .left
        
        dataSet.fill = Fill(CGColor: UIColor.systemGray5.cgColor)
        dataSet.fillAlpha = 0.8
        dataSet.drawFilledEnabled = true
        
        dataSet.mode = .cubicBezier
        
        return LineChartData(dataSet: dataSet)
    }
    
}


// MARK: setupChartView
extension ViewController {
    
    private func setupCharView() {
        chartView.setScaleEnabled(false)
        chartView.dragXEnabled = true
        chartView.dragYEnabled = true
        chartView.dragEnabled = true
        
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.labelPosition = .bottom
        xAxis.axisLineWidth = 1
        xAxis.axisLineColor = .black
        
        xAxis.axisMinimum = 0
        xAxis.axisMaximum = 800
        chartView.setVisibleXRangeMaximum(400)

        
        xAxis.drawLabelsEnabled = true
        
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 500
        yAxis.setLabelCount(6, force: true)
        
        chartView.leftYAxisRenderer = MyYAxis(viewPortHandler: chartView.viewPortHandler, yAxis: yAxis, transformer: chartView.getTransformer(forAxis: yAxis.axisDependency))

        chartView.data = makeChartViewData(models: makeDataModel())
        
    }
    
    
    
    
}
