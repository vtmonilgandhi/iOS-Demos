//
//  ContentView.swift
//  GoodWeather
//
//  Created by Monil Gandhi on 26/09/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    init() {
        self.weatherVM = WeatherViewModel()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            TextField("Enter city name", text: self.$weatherVM.cityName, onCommit:  {
                self.weatherVM.search()
            }).font(.custom("Arial", size: 50))
            .padding()
            .fixedSize()
            
            Text(self.weatherVM.temperature)
                .font(.custom("Arial", size: 100))
                .foregroundColor(.red)
                .offset(y: 100)
                .padding()
            
        }.frame(minWidth: 0,
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                minHeight: 0,
                maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
