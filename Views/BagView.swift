//
//  BagView.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 24/04/2021.
//
//
//  BagView.swift
//  Touchdown
//
//  Created by Ethan Proudlove on 11/04/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    
    var itemData: Item
    var animation: Namespace.ID
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
        
            ZStack {
                //here we display the Imgaes and the
                
                //Color(bagData.image)
                 //   .cornerRadius(15)// predetermined color in the assest file.
                
                WebImage(url: URL(string : itemData.item_image)) // predetrmied String or URL for webImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.padding(20)
                    .cornerRadius(30)
                    .shadow(radius: 5)
                    .matchedGeometryEffect(id: itemData.item_image, in: animation)
            }
                
                Text(itemData.item_name)
                    .font(Font.custom("BebasNeue", size: 23))
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                
                Text("£\(String(format: "%.2f", itemData.item_cost))")
                    .font(Font.custom("BebasNeue", size: 23))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
        }
        
    }
}
