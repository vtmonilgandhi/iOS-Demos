//
//  AddOrderViewModel.swift
//  HotCoffeeApp
//
//  Created by Monil Gandhi on 05/10/20.
//

import Foundation
import SwiftUI
import CoreData

class AddOrderViewModel {
    
    
    var name: String = ""
    var type: String = ""
    var viewContext: NSManagedObjectContext?
    
    init(context: NSManagedObjectContext? = nil) {
        self.viewContext = context
    }
    
    func saveOrder() {
        let order = Order(context: viewContext!)
        order.name = name
        order.type = type
        
        do {
            try viewContext!.save()
            print("Order saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}
