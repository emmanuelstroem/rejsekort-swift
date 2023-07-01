//
//  ContentView.swift
//  Shared
//
//  Created by Emmanuel on 05/06/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.managedObjectContext) private var viewContext
//    let persistenceController = PersistenceController.shared
    
    var body: some View {
        if self.appData.isLoggedIn {
          HomeScreen()
            .environment(\.managedObjectContext, viewContext)
        }
        else {
            LoginView()
              .environment(\.managedObjectContext, viewContext)
              .environmentObject(appData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
