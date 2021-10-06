//
//  OrderList.swift
//  Michael_MyOrder
//
//  Created by Michael Kempe on 2021-09-24.
//  Student ID: 991566501
//

import Foundation
import SwiftUI

struct OrderList: View {
    @EnvironmentObject var orders: Orders
    
    var body: some View {
        NavigationView{
            List {
                ForEach(orders.ord, id: \.self) { order in
                    Text("\(order.qnt) \(order.size) \(order.type)")
                }
                .onDelete(perform: delete)
            }.navigationBarTitle("Pending orders", displayMode: .inline)
            
        }
        
    }
    
    func delete(at offsets: IndexSet)
    {
        self.orders.ord.remove(atOffsets: offsets)
    }
}

struct OrderList_Previews: PreviewProvider {
    static var previews: some View {
        OrderList()
    }
}
