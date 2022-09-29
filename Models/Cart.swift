//
//  Cart.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 28/04/2021.
//

import Foundation
import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}



