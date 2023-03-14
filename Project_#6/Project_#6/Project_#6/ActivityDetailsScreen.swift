//
//  ActivityDetailsScreen.swift
//  Project_#6
//
//  Created by Jansen & Gelareh on 2023-03-02.
//

import SwiftUI

struct ActivityDetailsScreen: View {
    var selectedActivity: Activity
    
    @State var isSaved: Bool = false
    @State var purchaseConfirm: Bool = false
    @EnvironmentObject var preDefinedUsers: PreDefinedUsers
    
    var size = UIDevice.current.userInterfaceIdiom == .pad ? 1000 : 200
    
    let currentLogInUser = UserDefaults.standard.string(forKey: "username") ?? ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                //Activity Name
                Text("\(selectedActivity.name)")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 3)
                
                //Rating
                HStack(alignment: .lastTextBaseline)  {
                    let roundedRating = Int(selectedActivity.rating) ?? 0
                    
                    ForEach(0..<roundedRating) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    
                    if 5.0 - selectedActivity.rating > 0 {
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundColor(.yellow)
                    }
                    
                    Text("\(String(format: "%.1f", selectedActivity.rating))")
                }
                .padding(.bottom, 3)
                
                //Price
                Text("Price: $\(String(format: "%.2f", selectedActivity.pricePerPerson)) CAD /person")
                    .padding(.bottom, 3)
                
                //Image Section
                ScrollView(.horizontal){
                    LazyHStack(alignment: .center) {
                        ForEach(0..<selectedActivity.imageSet.count) {
                            Image("\(selectedActivity.imageSet[$0])")
                                .resizable()
                                .frame(maxWidth: 300,maxHeight: 250)
                        }
                    }
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
                
                //Hoster
                Button(action: {
                    let tel = "tel://"
                    let formattedString = tel + selectedActivity.phoneNumber
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                }) {
                    Text("Hosted by \(selectedActivity.hosting), Contact: \(selectedActivity.phoneNumber)")
                        .underline()
                        .font(.body)
                        .padding(.bottom, 3)
                }
                
                //Description Section
                Text("What you'll do").bold()
                    .padding(.bottom, 3)
                
                Text("\(selectedActivity.description)")
                    .padding(.bottom, 5)
                
                HStack(alignment: .center){
                    //ShareLink
                    if #available(iOS 16.0, *){
                        ShareLink("share",item: "\(selectedActivity.name) Price: $\(String(format: "%.2f", selectedActivity.pricePerPerson)) /person")
                    }
                    else {
                        Text("no share")
                    }
                        
                    //Add to favorite button
                    Button(action: {self.addToFavorite()}){
                        Image(systemName: self.isSaved ? "heart.fill" : "heart").resizable().frame(maxWidth: 25, maxHeight: 80)
                        } //Button
                    }//HStack
                .padding(.vertical)
                
                
                //Purchase a ticket
                Button(action: {
                    self.purchaseConfirm = true
                }){
                    Text("Purchase a ticket")
                }.buttonStyle(.borderedProminent)
                    .alert(isPresented: self.$purchaseConfirm){
                        Alert(title: Text("Confirmation"), message: Text("Purchase \(self.selectedActivity.name) ticket"),
                              primaryButton: .default(Text("Purchase")){self.purchaseTicket()},
                              secondaryButton: .destructive(Text("Cancel")){})
                    }
            }//VStack
        }
        //check if the activity already added into favorite list
        //when the activity detail screen start appear
        .onAppear {
//            let username = UserDefaults.standard.string(forKey: "username") ?? ""
            var userFavoriteList = UserDefaults.standard.array(forKey: currentLogInUser) as? [String] ?? []
            
            if userFavoriteList.contains(selectedActivity.id){
                self.isSaved = true
            }
        }
        .padding(.horizontal)
    }// body
    
    //Purchase a ticket
    func purchaseTicket() {
        var userPurchaseList = UserDefaults.standard.array(forKey: "\(currentLogInUser)_purchase") as? [String] ?? []
        
        if var currentUser = preDefinedUsers.preDefinedUsersDict[currentLogInUser] {
            currentUser.joinedActivities = userPurchaseList
            
            for t in currentUser.joinedActivities {
                print(t)
            }
        
            currentUser.joinedActivities.append("\(self.selectedActivity.name), Price: $\(String(format:"%.2f",self.selectedActivity.pricePerPerson))")
            
            UserDefaults.standard.set(currentUser.joinedActivities, forKey: "\(currentLogInUser)_purchase")
        }
    }
    
    //Add to favorite button
    func addToFavorite() {
        var userFavoriteList = UserDefaults.standard.array(forKey: currentLogInUser) as? [String] ?? []
        
        //Check if the activity already in the favorite list
        if !userFavoriteList.contains(selectedActivity.id) {
            self.isSaved.toggle()
            
            //Add the activity id into favorite list
            userFavoriteList.append(selectedActivity.id)
            
            if var currentUserFavorites = preDefinedUsers.preDefinedUsersDict[currentLogInUser] {
                //Add the activity into the favorite list
                currentUserFavorites.favoritesList.append(selectedActivity)
                
                preDefinedUsers.preDefinedUsersDict[currentLogInUser] = currentUserFavorites
                print("Saved")
            }
            
            //Save the user favorite activivty id list in UserDefaults
            UserDefaults.standard.set(userFavoriteList, forKey: currentLogInUser)
        }
        //Rmove the activity if user press the button again
        else {
            self.isSaved.toggle()
            
            let removedIndex = userFavoriteList.firstIndex(of: selectedActivity.id) ?? userFavoriteList.startIndex
            
            userFavoriteList.remove(at: removedIndex)
            
            if var currentUserFavorites = preDefinedUsers.preDefinedUsersDict[currentLogInUser] {
                
                currentUserFavorites.favoritesList.remove(at: removedIndex)
                preDefinedUsers.preDefinedUsersDict[currentLogInUser] = currentUserFavorites
            }
            
            UserDefaults.standard.set(userFavoriteList, forKey: currentLogInUser)
        }
    }
}

struct ActivityDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailsScreen(selectedActivity: Activity(name: "Sample", description: "Sample", rating: 5, hosting: "Sample", phoneNumber: "416-988-6753", pricePerPerson: 100, imageSet: []))
    }
}
