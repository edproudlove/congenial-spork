//
//  CheckOutView.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 02/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Stripe

struct PaymentMethod: Hashable, Codable {
    var id: Int
    var title: String
    var type: String
}

struct CheckOutView: View {
    @ObservedObject var loginData: LogInHomeViewModel
    @StateObject var HomeModel : HomeViewModel
    @EnvironmentObject var order : Order
    
    
    @Namespace var animation
    
    @ObservedObject var model = BackendModel()
    @State var loading = false
    @State var paymentMethrodParams: STPPaymentMethodParams?
    
    private let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    @State private var currentImageIndex = 0
    
    @State private var reciptEmail = ""
    @State private var checkoutTab = checkOutViewtabs[0]
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack {
                
                    
                    HStack(spacing: 20) {
                        
                        ForEach(checkOutViewtabs, id: \.self){tab in
                        
                            TabButton_2(title: tab, selectedTab: $checkoutTab, animation: animation)
                            
                            
                        }
                    }
                    //.padding(.horizontal)
                    .padding()
                
                if checkoutTab == checkOutViewtabs[1] {
                    ScrollView {
                        VStack {
                            TabView(selection: $currentImageIndex) {
                                ForEach(0..<HomeModel.cartItems.count) {index in
                                    WebImage(url: URL(string: HomeModel.cartItems[index].item.item_image))
                                        .resizable()
                                        .cornerRadius(8)
                                        .shadow(radius: 8)
                                        .scaledToFit()
                                        .padding(.vertical)
                                        .tag(index)
                                        
                                }
                                
                            }.tabViewStyle(PageTabViewStyle())
                            .frame(width: proxy.size.width, height: proxy.size.height / 3)
                            
                            .onReceive(timer, perform: { _ in
                                withAnimation() {
                                    currentImageIndex = currentImageIndex < HomeModel.cartItems.count ? currentImageIndex + 1 : 0
                                }
                            }) //workes
                            //(String(format: "%.2f", (Double(HomeModel.calculateTotalPrice())! + (order.deliveryPrices[order.currentDeliveryOption])!)))
                            
                            
                            Text("£\(String(format: "%.2f", (Double(HomeModel.calculateTotalPrice())! + (order.deliveryPrices[order.currentDeliveryOption])!)))")
                                .font(Font.custom("BebasNeue", size: 33))
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            HStack{
                                Capsule()
                                    .fill(Color.gray)
                                    .frame(width: UIScreen.main.bounds.width * 0.25, height: 2)
                                    //.padding(.top, 8)
                                
                                Text("Pay With Card")
                                    .foregroundColor(.gray)
                                
                                Capsule()
                                    .fill(Color.gray)
                                    .frame(width: UIScreen.main.bounds.width * 0.25, height: 2)
                                    //.padding(.top, 8)
                            }
                            .padding(.bottom)

                            
                            STPPaymentCardTextField.Representable(paymentMethodParams: $paymentMethrodParams)
                                .padding(.horizontal)
                                //.padding(.bottom, 30)
                            
                            
                            Spacer()
                                
                            
                            
                            if let paymentIntent = model.paymentIntentParams {
                                
                                Spacer()
                                
                                Button(action: {
                                    paymentIntent.paymentMethodParams = paymentMethrodParams
                                    loading = true
                                }, label: {
                                    Text("Confirm And Pay")
                                        .fontWeight(.bold)
                                })
                                .font(Font.custom("BebasNeue", size: 24))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 44)
                                .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 3))
                                .cornerRadius(4)
                                .paymentConfirmationSheet(isConfirmingPayment: $loading, paymentIntentParams: paymentIntent, onCompletion: model.onCompletion)
                                .disabled(loading)
                            
                            
                            } else {
                                Spacer()
                                
                                Text("Loading...")
                                    .font(Font.custom("BebasNeue", size: 24))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 30, height: 44)
                                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.black))
                                    .cornerRadius(4)
                                    //.padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets
                                    //            .bottom == 0 ? 30 : 0)
                                    //.offset(y: proxy.size.height / 3)
                            }
                           
                            
                            
                        }
                        .onAppear() {
                            model.preparePaymentIntent(paymentMethordType: "card", currency: "gbp", amount: String(HomeModel.calculateTotalPrice()))
                        }
                        
                        if let paymentStatus = model.paymentStatus {
                            
                            HStack {
                                switch paymentStatus {
                                case .succeeded:
                                    Text("payment completed")
                                case .failed:
                                    Text("payment failed")
                                case .canceled:
                                    Text("payment cancelled")
                                @unknown default:
                                    Text("Unknown Error")
                                }
                                
                            }
                        }
                    }
                } else {
                    
                    DeliveryAdressView()
                }
            }
        }
    }
}
