//
//  SignUpView.swift
//  Email Login Practice
//
//  Created by Ethan Proudlove on 27/04/2021.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUp: View {
    @EnvironmentObject var LoginData: LogInHomeViewModel
    

    
    var body: some View {
        ZStack {
            
                ZStack(alignment: .topLeading) {
                    
                    GeometryReader {_ in
                        ScrollView(.vertical, showsIndicators: false)  {
                            VStack(spacing: 10) {
                                Image("CastleRockLogo2")
                                    .padding(.top, 30)
                                
                                Text("Sign Up")
                                    .fontWeight(.heavy)
                                    .font(Font.custom("BebasNeue", size: 34))
                                    .foregroundColor(.black)
                                
                                TextField("First Name", text: $LoginData.firstName)
                                    .autocapitalization(.none)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 4).stroke(LoginData.firstName != "" ? Color.white : Color.black, lineWidth: 2))
                                    
                                
                                TextField("Last Name", text: $LoginData.lastName)
                                    .autocapitalization(.none)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 4).stroke(LoginData.lastName != "" ? Color.white : Color.black, lineWidth: 2))
                                
                                TextField("Email", text: $LoginData.email)
                                    .autocapitalization(.none)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 4).stroke(LoginData.email != "" ? Color.white : Color.black, lineWidth: 2))
                                
                                HStack(spacing: 15) {
                                    VStack {
                                        if LoginData.visable{
                                            TextField("Password", text: $LoginData.pass)
                                                .autocapitalization(.none)
                                                
                                            
                                        }else {
                                            
                                            SecureField("Password", text: $LoginData.pass)
                                                .autocapitalization(.none)
                                                
                                        }
                                        
                                    }
                                    Button(action: {
                                        LoginData.visable.toggle()
                                    }, label: {
                                        Image(systemName: LoginData.visable ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(LoginData.color)
                                    })
                                }
                                    .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(LoginData.pass != "" ? Color.white : Color.black, lineWidth: 2))
                                
                                HStack(spacing: 15) {
                                    VStack {
                                        if LoginData.reVisable{
                                            TextField("Re Enter Password", text: $LoginData.repass)
                                                .autocapitalization(.none)
                                            
                                        }else {
                                            
                                            SecureField("Re Enter Password", text: $LoginData.repass)
                                                .autocapitalization(.none)
                                                
                                        }
                                        
                                    }
                                    Button(action: {
                                        LoginData.reVisable.toggle()
                                    }, label: {
                                        Image(systemName: LoginData.reVisable ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(LoginData.color)
                                    })
                                }
                                    .padding()
                                .background(RoundedRectangle(cornerRadius: 4).stroke(LoginData.repass != "" ? Color.white : Color.black, lineWidth: 2))
                                
                                Spacer()
                                
                
                                
                                Button(action: {
                                    LoginData.register()
                                }, label: {
                                    Text("Sign Up")
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
                    }//.padding(.top, 150)

                    
                    Button(action: {
                        LoginData.show.toggle()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.gray)
                    })
                    .padding()
                    
                
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .navigationBarTitle("")
            
            if LoginData.alert {
                
                ErrorView(alert: $LoginData.alert, error: $LoginData.error)
            }
        
        }
        
        
    }
    
}


//@Binding var show: Bool

/*
@State var color = Color.black.opacity(0.7)
@State var firstName = ""
@State var lastName = ""
@State var email = ""
@State var pass = ""
@State var repass = ""
@State var visable = false
@State var reVisable = false
@Binding var show: Bool
@State var alert = false
@State var error = ""
*/


//.frame(maxHeight: .infinity)
