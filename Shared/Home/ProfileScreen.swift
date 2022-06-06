//
//  ProfileScreen.swift
//  rejseprofil
//
//  Created by Emmanuel on 06/06/2022.
//

import SwiftUI

struct ProfileScreen: View {
  
  @State var showLogin = false
  
    var body: some View {
      NavigationLink(destination: LoginScreen(), isActive: $showLogin) {
        Button(action: {
          UserDefaults.standard.removeObject(forKey: "username")
          UserDefaults.standard.removeObject(forKey: "password")
          
          // Delete each existing persistent store
          PersistenceController.shared.destroyAll()
          
          self.showLogin = true
          
        }) {
          Text("Sign Out")
        }
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
