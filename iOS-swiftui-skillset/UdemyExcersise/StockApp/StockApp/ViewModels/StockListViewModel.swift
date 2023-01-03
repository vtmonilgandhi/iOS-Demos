//
//  StockListViewModel.swift
//  StockApp
//
//  Created by Monil Gandhi on 06/10/20.
//

import Foundation
import SwiftUI

class StockListViewModel: ObservableObject {
    
    @Published var dragOffset: CGSize = CGSize(width: 0, height: 650)
    @Published var searchTerm: String = ""
    @Published var stocks: [StockViewModel] = [StockViewModel]()
    @Published var news: [NewsArticleViewModel] = [NewsArticleViewModel]()
    
    func load() {
        fetchNews()
        fetchStocks()
    }
    
    private func fetchNews() {
        
        Webservice().getTopNews { news in
            if let news = news {
                self.news = news.map(NewsArticleViewModel.init)
            }
        }
    }
    
    private func fetchStocks() {
        
        Webservice().getStocks { stocks in
            if let stocks = stocks {
                DispatchQueue.main.async {
                    self.stocks = stocks.map(StockViewModel.init)
                }
            }
        }
    }
}
