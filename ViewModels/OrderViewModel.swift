//
//  OrderViewModel.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 06/05/2021.
//

import Foundation

class Order: NSObject, ObservableObject {
    
    @Published var streetAdress = ""
    @Published var city = ""
    @Published var postcode = ""
    @Published var orderEmail = ""
    @Published var streetAdressLine_2 = ""
    @Published var name = ""
    
    @Published var DeliveryOptions = ["Collection - £0.00","5 Working Days - £4.99", "3 Working Days - £6.99", "Next Day - £7.49"]
    @Published var currentDeliveryOption = ""
    
    @Published var deliveryPrices = ["": 0.00, "Collection - £0.00": 0, "5 Working Days - £4.99":4.99, "3 Working Days - £6.99": 6.99, "Next Day - £7.49": 7.99]
    
    @Published var hasPaid = false
    
    func placeOrder() {
    
    }
}
