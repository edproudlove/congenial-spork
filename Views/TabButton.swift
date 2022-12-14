//
//  TabButton.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 24/04/2021.
//
import SwiftUI

struct TabButton: View {
    
    var title: String
    @Binding var selectedTab: String
    var animation : Namespace.ID
    
    var body: some View {
        
        Button(action: {
            
            withAnimation(.spring()){selectedTab = title}
            
        }, label: {

            VStack(alignment: .leading, spacing: 6, content: {
                
                Text(title)
                    .fontWeight(.heavy)
                    .foregroundColor(selectedTab == title ? .black : .gray)
                
                if selectedTab == title {
                   
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 40, height: 4)
                        .matchedGeometryEffect(id: "Tab" , in: animation)
                }
               
            })
            .frame(width: 125)
                
            
        })
    }
}

struct TabButton_2: View {
    
    var title: String
    @Binding var selectedTab: String
    var animation : Namespace.ID
    
    var body: some View {
        
        Button(action: {
            
            withAnimation(.spring()){selectedTab = title}
            
        }, label: {

            VStack(alignment: .leading, spacing: 6, content: {
                
                Text(title)
                    .fontWeight(.heavy)
                    .foregroundColor(selectedTab == title ? .black : .gray)
                
                if selectedTab == title {
                   
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 80, height: 4)
                        .matchedGeometryEffect(id: "Tab" , in: animation)
                }
               
            })
            .frame(width: 150)
                
            
        })
    }
}
