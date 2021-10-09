//
//  CoreDBHelper.swift
//  Michael_MyOrder (iOS)
//
//  Created by Michael Kempe on 2021-10-07.
//

import Foundation
import CoreData
import UIKit

class CoreDBHelper: ObservableObject{
    
    @Published var mOrders = [OrderMO]()
    
    //singleton instance (pattern)
    private static var shared : CoreDBHelper?
    
    static func getInstance() -> CoreDBHelper {
        if shared != nil{
            //instance of CoreDBHelper class already exists, so return the same
            return shared!
        }else{
            //there is no existing instance of CoreDBHelper class, so create new and return
            shared = CoreDBHelper(context: PersistenceController.preview.container.viewContext)
            return shared!
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "OrderMO"
    
    init(context: NSManagedObjectContext){
        self.moc = context
    }
    
    func insertTask(order: Order){
        do{
            
            let insertedOrder = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! OrderMO
            
            insertedOrder.id = UUID()
            insertedOrder.type = order.type
            insertedOrder.size = order.size
            insertedOrder.quantity = order.qnt
            insertedOrder.dateOrdered = Date()
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "Order saved")
            }
            
        }catch let error as NSError{
            print(#function, "Order not saved: \(error)")
        }
    }
    
    func getAllOrders(){
        let fetchRequest = NSFetchRequest<OrderMO>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "dateOrdered", ascending: false)]
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "\(result.count) fetched")
            self.mOrders.removeAll()
            self.mOrders.insert(contentsOf: result, at: 0)
            
        }catch let error as NSError{
            print(#function, "Couldn't fetch data: \(error)")
        }
    }
    
    private func searchOrder(orderID : UUID) -> OrderMO?{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", orderID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0{
                return result.first as? OrderMO
            }
        }catch let error as NSError{
            print(#function, "Unable to search for data \(error)")
        }
        
        return nil
        
    }
    
    func deleteOrder(orderID : UUID){
        let searchResult = self.searchOrder(orderID: orderID)
        
        if (searchResult != nil){
            //matching object found
            do{
                self.moc.delete(searchResult!)
                
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Deleted")
            }catch let error as NSError{
                print(#function, "Couldn't delete: \(error)")
            }
        }else{
            print(#function, "Order not found")
        }
    }
    
    func updateBook(updatedOrder: OrderMO){
        let searchResult = self.searchOrder(orderID: updatedOrder.id! as UUID)
        
        if (searchResult != nil){
            //matching object found
            do{
                let orderToUpdate = searchResult!
                
                orderToUpdate.type = updatedOrder.type
                orderToUpdate.size = updatedOrder.size
                orderToUpdate.quantity = updatedOrder.quantity
                
                
                try self.moc.save()
                objectWillChange.send()
                print(#function, "Updated")
                
            }catch let error as NSError{
                print(#function, "Couldn't update: \(error)")
            }
        }else{
            print(#function, "Order not found")
        }
    }
    
    
}
