//
//  HomeViewModel(OrderApp).swift
//  CastleRockShop_1
//
//  Created by Ethan Proudlove on 24/04/2021.
//

import SwiftUI
import Firebase

//this is the clsss that will help get the data from firebase:
//I want to be able to add In items to each diffrent colection of products and for them to appear on the app:

var scroll_tabs = ["All Products", "Beers", "Gift Ideas", "Prints", "Kegs & Bottles", "Clothing"]

var checkOutViewtabs = ["Delivery Adress", "Confirm And Pay"]



class HomeViewModel: NSObject, ObservableObject {

    @Published var search = ""
    
    //Menu:
    @Published var showMenu = false
    @Published var selectedTab = scroll_tabs[0]
    
    //item data
    @Published var items: [Item] = []
    @Published var filterd: [Item] = []
    
    //cartItems
    @Published var cartItems: [Cart] = []
    @Published var orderd = false
    
    //showing the views
    @Published var showCartView = false
    @Published var showDetailedView = false
    @Published var showCheckOutView = false
    @Published var showProducts = true
   
    //@Published var isInCart = false
    //@Published var isInCart_2 = false
    
    @Published var editedViewCount = Int(1)
    @Published var selectedBag: Item! = nil
  

    
    //getting the data:
    
    
    func fetchData() {
        
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments { (snap, err) in
            //if err != nil {
            //    print(err?.localizedDescription)
            //}
            
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({ (doc) -> Item? in
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! Float
              //  let ratings = doc.get("item_ratings") as! String
                let image = doc.get("item_image") as! String
                let selectedTab = doc.get("item_selectedTab") as! String
                //this does not work yet..
                
              //  let details = doc.get("item_details") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_image: image, item_selectedTab: selectedTab)
            } )
            
            self.filterd = self.items
            
        }
    }
    
    
    
    //search or filter:
    
    func filterData() {
        withAnimation(.linear) {
            self.filterd = self.items.filter{
                return $0.item_name.lowercased().contains(self.search.lowercased())
            }
        }
    }
    
    func filterDataSelectedTab(selctedTab: String) {
        
        withAnimation(.linear) {
            self.filterd = self.items.filter{
                return $0.item_selectedTab.lowercased().contains(selctedTab.lowercased())
            }
        }
    }

    //add to cart function
    
    
    func getIndex(item: Item, isCartIndex: Bool) -> Int {
        let index = self.items.firstIndex{ (item1) -> Bool in
            
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex{ (item1) -> Bool in
            
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    func calculateTotalPrice() -> String {
        
        var price : Float = 0
        
        cartItems.forEach { (item) in
            price += Float(item.quantity) * Float(truncating: NSNumber(value: item.item.item_cost))
        }
        return String(format: "%.2f", price) //"Total: $\(String(format: "%.2f", total))")
    }
    
    //writing order data into the firestore:
    
    func updateOrder() {
        
        let db = Firestore.firestore()
        
        if orderd {
            orderd = false
            db.collection("Users").document(Auth.auth().currentUser!.uid).delete { (err) in
                
                if err != nil {
                    self.orderd = true
                   
                }
                
            }
            return
        }
        
        var details : [[String: Any]] = []
        
        cartItems.forEach {(cart) in
            
            details.append([
                "item_name" : cart.item.item_name,
                "item_quantity" : cart.quantity,
                "item_cost" : cart.item.item_cost,
            
            ])
        }
        orderd = true
        
        
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            //create dict of order details:
            
                "orderd_food": details,
                "total_cost": calculateTotalPrice(),
               // "location": GeoPoint(latitude:userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            
            
        ]) { (err) in
            
            if err != nil {
                self.orderd = false
               return
            }
            
            print("succsess")
        }
        
    }
    
    
    func addToCart(item: Item, quantity: Int) {
    
        
        for cartItem in cartItems {
            
            if String(item.id) == String(cartItem.item.id) {
                
                self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
                //self.isInCart = false
                //print(self.isInCart)
                return
                
            } else  {
                
                self.cartItems.append(Cart(item: item, quantity: quantity))
                //elf.isInCart = true
                //print(self.isInCart)
                return
            }
        
        }
        //self.isInCart = true
        //print(self.isInCart)
        self.cartItems.append(Cart(item: item, quantity: quantity))
         
    }
    
    
    
    
    func updateIfInCart(item: Item) -> Bool {
        
        @State var isInCart = false
        
        for cartItem in cartItems {
            
            if String(item.id) == String(cartItem.item.id) {
            
                isInCart = true
                //print(self.isInCart)
                //return isInCart
                
            } else  {
                
                isInCart = false
                //print(self.isInCart)
                //return isInCart
            }
        
        }
        
        if cartItems.isEmpty {
            isInCart = false
            //return isInCart
        }
        
        return isInCart
    }
    

  
    func pushToCartView() {
        showCartView = true
        showDetailedView = false
        showCheckOutView = false
        showProducts = false
        
    }
    
    func pushToDetailView() {
        showCartView =  false
        showDetailedView = true
        showCheckOutView = false
        showProducts = false
        
    }
    
    func pushToCheckoutView() {
        showCartView =  false
        showDetailedView = false
        showCheckOutView = true
        showProducts = false
        
    }
    
    func pushToProducts() {
        showCartView =  false
        showDetailedView = false
        showCheckOutView = false
        showProducts = true
        
    }
}



class LogInHomeViewModel: NSObject,  ObservableObject {
    
    @Published var name = ""
    @Published var items: [UserData] = []
    
    @Published var color = Color.black.opacity(0.7)
    @Published var email = ""
    @Published var pass = ""
    @Published var repass = ""
    @Published var visable = false
    
    @Published var show = false
    
    @Published var alert = false
    @Published var error = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var reVisable = false
    
    @Published var user: User? = nil // it needs to be optional to have nil compatable
    
    @Published var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    
    //functions
    
    func checkUserStaus(){
        if Auth.auth().currentUser != nil {
            
            let user = Auth.auth().currentUser
            
            print(user?.email! ?? "Nil")
          // User is signed in.
          // ...
        } else {
          // No user is signed in.
          // ...
        }
    }
    
    func collectData() {
        
        let db = Firestore.firestore()
        
        db.collection("Users").getDocuments { (snap, err) in
            
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({ (doc) -> UserData? in
                
                let id = doc.documentID
                let first_name = doc.get("first_name") as! String
                let last_name = doc.get("last_name") as! String
                let email = doc.get("user_email") as! String
                
                
                return UserData(id: id, first_name: first_name, email: email, last_name: last_name)
            })
            
            if Auth.auth().currentUser != nil {
                
                self.user = Auth.auth().currentUser!
                
                print(self.user?.email!)
              
            } else {
              print("No User Signed In")
            }
            
            for item in self.items {
                if item.email.lowercased() == self.user?.email! {
                    self.name = item.first_name + " " + item.last_name
                }
            }
            
            
        }
        
        
    }
    
    func verify() {
        
        if self.email != "" && self.pass != "" {
            
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                print("sucsess")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
            }
            
        } else {
            self.error = "Please Fill in All The Text Feilds"
            self.alert.toggle()
        }
    }
    
    func reset() {
        
        if self.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "ERROR"
                self.alert.toggle()
                
            }
        }
        else {
            self.error = "Email ID is empty"
            self.alert.toggle()
        }
    }
    
    func storeData() {
        let db = Firestore.firestore()
        
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData([
            //this works
            
            "user_email" : self.email,
            "password" : self.pass,
            "first_name" : self.firstName,
            "last_name" : self.lastName
            
        ]) { (err) in
            
            if err != nil {
                print(err!.localizedDescription)
               return
            }
            
            print("succsess")
        }
        
    }
    
    func register() {
        if self.email != "" {
            if self.pass ==  self.repass {
                
                Auth.auth().createUser(withEmail: self.email, password: self.pass) {(res, err) in
                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    self.storeData()
                    
                    print("succsesfully registerd", self.email, self.pass)
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
                
            } else {
                
                self.error = "Passwords Do Not Match"
                self.alert.toggle()
            }
        } else {
            self.error = "Please fill all content properly"
            self.alert.toggle()
            
        }
        
    }

}
