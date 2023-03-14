//
//  ActivitiesScreen.swift
//  Project_#6
//
//  Created by Jansen on 2023-03-02.
//

import SwiftUI

struct ActivitiesScreen: View {
    var body: some View {
        VStack {
            Text("Things to do in Downtown Toronto").bold().font(.title3)
            
            //Activity list
            if TouristExperiences.tourExperienceObject.activityList.isEmpty {
                Text("Empty Activities")
            }
            else {
                List {
                    ForEach(TouristExperiences.tourExperienceObject.activityList) {
                        activity in
                        NavigationLink(destination: ActivityDetailsScreen(selectedActivity: activity)){
                            displayActivity(activity: activity)
                        }
                    }
                }//List
            }//If
        } // VStack
    }//body
}

//Custom View to display an Activity item
struct displayActivity: View {
    var activity: Activity
    
    var body: some View {
        HStack {
            //Image
            Image("\(activity.imageSet[0])").resizable().frame( maxWidth: 160, maxHeight: 140)
               
            //title and price
            VStack(alignment: .leading){
                Text("\(activity.name)")
                    .padding(5)
                
                Text("$\(String(format: "%.2f", activity.pricePerPerson)) /person")
                    .padding(5)
            }//VStack
        }//HStack
    }//body
}

struct ActivitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesScreen()
    }
}

