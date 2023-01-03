//
//  Stock.swift
//  StockApp
//
//  Created by Monil Gandhi on 06/10/20.
//

import Foundation

struct Stock: Decodable {
    let symbol: String
    let description: String
    let price: Double
    let change: String
}
