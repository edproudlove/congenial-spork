//
//  EditedDetailView.swift
//  Touchdown
//
//  Created by Ethan Proudlove on 13/04/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditedDetailView: View {
    
    @StateObject var HomeModel : HomeViewModel
    @Binding var item: Item!
    

    @State var addedToCart: Bool = false
    var animation: Namespace.ID
    @State var count = Int(1)
    
    var body: some View {
        ZStack {
            
        
            ZStack(alignment: .topLeading) {
                GeometryReader{ _ in
                    
                    VStack {
                       
                        
                        ScrollView(.vertical, showsIndicators: false) {
                    
                            
                            
                            
                            
                            HStack(spacing: 10) {
                                
                                    
                                    Text(item.item_name + ":")
                                        .font(Font.custom("BebasNeue", size: 33))
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                
                            
                                    
                                Text("£\(String(format: "%.2f", item.item_cost))")
                                        .font(Font.custom("BebasNeue", size: 33))
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                
                                    Spacer()
                                    
                                
                            }
                            .padding(.leading, 20)
                            //.padding()
                            .padding(.top, 15)
                            .zIndex(1)
                                
                                
                            WebImage(url: URL(string: item.item_image))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250)
                                // hero animation:
                                //.matchedGeometryEffect(id: itemData.item_image, in: animation)
                                .cornerRadius(15)
                                .shadow(radius: 4)
                                
                                
                                
                            
                            
                            VStack {
                                
                                
                                Text("This is a lovley beer it is a high percent but tastes very good, I enjoy very mucuh. This is a lovley beer it is a high percent but tastes very good, I enjoy very mucuh. This is a lovley beer it is a high percent but tastes very good, I enjoy very mucuh.")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                                    .padding()
                                
                                HStack(spacing: 20) {
                                    
                                    Button(action: {
                                            if count > 0 {count -= 1}}) {
                                        Image(systemName: "minus")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                            .frame(width: 35, height: 35)
                                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                        
                                    }
                                    
                                    Text("\(count)")
                                        .font(.title2)
                                    
                                    
                                    Button(action: {count += 1}) {
                                        Image(systemName: "plus")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                            .frame(width: 35, height: 35)
                                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                        
                                        Image(systemName: "suit.heart.fill")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color(.red))
                                            .clipShape(Circle())
                                        
                                    }
                                }
                                .padding(.horizontal)
                                
                                
                                Button(action: {
                                    self.addedToCart.toggle()
                                    HomeModel.addToCart(item: item, quantity: count)
                                    //itemData.isAdded.toggle()
                                    //Should be this: HomeModel.addToCart(item: itemData, quantity: count)
                                    
                                    item.isAdded.toggle()

                                }) {
                                    
                                    
                                    Text(item.isAdded ? "REMOVE" : "ADD TO CART")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 30)
                                        .background(Color(.black))
                                        .clipShape(Capsule())
                                    
                                    
                                        
                                }
                                .padding([.horizontal, .bottom])
                                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets
                                            .bottom == 0 ? 30 : 0)
                                
                                
                            }

                            
                        }
                        //.padding()
                        .ignoresSafeArea(edges: .all)
                       
                    }
                
                }
                
            }
                
        }
        .onChange(of: HomeModel.showCartView, perform: { _ in
                    self.item.isAdded = self.HomeModel.updateIfInCart(item: item!)
            
        })
        .onAppear {
            //self.addedToCart = self.HomeModel.updateIfInCart(item: item!)
            self.item.isAdded = self.HomeModel.updateIfInCart(item: item!)
            //i think the problem is that this onAppera will not be called becasue it has tecnically apeard already
        }
        
        
        
    }
}




