//
//  FavoriteScreen.swift
//  Project_#6
//
//  Created by Jansen & Gelareh on 2023-03-02.
//

import SwiftUI

struct FavoriteScreen: View {
    @EnvironmentObject var preDefinedUsers: PreDefinedUsers
    
    let usernameLogedIn = UserDefaults.standard.string(forKey: "username") ?? ""
    
    @State var confirmDelete: Bool = false
    
    var body: some View {
        VStack {
            Text(usernameLogedIn ?? "nill")
            Text("Your favorite activities").bold().font(.title2)
            
            if let currentUserFavorites = preDefinedUsers.preDefinedUsersDict[usernameLogedIn]  {
                
                if currentUserFavorites.favoritesList.isEmpty {
                    Text("Create your favorite list").bold().padding()
                }
                else {
                    //Display favorite list
                    List {
                        ForEach(currentUserFavorites.favoritesList) {
                                activity in
                                displayActivity(activity: activity)
                            }
                            //Remove the activity from favorite
                            .onDelete {
                                IndexSet in
                                self.removeFromFavorite(indexSet: IndexSet)
                            }
                        }//List
                        
                    Button(action: {
                            self.confirmDelete = true})
                    {
                        Text("Remove All")
                            .frame(maxWidth: .infinity)
                    }
                    .tint(.red).buttonStyle(.borderedProminent)
                    .alert(isPresented: self.$confirmDelete) {
                        Alert(title: Text("Remove All"),
                              message: Text(""),
                              primaryButton: .destructive( Text("Delete")) {self.removeAll()},
                                  secondaryButton: .default( Text("Cancel")){}
                            )
                    }//alert
                }//If
            }//If
        } //VStack
        //Load the favorite list from UserDefaults
        .onAppear {
            self.loadFavoriteList()
        }//onAppear
    }//body
    
    func loadFavoriteList() {
        let userFavoriteList = UserDefaults.standard.array(forKey: usernameLogedIn) as? [String] ?? []
    
        if var currentUserFavorites = preDefinedUsers.preDefinedUsersDict[usernameLogedIn]  {
            if currentUserFavorites.favoritesList.isEmpty {
                //match the activity id from user favorite list with the id in TouristExperience
                for i in 0..<userFavoriteList.count {
 
                    for activity in TouristExperiences.tourExperienceObject.activityList {

                        if activity.id == userFavoriteList[i] {
                            currentUserFavorites.favoritesList.append(activity)
                        }
                    }
                }
                
                preDefinedUsers.preDefinedUsersDict[usernameLogedIn] = currentUserFavorites
            }
        }// If
    }
    
    //Remove all activties from favorite list
    func removeAll() {
        preDefinedUsers.preDefinedUsersDict[usernameLogedIn]?.favoritesList.removeAll()
        
        var userFavoriteList = UserDefaults.standard.array(forKey: usernameLogedIn) as? [String] ?? []
        
        userFavoriteList.removeAll()
        
        UserDefaults.standard.set(userFavoriteList, forKey: usernameLogedIn)
    }
    
    //Remove an activity from favorite list
    func removeFromFavorite(indexSet: IndexSet) {
        var userFavoriteList = UserDefaults.standard.array(forKey: usernameLogedIn) as? [String] ?? []
        
        //remove the activity from preDefinedUsers
        preDefinedUsers.preDefinedUsersDict[usernameLogedIn]?.favoritesList.remove(atOffsets: indexSet)
        
        //remove the activity id from UserDefault
        userFavoriteList.remove(atOffsets: indexSet)
        
        //save the favorite list into UserDafault
        UserDefaults.standard.set(userFavoriteList, forKey: usernameLogedIn)
    }
}

struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteScreen()
    }
}
