//
//  TouristExperiences.swift
//  Project_#6
//
//  Created by Jansen on 2023-03-02.
//

import Foundation

//Singleton class
class TouristExperiences {
    
    static let tourExperienceObject = TouristExperiences()
    
    var activityList = [Activity]()
    
    private init(){}
    
    //load activity data
    func loadActivities() {
        let act1 = Activity(name: "Toronto Waterfront Bike Adventure",
                          description: "We’ll begin near the iconic Harbourfront Centre where we will pick up some bikes for the experience. We'll explore the 3.5 km of shoreline ride with stops at the Music Garden, Ireland Monument Park and Harbourfront Centre; making plenty of stop for pictures.",
                            rating: 4.6,
                          hosting: "John",
                            phoneNumber: "416-111-2222",
                          pricePerPerson: 35,
                          imageSet: ["Cycling_1", "Cycling_2"])
        
        let act2 = Activity(name: "R&B Concert on a Pirate Ship",
                          description: "We will be enjoying the soulful vocals of the city’s best rising R&B artists under the summer sky. The boat is an old pirate ship and will be traveling across the Toronto skyline. Guests will experience live R&B in an unforgettable ways",
                          rating: 5,
                          hosting: "Taylor",
                            phoneNumber: "416-222-3333",
                          pricePerPerson: 40,
                          imageSet: ["PirateShip_1","PirateShip_2"])
        
        let act3 = Activity(name: "Discover Toronto like a Local - A Guided Walking Tour",
                          description: "Join me to explore Toronto's history and present-day on a walking tour around the city's downtown, Financial District, and Old Town. One of the most multicultural cities in the world, our experience will cover a variety of different styles, and how it translates into Toronto's architecture, culture, and street art.",
                            rating: 4.5,
                          hosting: "Johnny",
                            phoneNumber: "416-333-4444",
                          pricePerPerson: 30,
                          imageSet: ["TorontoWalkingTour_1", "TorontoWalkingTour_2"])
        
        let act4 = Activity(name: "Toronto's Underground Donut Tour",
                          description: "Join us on a donut adventure through the most interesting parts of downtown Toronto, Kensington Market and Chinatown! Our tour begins at Cops Doughnuts right in the heart of the Fashion District. You’ll love their hot, fresh and tiny doughnuts as well as their super cute aesthetic.",
                          rating: 5,
                          hosting: "Allen",
                            phoneNumber: "647-555-4466",
                          pricePerPerson: 75,
                          imageSet: ["Donut_1", "Donut_2"])
        
        let act5 = Activity(name: "Sunset Canoe Tour on the Toronto Islands",
                          description: "As we canoe around the islands, your guide will be telling about the islands and its history, as well as the history of the unique historical Voyageur Canoe replica that we are using on our tours. Our first destination is the Bird Sanctuary.",
                            rating: 4.9,
                          hosting: "James",
                            phoneNumber: "437-116-3566",
                          pricePerPerson: 85,
                          imageSet: ["SunsetCanoe_1", "SunsetCanoe_2"])
        
        let act6 = Activity(name: "Kensington Market 'Taste the World' Food Tour",
                          description: "Tasty Tours has been hosting food tours in the historic Kensington Market for over 10 years. Like its immigrant heritage, Kensington Market is full of survivors who have braved countless changes in the neighbourhood, including the most recent business-decimating pandemic. Find out what makes Kensington so special, and let's support them together!",
                          rating: 5,
                          hosting: "Laura",
                        phoneNumber: "647-789-9873",
                          pricePerPerson: 80,
                          imageSet: ["Food_1", "Food_2"])
        
        //add activities into the activityList
        self.activityList.append(contentsOf: [act1, act2, act3, act4, act5, act6])
    }
}
