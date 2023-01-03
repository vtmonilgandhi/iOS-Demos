//
//  OrderListViewModel.swift
//  HotCoffeeApp
//
//  Created by Mohammad Azam on 7/31/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class OrderListViewModel: ObservableObject {
    
    @Published
    var orders = [OrderViewModel]()
    var viewContext: NSManagedObjectContext?
    
    init(viewContext: NSManagedObjectContext? = nil) {
        self.viewContext = viewContext
        //        fetchAllOrders()
    }
    
    func deleteOrder(_ orderVM: OrderViewModel) {
        self.deleteOrder(name: orderVM.name)
        fetchAllOrders()
    }
    
    func fetchAllOrders() {
        self.orders = self.getAllOrders().map(OrderViewModel.init)
        print(self.orders)
    }
    
    
    private func fetchOrder(name: String) -> Order? {
        
        var orders = [Order]()
        
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            orders = try viewContext!.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        
        return orders.first
        
    }
    
    func getAllOrders() -> [Order] {
        
        var orders = [Order]()
        
        let orderRequest: NSFetchRequest<Order> = Order.fetchRequest()
        
        do  {
            orders = try viewContext!.fetch(orderRequest)
            print(orders)
        } catch {
            print(error.localizedDescription)
        }
        
        return orders
    }
    
    func deleteOrder(name: String) {
        
        do {
            if let order = fetchOrder(name: name) {
                viewContext!.delete(order)
                try viewContext!.save()
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    
}

class OrderViewModel {
    
    var name = ""
    var type = ""
    
    init(order: Order) {
        self.name = order.name!
        self.type = order.type!
    }
    
}
