//
//  Report.swift
//  BarChartDemo
//
//  Created by Monil Gandhi on 05/10/20.
//

import Foundation

struct Report: Hashable {
    
    let year: String
    let revenue: Double
    
}

extension Report {
    
    static func all() -> [Report] {
        
        return [
        
            Report(year: "2001", revenue: 1500),
            Report(year: "2002", revenue: 3500),
            Report(year: "2003", revenue: 8500)
        ]
        
    }
    
}
