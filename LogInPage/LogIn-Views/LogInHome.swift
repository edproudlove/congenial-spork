//
//  Home.swift
//  Email Login Practice
//
//  Created by Ethan Proudlove on 27/04/2021.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LogInHome: View {
    @EnvironmentObject var LoginData : LogInHomeViewModel
    @EnvironmentObject var HomeModel : HomeViewModel
    @EnvironmentObject var orderData : Order
    
    /*
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
*/
 
    var body: some View {
        if LoginData.status {
            Home(loginData: LoginData)
         
            
        } else {
        ZStack {
        
            
                
            NavigationView {
                        VStack {
                                ZStack {
                                    NavigationLink(
                                        destination: SignUp(), isActive: $LoginData.show, label: {
                                            Text("")
                                        })
                                    .hidden()
                                    
                                    Login()
                                    // .ignoresSafeArea(.all)
                                }
                            
                                Spacer()
                            }
                        
                    }
                    .ignoresSafeArea(.all)
                    .onAppear{
                        NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                            
                            LoginData.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                            LoginData.collectData()
                    }
                }
            }
    
        }
    
    }
}

