//
//  HomeScreen.swift
//  Project_#6
//
//  Created by Jansen on 2023-03-02.
//

import SwiftUI

struct HomeScreen: View {
    
    @State var loginLink: Int?
    @State var activeTab = 0
    
    let currentLogInUser = UserDefaults.standard.string(forKey: "username") ?? ""
   
    var body: some View {
        VStack {
            NavigationLink(destination: LoginScreen(), tag: 1, selection: self.$loginLink){}

            TabView(selection: $activeTab) {
                //Activity Screen
                ActivitiesScreen().tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Activites")
                }.tag(0)
                
                //User's favorites list
                FavoriteScreen().tabItem {
                    Image(systemName: "heart")
                    Text("Favorties")
                }.tag(1)
            }//TabView
        }//VStack
        .navigationBarBackButtonHidden(true)
        .onAppear {
            //load activity data from TouristExperiences class when the ContentView starts appear
            if TouristExperiences.tourExperienceObject.activityList.isEmpty {
                TouristExperiences.tourExperienceObject.loadActivities()
            }
        }//toolbar
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    //Logout button
                    Button(action: self.logout) {
                        Text("Log out as \n\(self.currentLogInUser)")
                    }
                }
                label: {
                    Image(systemName:"rectangle.portrait.and.arrow.right")
                }
            }
        }
        .border(.gray, width: 0.1)
        .onAppear{
            UITabBar.appearance().backgroundColor = .white
        }
    }//body
    
    //Logout function
    func logout() {
        //Remove username, password, and rememberMe data from UserDefaults
        UserDefaults.standard.removeObject(forKey: "username")
        
        UserDefaults.standard.removeObject(forKey: "password")
        
        UserDefaults.standard.removeObject(forKey: "rememberMe")
        
        //Redirect to login screen
        self.loginLink = 1
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

