//
//  rejseprofilApp.swift
//  Shared
//
//  Created by Emmanuel on 05/06/2022.
//

import SwiftUI

@main
struct rejseprofilApp: App {
  
  // CoreData
//  @StateObject private var dataController = DataController()
//  @StateObject var authenticator = Authenticator()
  
  let persistenceController = PersistenceController.shared
  
//  @FetchRequest(entity: Card.entity(), sortDescriptors: []) var cards: FetchedResults<Card>
  

    var body: some Scene {
        WindowGroup {

          if UserDefaults.standard.string(forKey: "username") != nil && UserDefaults.standard.string(forKey: "password") != nil {
            HomeScreen()
              .environment(\.managedObjectContext, persistenceController.container.viewContext)
          } else {
              LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(Authenticator())
          }
        }
    }
}
