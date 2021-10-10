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
    //@EnvironmentObject var orders: Orders
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {
        NavigationView{
            List {
                ForEach (self.coreDBHelper.mOrders.enumerated().map({$0}), id: \.element.self) { indx, order in
                    Text("\(order.quantity) \(order.size) \(order.type)")
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet{
                        self.coreDBHelper.deleteOrder(orderID: self.coreDBHelper.mOrders[index].id!)
                        self.coreDBHelper.mOrders.remove(at: index)
                    }
                })//onDelete
            }.navigationBarTitle("Pending orders", displayMode: .inline)
            
            
        }
        .onAppear(){
            self.coreDBHelper.getAllOrders()
        }
        .onDisappear(){self.coreDBHelper.getAllOrders()}
        
        
    }
    
    /*func delete(at offsets: IndexSet)
    {
        /*self.orders.ord.remove(atOffsets: offsets)*/
    }*/
}

struct OrderList_Previews: PreviewProvider {
    static var previews: some View {
        OrderList()
    }
}
