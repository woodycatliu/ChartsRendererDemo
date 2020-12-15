//
//  DataModel.swift
//  ChartsRendererDemo
//
//  Created by Woody on 2020/12/15.
//

import Foundation


struct DataModel {
    var x: Double
    var y: Double
    
    init(x: Double, y: Double) {
        self.x = min(x, 800)
        self.y = min(y, 500)
    }
}
