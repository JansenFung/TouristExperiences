//
//  Activity.swift
//  Project_#6
//
//  Created by Jansen & Gelareh on 2023-03-02.
//

import Foundation

//Activity structure
struct Activity: Identifiable {
    var id: String
    var name: String
    var description: String
    var rating: Double
    var hosting: String
    var phoneNumber: String
    var pricePerPerson: Double
    var imageSet: [String]
    
    init(name: String, description: String, rating: Double, hosting: String, phoneNumber: String, pricePerPerson: Double, imageSet: [String]) {
        self.id = "\(String(format: "%.1f", rating))_\(name)_\(hosting)"
        self.name = name
        self.description = description
        self.rating = rating
        self.hosting = hosting
        self.phoneNumber = phoneNumber
        self.pricePerPerson = pricePerPerson
        self.imageSet = imageSet
    }
}

