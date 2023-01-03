//
//  ContentView.swift
//  BarChartDemo
//
//  Created by Monil Gandhi on 05/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BarGraph(reports: Report.all())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
