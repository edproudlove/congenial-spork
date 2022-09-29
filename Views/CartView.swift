//
//  CartView.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 28/04/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Stripe 

struct CartView: View {
    @ObservedObject var HomeModel: HomeViewModel
    
    
    var body: some View {
        ZStack {
            
        
            ZStack(alignment: .topLeading) {
                GeometryReader{ _ in
                    
                    VStack {
                        ScrollView {
                                VStack {
                                    ForEach(HomeModel.cartItems) { cart in
                                        
                                        HStack {
                                    
                                        WebImage(url: URL(string: cart.item.item_image))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 130, height:130)
                                            .cornerRadius(15)
                                            .shadow(radius: 3)
                                            
                                            Spacer()
                                            
                                            VStack {
                                            
                                                HStack {
                                                    Text(cart.item.item_name)
                                                        .font(Font.custom("BebasNeue", size: 30))
                                                        .fontWeight(.heavy)
                                                        .foregroundColor(.black)
                                                        .lineLimit(2)
                                                    
                                                    Spacer()
                                                }
                                                
                                                Spacer()
                                                
                                                
                                                HStack {
                                                    Text("£\(String(format: "%.2f",cart.item.item_cost * Float(cart.quantity)))")
                                                                .font(Font.custom("BebasNeue", size: 25))
                                                                .fontWeight(.heavy)
                                                                .foregroundColor(.black)
                                                    
                                                    Spacer()
                                                
                                                
                                                    HStack(spacing: 15){
                                                    
                                                    
                                                    
                                                    
                                                
                                                    
                                                    Button(action:
                                                            {
                                                                if cart.quantity >= 1 {
                                                                    HomeModel.cartItems[HomeModel.getIndex(item: cart.item, isCartIndex: true)].quantity -= 1
                                                                }
                                                            }) {
                                                                    Image(systemName: "minus")
                                                                        .foregroundColor(.black)
                                                                        .font(.system(size: 16, weight: .heavy))
                                                            }
                                                        
                                                    Text("\(cart.quantity)")
                                                        .font(Font.custom("BebasNeue", size: 20))
                                                        .foregroundColor(.black)
                                                        .fontWeight(.heavy)
                                                        .padding(.vertical, 10)
                                                        .padding(.horizontal, 10)
                                                        .background(Color.black.opacity(0.2))
                                                        .frame(width: 40)
                                                       
                                                    
                                                    Button(action:
                                                            {
                                                                if cart.quantity >= 0 {
                                                                    HomeModel.cartItems[HomeModel.getIndex(item: cart.item, isCartIndex: true)].quantity += 1
                                                                }
                                                            }) {
                                                                    Image(systemName: "plus")
                                                                        .foregroundColor(.black)
                                                                        .font(.system(size: 16, weight: .heavy))
                                                            }
                                                }
                                                    
                                                    
                                                }
                                                Spacer()
                                            }
                                        }
                                        .padding()
                                        .contentShape(RoundedRectangle(cornerRadius: 15))
                                        .contextMenu {
                                            //for Deleting an order:
                                            
                                            Button(action: {
                                                /*
                                                let index = homeData.getIndex(item: cart.item, isCartIndex: true)
                                                let itemIndex = homeData.getIndex(item: cart.item, isCartIndex: false)
                                                let filterdIndex = homeData.filterd.firstIndex { (item1) -> Bool in
                                                    return cart.item.id == item1.id
                                                } ?? 0
                                                homeData.items[itemIndex].isAdded = false
                                                homeData.filterd[filterdIndex].isAdded = false
                                                
                                                homeData.cartItems.remove(at: index)
                                                */
                                                
                                                
                                                HomeModel.cartItems.remove(at: HomeModel.getIndex(item: cart.item, isCartIndex: true))
                                                HomeModel.updateIfInCart(item: cart.item)

                                            }) {
                                                Text("Remove")
                                                
                                                
                                            }
                                            
                                        }
                                    }
                                }
                        }
                        
                        VStack {
                            HStack {
                                Text("Total")
                                    .font(Font.custom("BebasNeue", size: 30))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("$\(HomeModel.calculateTotalPrice())")
                                    .font(Font.custom("BebasNeue", size: 30))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                
                            }
                            .padding([.top, .horizontal])
                            
                            Button(action: {
                                print("checkout")
                                withAnimation(.easeIn){HomeModel.pushToCheckoutView()}
                                
                            }) {
                                Text("CHECK OUT")
                                    .font(Font.custom("BebasNeue", size: 30))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width - 30)
                                    .background(Color.black)
                                    .cornerRadius(15)
                            }
                        }
                        .padding()
                
                    }
                }
            }
        }
    }
}
