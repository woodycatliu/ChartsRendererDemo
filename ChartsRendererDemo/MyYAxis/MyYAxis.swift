//
//  MyYAxis.swift
//  ChartsRendererDemo
//
//  Created by Woody on 2020/12/15.
//

import Foundation
import Charts

class MyYAxis : YAxisRenderer {
    
    override func drawYLabels(context: CGContext, fixedPosition: CGFloat, positions: [CGPoint], offset: CGFloat, textAlign: NSTextAlignment)
    {
        guard let yAxis = self.axis as? YAxis else { return }
        let labelFont = yAxis.labelFont
        
        let from = yAxis.isDrawBottomYLabelEntryEnabled ? 0 : 1
        let to = yAxis.isDrawTopYLabelEntryEnabled ? yAxis.entryCount : (yAxis.entryCount - 1)
        
        let xOffset = yAxis.labelXOffset
        
        for i in from..<to
        {
            let text = yAxis.getFormattedLabel(i)
            // 加上一個回圈。NSAttributedString 顏色改上自定義的 color 解決
            let color: UIColor
            if let value = Double(text) {
                if value <= 0 {
                    color = .clear
                } else if value > 0 &&  value <= 100 {
                    color = .black
                }else if  value > 100 &&  value <= 200 {
                    color = .red
                }else if value > 201 &&  value <= 300 {
                    color = .systemYellow
                }else if value > 300 && value <= 400{
                    color = .blue
                } else {
                    color = .black
                }
            }else { color = .black }
            
            ChartUtils.drawText(context: context, text: text, point: CGPoint(x: fixedPosition + xOffset, y: positions[i].y + offset), align: textAlign, attributes: [.font: labelFont, .foregroundColor: color])
        }
    }
    
    
}
