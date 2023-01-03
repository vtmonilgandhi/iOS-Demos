//
//  AddOrderView.swift
//  HotCoffeeApp
//
//  Created by Monil Gandhi on 05/10/20.
//

import SwiftUI

struct AddOrderView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var addOrderVM = AddOrderViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        
        NavigationView {
            Group {
                VStack {
                    TextField("Enter name", text: self.$addOrderVM.name)
                    
                    Picker("",selection: self.$addOrderVM.type) {
                        Text("Cappuccino").tag("cap")
                        Text("Regular").tag("reg")
                        Text("Expresso").tag("ex")
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Button("Place Order") {
                        self.addOrderVM.saveOrder()
                    }.padding(8)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
                }
            }.padding()
            
            .navigationTitle("Order")
        }.onAppear {
            self.addOrderVM.viewContext = viewContext
        }
    }
}

struct AddOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrderView(isPresented: .constant(false)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
