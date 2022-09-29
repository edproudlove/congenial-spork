//
//  CheckOutViewController.swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 03/05/2021.
//

import Foundation
import Stripe

class BackendModel : ObservableObject {
    @Published var paymentStatus: STPPaymentHandlerActionStatus?
    @Published var paymentIntentParams: STPPaymentIntentParams?
    @Published var lastPaymentError: NSError?
    var paymentMethordType: String?
    var currency: String?
    var amount: String?
    
    func preparePaymentIntent(paymentMethordType: String, currency: String, amount: String) {
        self.paymentMethordType = paymentMethordType
        self.currency = currency
        
        let url = URL(string: BackendUrl + "create-payment-intent")!
        var request = URLRequest(url: url)
        let json: [String: Any] = [ //make sure that the server can handle parameters being passed to it
            "paymentMethodType":paymentMethordType,
            "amount":amount,
            "currency":currency
        ]
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type") 
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
            
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let clientSecret = json["clientSecret"] as? String
            else {
                let message = error?.localizedDescription ?? "Failed to decode response from server" // we get this response regardeless of weather the request went to the server ok, it means we did not get snything back i.e a pyamnet intent
                print(message)
                return
            }
            print("created the paymentIntent")
            // we update the payment intenet params with the object we just recived from the server
            // this needs to hapend on the main que so we use dispatch
            DispatchQueue.main.async {
                self.paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
            }
            
        })
        task.resume()
    }
    
    func onCompletion(status: STPPaymentHandlerActionStatus, pi: STPPaymentIntent?, error: NSError?) {
        self.paymentStatus = status
        self.lastPaymentError = error
        
        if status == .succeeded {
            self.paymentIntentParams = nil
            preparePaymentIntent(paymentMethordType: self.paymentMethordType!, currency: self.currency!, amount: self.amount ?? "0")
            
        }
    }
}
