//
//  DetailView.swift
//  Michael_MyOrder
//
//  Created by Michael Kempe on 2021-10-13.
//

import SwiftUI

struct DetailView: View {
    
    let selected : Int
    @State private var quantity: String = ""
    @State private var type: String = ""
    @State private var size: String = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coreDBHelper : CoreDBHelper
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Order Details")
                .font(.title)
                .padding(20)
            
            Text("\(size) \(type)")
            
            HStack
            {
                Text("Quantity:")
                TextField("Quantity", text: $quantity, onCommit: {UIApplication.shared.endEditing()}).padding().keyboardType(.numberPad)
            }
            
            Button(action: {
                print("update")
                self.updateOrder()
            }){
                Text("Confirm update")
            }
            
            Spacer()
        }//VStack
        .frame(maxWidth: .infinity)
        .onAppear(){
            self.quantity = "\(self.coreDBHelper.mOrders[selected].quantity)";
            self.size = self.coreDBHelper.mOrders[selected].size;
            self.type = self.coreDBHelper.mOrders[selected].type;
        }
        .onDisappear(){
            self.coreDBHelper.mOrders.removeAll()
            self.coreDBHelper.getAllOrders()
            print(#function, "OnDisappear DetailView() : \(self.coreDBHelper.mOrders)")
        }
    }
    
    private func updateOrder(){
        self.coreDBHelper.mOrders[selected].quantity = Int(self.quantity) ?? 0
        
        self.coreDBHelper.updateOrder(updatedOrder: self.coreDBHelper.mOrders[selected])
        self.presentationMode.wrappedValue.dismiss()
    }
}

/*struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}*/
