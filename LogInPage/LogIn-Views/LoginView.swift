//
//  LoginView.swift
//  Email Login Practice
//
//  Created by Ethan Proudlove on 27/04/2021.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Login: View {
    @EnvironmentObject var loginData: LogInHomeViewModel
    
    
    var body: some View {
        
        ZStack {
            
  
            ZStack(alignment: .topTrailing) {
                GeometryReader {_ in
                    
                
            
                    VStack {
                        
                        Spacer()
                        
                        Image("CastleRockLogo2")
                            .frame(width: 150)
                            .aspectRatio(contentMode: .fit)
                        
                        Spacer()
                        
                        Text("Sign In")
                            .fontWeight(.heavy)
                            .font(Font.custom("BebasNeue", size: 34))
                            .foregroundColor(.black)
                            .padding(.top, 35)
                        
                        TextField("Email", text: $loginData.email) // this may need to be binding
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(loginData.email != "" ? Color.white : Color.black, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15) {
                            VStack {
                                if loginData.visable{
                                    TextField("Password", text: $loginData.pass)
                                        .autocapitalization(.none)
                                        
                                    
                                }else {
                                    
                                    SecureField("Password", text: $loginData.pass)
                                        .autocapitalization(.none)
                                        
                                }
                                
                            }
                            Button(action: {
                                loginData.visable.toggle()
                            }, label: {
                                Image(systemName: loginData.visable ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(loginData.color)
                            })
                        }
                            .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(loginData.pass != "" ? Color.white : Color.black, lineWidth: 2))
                            .padding(.top, 15)
                        
                        HStack() {
                            Spacer()
                            
                            Button(action: {
                                loginData.reset()
                            }, label: {
                                Text("Forgot Password")
                                    .font(Font.custom("BebasNeue", size: 24))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                            })
                        }
                        .padding(.top, 20)
                        
                        Button(action: {
                            
                            loginData.verify()
                            
                        }, label: {
                            Text("Log in")
                                .font(Font.custom("BebasNeue", size: 34))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        })
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.top, 25)
                        
                        
                    }
                    .padding(.horizontal, 25)
                    
                    
                }

                Button(action: {
                    loginData.show.toggle()
                }, label: {
                    Text("Register")
                        .font(Font.custom("BebasNeue", size: 20))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(width: 70, height: 40)
                    
                })
                .background(Color.black)
                .cornerRadius(10)
                .padding()
            
            }
        
            if loginData.alert {
                ErrorView(alert: $loginData.alert, error: $loginData.error)
                    //.ignoresSafeArea(.all)
            }
            
            
            
        }
        //.background(Color.black.opacity(0.7))
        //.ignoresSafeArea(.all)
        //.ignoresSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationBarTitle("")
        
        

    }
}
