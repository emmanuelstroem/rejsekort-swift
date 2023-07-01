//
//  rejseprofilApp.swift
//  Shared
//
//  Created by Emmanuel on 05/06/2022.
//

import SwiftUI

@main
struct rejseprofilApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // CoreData
    //  @StateObject private var dataController = DataController()
    //  @StateObject var authenticator = Authenticator()
    
    let persistenceController = PersistenceController.shared
    
    //  @FetchRequest(entity: Card.entity(), sortDescriptors: []) var cards: FetchedResults<Card>
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(appDelegate.appData)
            
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    let appData = AppData()
    var window: UIWindow?
    
    func signOutAndReloadApp() {
        // Perform any necessary data clearing or logout operations here
        // ...
        
        DispatchQueue.main.async {
            self.window?.rootViewController = UIHostingController(rootView: ContentView().environmentObject(self.appData))
        }
    }
}

class AppData: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
                UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
            }
        }
        
        init() {
            self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    @Published var needsAuthentication = true
    @Published var isAuthenticating = false
    @Published var needsOnboarding = false
    @Published var isSignedIn = false
}
