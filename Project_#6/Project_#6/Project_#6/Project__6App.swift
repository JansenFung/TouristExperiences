//
//  Project__6App.swift
//  Project_#6
//
//  Created by Jansen on 2023-03-02.
//

import SwiftUI

@main
struct Project__6App: App {
    //Environment object
    var preDefinedUsersDict = PreDefinedUsers()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(preDefinedUsersDict)
        }
    }
}
