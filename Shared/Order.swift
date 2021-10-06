//
//  ContentView.swift
//  Shared
//
//  Created by Michael Kempe on 2021-09-24.
//  Student ID: 991566501
//

import SwiftUI

//a type to store an order
struct Order : Identifiable, Hashable {
    var id = UUID()
    
    var type: String
    var size: String
    var qnt: String
    
    init(type: String, size: String, qnt: String){
        self.size = size
        self.type = type
        self.qnt = qnt
    }
}

//observable object holding the list of orders
class Orders : ObservableObject{
    @Published var ord = [Order]()
}
