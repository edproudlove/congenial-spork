//
//  DeliveryAdressView.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 06/05/2021.
//

import SwiftUI





struct DeliveryAdressView: View {
    
    init() {
            UITableView.appearance().contentInset.top = -40//.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        }
    
    @EnvironmentObject var order : Order
    
    
    var body: some View {
        VStack {
            
            HStack{
                Capsule()
                    .fill(Color.gray)
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: 2)
                    //.padding(.top, 8)
                
                Text("Fill In Your Details")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                
                Capsule()
                    .fill(Color.gray)
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: 2)
                    //.padding(.top, 8)
            }
            .padding(.bottom)
            
            
                
            VStack {
                
                Form() {
                    Section {
                        TextField("Full Name", text: $order.name)
                        TextField("Email", text: $order.orderEmail)
                        TextField("Address Line 1", text: $order.streetAdress)
                        TextField("Address Line 2 (optional)", text: $order.streetAdressLine_2)
                        TextField("City", text: $order.city)
                        TextField("Postcode", text: $order.postcode)
                        
                    }
                    
                    Section {
                        
                        Picker("Choose Delivery Options:", selection: $order.currentDeliveryOption) {
                            ForEach(order.DeliveryOptions, id: \.self) {
                                            Text($0)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())

                        Text(order.currentDeliveryOption)
                        
                       
                    }
                    
                    
                    
                }
                
                
                
                
                Spacer()
            }
            
        }.contextMenu {
            //for Deleting an order:
            
            Button(action: {
                

            }) {
                Text("Remove")
            }
        }
    }
}


//.pickerStyle(MenuPickerStyle())
/* Picker(selection: $order.DeliveryOptions, label: Text("Choose Delivery Options:")) {
     ForEach(0 ..< order.DeliveryOptions.count) {
         Text(order.DeliveryOptions[$0]).tag($0)
     }
     
 } */
