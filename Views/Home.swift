//
//  Home.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 24/04/2021.
//

import SwiftUI

struct Home: View {
    @ObservedObject var loginData: LogInHomeViewModel
    @StateObject var HomeModel = HomeViewModel()
    
   // @State var selectedTab = scroll_tabs[0]
    @Namespace var animation
    //@State var selectedBag: Item! = nil
    
    var body: some View {
       
        
       
            
        ZStack {
            VStack(spacing: 0) {
                
                ZStack {
                    VStack {
                        HStack(spacing: 15) {
                            HStack {
                                
                                if HomeModel.showCartView || HomeModel.showDetailedView || HomeModel.showCheckOutView {
                                    Button(action: {
                                        //withAnimation(.easeIn){HomeModel.showCartView.toggle()}
                                        withAnimation(.easeIn){HomeModel.pushToProducts()}
                                    }, label: {
                                        Image(systemName: "chevron.left")
                                            .font(.title)
                                            .foregroundColor(.black) })
                                }
                                
                                Button(action: {
                                    withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                                    
                                }, label: {
                                    Image(systemName: "line.horizontal.3.decrease")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    
                                })
                                
                                
                                
                            }
                            .frame(width: 50)
                            
                            
                            
                            Spacer(minLength: 0)
                            
                            
                            Text("Castle Rock")
                                .font(Font.custom("BebasNeue", size: 33))
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                         
                            
                            
                            Spacer(minLength: 0)
                            
                            HStack {
                            
                                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
                                    
                                    
                                    Button(action:{
                                        //withAnimation(.easeIn){ HomeModel.showCartView.toggle()}
                                        withAnimation(.easeIn){HomeModel.pushToCartView()}
                                        
                                            },
                                    label: {
                                        Image(systemName: "cart")
                                            .font(.title)
                                            .foregroundColor(.black)
                                    })
                                    
                                    if !HomeModel.cartItems.isEmpty {
                                    
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 15, height: 15)
                                            .offset(x: 5, y: -8)
                                    }
                                    
                                })
                            }
                            .frame(width: 50)
                            
                        }
                        
                        
                        
                        //Text("Simple Swift Guide").font(Font.custom("Chalkboard", size: 33))

                        
                        
                        
                    }
                    
 
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?
                            .safeAreaInsets.top)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                .zIndex(1)
                
                
                
                if HomeModel.showCartView {
                    CartView(HomeModel: HomeModel)
                    
                } else if HomeModel.selectedBag != nil && HomeModel.showDetailedView {
                    EditedDetailView(HomeModel: HomeModel, item: $HomeModel.selectedBag, animation: animation)
                
                } else if HomeModel.showCheckOutView {
                    CheckOutView(loginData: loginData, HomeModel: HomeModel)
                    
                } else {
                    Products(loginData: loginData, HomeModel: HomeModel, animation: _animation, selectedBag: HomeModel.selectedBag)
                }
                    
                
                    
                    
                
                
                
                
                Spacer(minLength: 0)
                
                
                
            }
            .background(Color.black.opacity(0.05)).ignoresSafeArea(.all, edges: .all)
            .onAppear {
                //calling the authorisation funtion:
                HomeModel.fetchData()
                loginData.checkUserStaus()
                
            }
            .onChange(of: HomeModel.search, perform: { value in
                
                //to avoid having too many search requests:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    
                    if value == HomeModel.search && HomeModel.search != ""{
                        // search data:
                        
                        HomeModel.filterData()
                    }
                    
                })
                
                if HomeModel.search == "" {
                    withAnimation(.linear) {HomeModel.filterd = HomeModel.items}
                }
            })
            .onChange(of: HomeModel.selectedTab, perform: { value in
                HomeModel.filterDataSelectedTab(selctedTab: HomeModel.selectedTab)
                    
                //})
            
            })
            
            HStack {
                
                Menu(loginData: loginData, HomeModel: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.2)
                
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                            .onTapGesture {
                                //closing when tappes off menu:
                                withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                            })
        
        .ignoresSafeArea(.all, edges: .all)
        }
        
        
    }
    
}
