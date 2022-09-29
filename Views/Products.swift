//
//  Products.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 03/05/2021.
//
import Foundation
import SwiftUI


struct Products: View {
    @ObservedObject var loginData: LogInHomeViewModel
    @StateObject var HomeModel : HomeViewModel
    
    //@State var selectedTab = scroll_tabs[0]
    @Namespace var animation
    @State var selectedBag: Item! = nil
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                
                /*
                
                HStack {
                    Text("Women")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 10)
                
                */
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    HStack(spacing: 4) {
                        
                        ForEach(scroll_tabs, id: \.self){tab in
                        
                            TabButton(title: tab, selectedTab: $HomeModel.selectedTab, animation: animation)
                            
                            
                        }
                    }
                    //.padding(.horizontal)
                    .padding(.top, 10)
                })
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $HomeModel.search)
                
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
           
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 15) {
                    
                    //need to fins a way for this to work dynamically with the selected tab.
                    
                    ForEach (HomeModel.filterd) { item in
                        
                        ItemView(itemData: item, animation: animation)
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    HomeModel.selectedBag = item
                                    HomeModel.pushToDetailView()
                                }
                            }
                        
                        }
                    }
                .padding([.bottom, .horizontal])
                //.padding(.top, 10)
                
                
                
            }
        })
            
    }
}

