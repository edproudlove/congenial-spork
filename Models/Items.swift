//
//  Items.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 24/04/2021.
//

import SwiftUI


import SwiftUI

struct UserData: Identifiable {
    var id: String
    var first_name: String
    var email: String
    var last_name: String

}

struct Item: Identifiable {
    var id: String
    var item_name: String
    //var item_ratings: String
    //var item_details: String
    var item_cost: Float
    var item_image: String
    var item_selectedTab: String
    
    //to identify weather it is in the cart:
    var isAdded: Bool = false
    
}

//var Test = Item(id: "hello", item_name: "hello", item_cost: 12, item_image: "hello", item_selectedTab: "bber")
