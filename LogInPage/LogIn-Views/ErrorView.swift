//
//  ErrorView.swift
//  Email Login Practice
//
//  Created by Ethan Proudlove on 27/04/2021.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ErrorView: View {
    //@ObservedObject var LoginData = HomeViewModel()
  
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error : String
 
    
    var body: some View {
        GeometryReader {_ in
            VStack(alignment: .center) {
                HStack {
                    Text(self.error == "ERROR" ? "message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                    
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "ERROR" ? "Reset Email Has Been Sent Succsefully" : self.error)
                    .foregroundColor(color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                Button(action: {
                    self.alert.toggle()
                }, label: {
                    Text(self.error == "ERROR" ? "Ok" : "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                })
                .background(Color.gray)
                .cornerRadius(10)
                .padding(.top, 25)
                
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 70)
            .background(Color.white)
            .cornerRadius(15)
            .offset(x: 30, y: 300)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
        
        
    }
    
}
