//
//  ProfileScreen.swift
//  rejseprofil
//
//  Created by Emmanuel on 06/06/2022.
//

import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var appData: AppData
    @State var showLogin = false
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        
        Button(action: {
            UserDefaults.standard.removeObject(forKey: "username")
            UserDefaults.standard.removeObject(forKey: "password")
            
            appData.isLoggedIn = false
            
            // Delete each existing persistent store
            PersistenceController.shared.destroyAll()
            (UIApplication.shared.delegate as? AppDelegate)?.signOutAndReloadApp()
            //          self.showLogin = true
            
        }) {
            Text("Sign Out")
        }
        .frame(width: 150, height: 50, alignment: .center)
        .foregroundColor(.white)
        .background(.blue)
        .cornerRadius(25)
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
