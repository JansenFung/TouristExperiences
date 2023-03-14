//
//  PreDefinedUsers.swift
//  Project_#6
//
//  Created by Jansen on 2023-03-02.
//

import Foundation

import Foundation

//Ovservable class
class PreDefinedUsers: ObservableObject {
    //A dictionay of predefined users, key: username, value: User()
    //share it among all screens
    @Published var preDefinedUsersDict: [String: User] = [:]
    
    init(){
        let user1 = User(emailAddress: "jansen@gmail.com", password: "123456")
        let user2 = User(emailAddress: "gelareh@gmail.com", password: "123abc")
        
        preDefinedUsersDict[user1.emailAddress] = user1
        preDefinedUsersDict[user2.emailAddress] = user2
    }
}
