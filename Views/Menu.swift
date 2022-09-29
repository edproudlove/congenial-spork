//
//  Menu.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 26/04/2021.
//

import SwiftUI
import FirebaseAuth

struct Menu: View {
    @ObservedObject var loginData: LogInHomeViewModel
    @ObservedObject var HomeModel: HomeViewModel
    
    var body: some View {
        
        VStack() {
            
            
            
            //NavigationLink(destination: CartView(homeData: homeData)) {
            
            HStack {
            VStack(alignment: .leading) {
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, 20)
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width: 70, height: 70)
                    
                
                HStack(spacing: 0) {
                    Text("Hey,")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.leading)
                    
                    Text("\(loginData.name)")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading, 3)
                    }
                
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top, 50)
            
            
            Image("CastleRockLogo2")
            
            
            
            HStack {
                VStack(spacing: 15) {
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.pushToProducts()}
                    }, label: {
                        HStack(spacing: 15) {
                            
                            Image(systemName: "arrowshape.turn.up.right")
                                .padding(.leading)
                                .font(.title)
                                .foregroundColor(.black)
                            
                            
                            Text("- Products")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        }
                    })
                    // this is new :  USED To JUST Be A Button
                    
                        
                
                    Button(action: {
                        
                        withAnimation(.easeIn){HomeModel.pushToCartView()}
                        
                        }, label: {
                            HStack(spacing: 15) {
                                
                                Image(systemName: "cart")
                                    .padding(.leading)
                                    .font(.title)
                                    .foregroundColor(.black)
                                
                                
                                Text("- Cart")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Spacer(minLength: 0)
                            }
                        })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack(spacing: 15) {
                            
                            Image(systemName: "heart")
                                .padding(.leading)
                                .font(.title)
                                .foregroundColor(.black)
                            
                            
                            Text("- Favourites")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        }
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack(spacing: 15) {
                            
                            Image(systemName: "creditcard")
                                .padding(.leading)
                                .font(.title)
                                .foregroundColor(.black)
                            
                            
                            Text("- Your Orders")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        }
                    })
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 200, height: 4)
                        .padding(.top, 8)
                    
                    Button(action: {
                        
                        try! Auth.auth().signOut()
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        
                    }
                           , label: {
                        HStack(spacing: 15) {
                            
                            Image(systemName: "person.crop.rectangle")
                                .padding(.leading)
                                .font(.title)
                                .foregroundColor(.black)
                            
                            
                            Text("Sign Out")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        }
                    })
                    .padding(.top)
                }
                
                Spacer(minLength: 0)
            }
                    
                
            
            Spacer()
            
            HStack() {
                
                Spacer()
                
                Text("version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            .padding(10)
            .padding(.bottom, 20)
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.2)
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            loginData.collectData()
        }
    }
}
