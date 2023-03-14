//
//  ContentView.swift
//  Project_#6
//
//  Created by Jansen & Gelareh on 2023-03-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*If the user chooses "Remember Me", then user enable to login to the app whitout re-entering their email and password */
        NavigationStack {
            if !UserDefaults.standard.bool(forKey: "rememberMe")
            {
                LoginScreen()
            }
            else {
                HomeScreen()
            }
        }//Navigation
    }//body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
