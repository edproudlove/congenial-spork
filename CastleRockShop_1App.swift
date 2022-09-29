//
//  CastleRockShop_1App.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 24/04/2021.
//
//  Create the athstetic we want and integrate in the firabse firestore stuff


import SwiftUI
import Firebase
import Stripe


let BackendUrl = "http://127.0.0.1:5000/"


@main
struct CastleRockShop_1App: App {
    @ObservedObject var LoginData = LogInHomeViewModel()
    @ObservedObject var HomeModel = HomeViewModel()
    @ObservedObject var orderData = Order()

    
    init() {
        
        FirebaseApp.configure()
        let url = URL(string: BackendUrl + "config")! // first we make a url consiting of the backend url + the config route to get the private key from
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
            
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let publishableKey = json["publishableKey"] as? String
            else {
                print("Failed To Recive Publishable Key From Server")
                return
            }
            print("Fetched the publishable key \(publishableKey)")
            StripeAPI.defaultPublishableKey = publishableKey
            
        })
        task.resume()
    }
    var body: some Scene {
        
        
        WindowGroup {
        LogInHome()
            .environmentObject(LoginData)
            .environmentObject(HomeModel)
            .environmentObject(orderData)
        }
    }
}





