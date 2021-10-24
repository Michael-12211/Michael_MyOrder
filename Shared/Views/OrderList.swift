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
    
    @State private var selectedIndex : Int = -1
    @State private var selection : Int? = nil
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    //variables for the quantity editing
    //@Binding var show: Bool = false
    //@State private var quantity = "1"
    @State private var selected:OrderMO? = nil
    
    var body: some View {
        //NavigationView{
            ZStack(alignment: .bottom){
                NavigationLink(destination: DetailView(selected: self.selectedIndex), tag: 1, selection: $selection){}
            List {
                ForEach (self.coreDBHelper.mOrders.enumerated().map({$0}), id: \.element.self) { indx, order in
                    VStack(alignment: .leading){
                        Text("\(order.quantity) \(order.size) \(order.type)")
                    }
                    .onTapGesture {
                        self.selectedIndex = indx
                        self.selection = 1
                        //print(#function, "\(self.coreDBHelper.bookList[selectedIndex].title) selected")
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet{
                        self.coreDBHelper.deleteOrder(orderID: self.coreDBHelper.mOrders[index].id!)
                        self.coreDBHelper.mOrders.remove(at: index)
                    }
                })//onDelete
            }
            .navigationBarTitle("Pending orders", displayMode: .inline)
            }
            .onAppear(){
                self.coreDBHelper.getAllOrders()
            }
            .onDisappear(){self.coreDBHelper.getAllOrders()}
            
        /*}
        .onAppear(){
            self.coreDBHelper.getAllOrders()
        }
        .onDisappear(){self.coreDBHelper.getAllOrders()}*/
        
        
    }
    
    /*func delete(at offsets: IndexSet)
    {
        /*self.orders.ord.remove(atOffsets: offsets)*/
    }*/
    
    func updateQuantity(index: Int)
    {
        selected = self.coreDBHelper.mOrders[index];
        /*let alert = UIAlertController(title: selected!.type, message: "How many do you want?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "new quantity"
        })
        self.presentViewController(alert, animated: true, completion: saveUpdate())*/
    }
    
    func saveUpdate()
    {
        
    }
}

struct OrderList_Previews: PreviewProvider {
    static var previews: some View {
        OrderList()
    }
}

/*Button(action:
    {
        print("decreased quantity by 1");
        
        let newOrder = self.coreDBHelper.mOrders[indx];
        newOrder.quantity-=1;
        self.coreDBHelper.updateOrder(updatedOrder: newOrder)
    }
)
{
    Text("-");
}*/

/*Button(action:
    {
        print("increased quantity by 1");
        
        let newOrder = self.coreDBHelper.mOrders[indx];
        newOrder.quantity+=1;
        self.coreDBHelper.updateOrder(updatedOrder: newOrder)
    }
)
{
    Text("+");
}*/
