//
//  HomeScreen.swift
//  rejseprofil
//
//  Created by Emmanuel on 06/06/2022.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab = 0
    @Environment(\.managedObjectContext) var moc
    
    let numTabs = 3
    let minDragTranslationForSwipe: CGFloat = 50
    
    //  Fetch Cards
    @FetchRequest(entity: Card.entity(), sortDescriptors: []) var cards: FetchedResults<Card>
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                CardScreen()
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext )
            }.tabItem {
                Image(systemName: "creditcard")
                Text("Cards")
            }
            .tag(0)
            .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            
            
            NavigationView {
                JourneyScreen()
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext )
            }.tabItem {
                Image(systemName: "tram")
                Text("Journeys")
            }
            .tag(1)
            .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            
            NavigationView {
                ProfileScreen()
            }.tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .tag(2)
            .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
        }
    }
    
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && selectedTab > 0 {
            selectedTab -= 1
        } else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
            selectedTab += 1
        }
    }
}
