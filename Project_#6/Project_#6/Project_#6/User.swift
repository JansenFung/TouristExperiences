//
//  User.swift
//  Project_#6
//
//  Created by Jansen & Gelareh on 2023-03-02.
//

import Foundation

//User structure
struct User{
    var emailAddress: String
    var password: String
    var favoritesList = [Activity]()
    var joinedActivities = [String]()
    
    init(emailAddress: String, password: String){
        self.emailAddress = emailAddress
        self.password = password
    }
}
