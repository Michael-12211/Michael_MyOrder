//
//  ContentView.swift
//  Shared
//
//  Created by Michael Kempe on 2021-09-24.
//  Student ID: 991566501
//

import SwiftUI

struct ContentView: View {
    
    //initiating orders
    @StateObject var orders = Orders()
    
    //setting picker values
    @State private var type = "Dark roast"
    var coffees = ["Dark roast", "Mocha", "Latte", "Cappachino"]
    @State private var size = "Small"
    var sizes = ["Small", "Medium", "Large"]
    @State private var quantity = "1"
    
    //note: .onTapGesture is placed on most fields, as it is necessary in order to close the numberpad, but putting it on the navView prevents the navigation and segmented picker from working
    var body: some View {
        NavigationView{
                VStack
                {
                    /*Button(action:{
                        print("navigating to next screen")
                    }){
                        NavigationLink("view orders", destination: OrderList())
                            .font(.system(size: 30)).padding().background(Color(white:0.9)).cornerRadius(10)
                    }
                    .frame(width: 330, height: 10, alignment: .topTrailing)
                    .navigationBarTitle("Place order", displayMode: .inline)*/
                    
                    HStack
                    {
                        Text("Coffee type:")
                            .padding(.leading, 50.0)
                            .onTapGesture {
                                self.endEditing()
                            }
                        Picker("Please choose coffee type", selection: $type){
                        ForEach(coffees, id: \.self) {
                            Text($0)
                        }
                            
                    }
                    .frame(height: 300.0)
                        .pickerStyle(WheelPickerStyle())                    }
                    .navigationBarTitle("Place order", displayMode: .inline)
                    .navigationBarItems(trailing: Button(action:{
                        print("navigating to next screen")
                    }){
                        NavigationLink("view orders >", destination: OrderList())
                            /*.font(.system(size: 30)).padding().background(Color(white:0.9)).cornerRadius(10)*/
                    })
                    
                    Text("Coffee size:")
                        .padding(0.0)
                        .onTapGesture {
                            self.endEditing()
                        }
                    Picker("Please choose size", selection: $size){
                        ForEach(sizes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    HStack
                    {
                        Text("Quantity:")
                            .onTapGesture {
                                self.endEditing()
                            }
                        TextField("Quantity", text: $quantity, onCommit: {UIApplication.shared.endEditing()}).padding().keyboardType(.numberPad)
                    }
                    .padding()
                    
                    //Text("You selected \(type)")
            
                    Button("Add order") {
                        //orders.type = type
                        //orders.size = size
                        //orders.qnt = quantity
                        let ord = Order(type:type,size:size,qnt:quantity)
                        orders.ord.append(ord)
                    }
                    .font(.system(size: 30)).padding().background(Color(white:0.9)).cornerRadius(10)
                    
                }
        }
        .environmentObject(orders)
        /*.onTapGesture {
            self.endEditing()
        }*/
        
        
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
    
}

//this method for hiding a numberpad was retreived from https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
