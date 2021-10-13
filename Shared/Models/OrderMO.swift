//
//  OrderMO.swift
//  Michael_MyOrder (iOS)
//
//  Created by Michael Kempe on 2021-10-07.
//

import Foundation
import CoreData

@objc(OrderMO)
final class OrderMO: NSManagedObject{
    @NSManaged var id: UUID?
    @NSManaged var type: String
    @NSManaged var size: String
    @NSManaged var quantity: Int
    @NSManaged var dateOrdered: Date
}

extension OrderMO{
    func convertToOrder() -> Order{
        Order(oID: id ?? UUID(), type: type, size: size, qnt: quantity)
    }
}
