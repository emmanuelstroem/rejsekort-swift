//
//  LoginScreen.swift
//  rejseprofil
//
//  Created by Emmanuel on 08/05/2022.
//

import SwiftUI
import Introspect
import Alamofire

struct LoginScreen: View {
  @EnvironmentObject var authenticator: Authenticator
  @Environment(\.managedObjectContext) var moc
  
//  @State private var name: String = ""
//  @State private var email: String = ""
//  @State private var password: String = ""
  
  var termsAndConditions = Link(destination: URL(string: "https://google.com")!) {
    Text("Terms and Conditions")
  }
  
  let username = UserDefaults.standard.string(forKey: "username")
  let password = UserDefaults.standard.string(forKey: "password")
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.black, .black]),
                     startPoint: .topLeading,
                     endPoint: .bottomTrailing)
      .edgesIgnoringSafeArea(.all)
      
//      LoginView()
//        .environment(\.managedObjectContext, moc)
      
      if username != nil && password != nil {
        HomeScreen()
      } else {
        LoginView()
          .environment(\.managedObjectContext, moc)
      }
    }
    
  }
}

struct LoginScreen_Previews: PreviewProvider {
  static var previews: some View {
    LoginScreen().environmentObject(Authenticator())
  }
}

struct LoginView: View {
  @EnvironmentObject var authenticator: Authenticator
  @Environment(\.managedObjectContext) private var viewContext

  var loginStatusMessage = ""
  @State var isLoginMode = false
  @State var showSheetView = false
  @State var loggedIn = false
  
  var body: some View {
    GeometryReader { geometry in                    // Get the geometry
      ScrollView(showsIndicators: false) {
        VStack {
          Text("Sign in to Rejseprofil")
            .font(.title3)
            .frame(alignment: .center)
            .foregroundColor(Color("rejsekortBlue"))
          VStack(spacing: 16) {
            buttonWithDescription(title: "NemID", description: "You don't have a username for Rejsekort self-service. We'll help you create one.") {
              
              print("NemID Tapped")
              
              // Get saved credentials
              print("Username: \(String(describing: UserDefaults.standard.string(forKey: "username")))")
              print("Password: \(String(describing: UserDefaults.standard.string(forKey: "password")))")
            }
            
            buttonWithDescription(title: "Username", description: "You've previously created a username for Rejsekort self-service.") {
              print("Username Tapped")
              showSheetView = true
              //              authenticator.$isAuthenticating = true
            }
            .sheet(isPresented: $showSheetView) {
              UsernameSheetView(showSheetView: $showSheetView)
                .environment(\.managedObjectContext, viewContext)
            }
          }
          .padding()
        }
        .frame(width: geometry.size.width)      // Make the scroll view full-width
        .frame(minHeight: geometry.size.height) // Set the content’s min height to the parent
//        .background(.black)
      }
    } // Geometry
  }
}

func buttonWithDescription(title: String, description: String, action: @escaping () -> Void) -> some View {
  return Button(action: {
    action()
  }) {
    HStack {
      VStack {
        Text(title)
          .font(.title)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 20)
        Text(description)
          .foregroundColor(Color.gray.opacity(0.8))
          .fontWeight(.light)
          .font(.subheadline)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 20)
          .multilineTextAlignment(.leading)
          .minimumScaleFactor(0.7)
      }
      .frame(alignment: .leading)
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    .padding()
    .overlay(
      RoundedRectangle(cornerRadius: 25)
        .stroke(Color("rejsekortBlue"), lineWidth: 2)
    )
    
  }
  .cornerRadius(25)
}

struct UsernameSheetView: View {
  @State var username = ""
  @State var password = ""
  @EnvironmentObject var authenticator: Authenticator
  @State var isLoggedIn = false
  
  @Environment(\.managedObjectContext) private var moc
  
//  @FetchRequest(entity: User.entity(), sortDescriptors: [], predicate: nil, animation: .default)
//  private var allUsers: FetchedResults<User>
  
  @Binding var showSheetView: Bool
  
  var body: some View {
    GeometryReader { geometry in
      NavigationView {
        VStack {
          Spacer()
          VStack {
            TextField("Username", text: $username)
              .keyboardType(.asciiCapable)
              .textContentType(.username)
              .disableAutocorrection(true)
              .autocapitalization(.none)
              .cornerRadius(10)
              .padding(20)
              .overlay(
                RoundedRectangle(cornerRadius: 25)
                  .stroke(Color("rejsekortBlue"), lineWidth: 2)
              )
              .introspectTextField { textField in
                textField.becomeFirstResponder()
              }
            
            SecureField("Password", text: $password)
              .padding(20)
              .cornerRadius(10)
              .overlay(
                RoundedRectangle(cornerRadius: 25)
                  .stroke(Color("rejsekortBlue"), lineWidth: 2)
              )
            
            NavigationLink(destination: HomeScreen(), isActive: $isLoggedIn) {
              Button(action: {
                showSheetView = authenticator.login(username: username, password: password, moc: moc)
//                isLoggedIn = loginStatus
              }) {
                Text("Sign In")
              }
            }
            .frame(width: 150, height: 50, alignment: .center)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(25)
            
//            Button("Sign in") {
//              isLoggedIn = authenticator.login(username: username, password: password, moc: moc)
//
//              if isLoggedIn {
//                // Get saved credentials
//                print("Username: \(String(describing: UserDefaults.standard.string(forKey: "username")))")
//                print("Password: \(String(describing: UserDefaults.standard.string(forKey: "password")))")
//                self.showSheetView = true
//
//                NavigationLink(destination: HomeScreen()) {
//                }
//              }
//              // Login Failed, show error message
//            }
//            .frame(width: 150, height: 50, alignment: .center)
//            .foregroundColor(.white)
//            .background(.blue)
//            .cornerRadius(25)
            
          }
          
          Spacer()
          VStack {
            HStack {
              Image(systemName: "lock")
              Text("Your credentials will be encrypted and stored securely on your device. They are ONLY used to sign in to Rejsekort self-service")
                .foregroundColor(Color.gray.opacity(0.7))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
            }
            HStack {
              Text("Terms and Privacy Policy.")
            }
            
          } // Terms & Conditions VStack
          .frame(width: geometry.size.width * 0.9, alignment: .center)
        }
        .frame(width: geometry.size.width * 0.7, alignment: .center)
        .navigationBarTitle(Text("Sign in with Username"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
          print("Dismissing UsernameSheetView")
          self.showSheetView = false
        }) {
          Text("Cancel").bold()
        })
      } // NavigatorView
    } // GeometryReader
    .frame(alignment: .center)
  }
}
