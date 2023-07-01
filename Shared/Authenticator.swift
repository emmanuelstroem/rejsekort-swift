//
//  Authenticator.swift
//  rejseprofil
//
//  Created by Emmanuel on 08/05/2022.
//

import Foundation
import Alamofire
import CoreData
import SwiftUI

class Authenticator {
    @EnvironmentObject var appData: AppData
    
    func login(username: String, password: String, moc: NSManagedObjectContext, appData: AppData) -> Bool {
        appData.isAuthenticating = true
        
        let parameters = ["username": username, "password": password]
        let decoder = JSONDecoder()
        
        //    suc, ered = AF.request("https://rejsekort-5ullcejj3q-ew.a.run.app/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
        //      .responseData { response in
        //      print(response.result)
        //    }
        
        AF.request("https://rejsekort.eopio.com/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .responseData { response in
                switch response.result {
                case .success (let data):
                    do {
                        let response = try decoder.decode(UserDetailStruct.self, from: data)
                        // success
                        print(response)
                        
                        let userData = User(context: moc)
                        
                        userData.name = response.user.name
                        userData.address = response.user.address
                        userData.email = response.user.email
                        userData.landLine = response.user.landLine
                        userData.mobile = response.user.mobile
                        
                        var cardsList = [ Card(context: moc) ]
                        
                        for card in response.cards {
                            let cardData = Card(context: moc)
                            cardData.name = card.name
                            cardData.number = card.number
                            cardData.balanceAmount = card.balance
                            cardData.electricNumber = card.electricNumber
                            cardData.prefix = card.prefix
                            cardData.expiryDate = card.expiryDate
                            cardData.status = card.status
                            
                            var journeyList = [ Journey(context: moc) ]
                            var orderList = [ Order(context: moc) ]
                            
                            for journey in card.journeys {
                                let journeyData = Journey(context: moc)
                                
                                journeyData.number = journey.number ?? ""
                                journeyData.date = journey.date
                                journeyData.time = journey.time ?? ""
                                journeyData.from = journey.from
                                journeyData.to = journey.to
                                journeyData.balance = journey.balance
                                
                                journeyList.append(journeyData)
                            }
                            
                            for order in card.orders {
                                let orderData = Order(context: moc)
                                
                                orderData.transactionType = order.transactionType ?? ""
                                orderData.date = order.date ?? ""
                                orderData.time = order.time ?? ""
                                orderData.from = order.from ?? ""
                                orderData.to = order.to ?? ""
                                orderData.amount = order.amount ?? ""
                                orderData.balance = order.balance ?? ""
                                
                                orderList.append(orderData)
                            }
                            
                            cardData.journeys = NSSet(array: journeyList)
                            cardData.orders = NSSet(array: orderList)
                            
                            cardsList.append(cardData)
                        }
                        
                        do {
                            try moc.save()
                            print("SUCCESS: data saved")
                            
                            appData.isLoggedIn = true
                            
                            UserDefaults.standard.set(username, forKey: "username")
                            UserDefaults.standard.set(password, forKey: "password")
                            
                        } catch {
                            print("ERROR: saving data")
                            appData.isLoggedIn = false
                            //                        fatalError("CoreData: Error in saving Data...")
                        }
                        
                    } catch { // error
                        appData.isLoggedIn = false
                        print("decoding error:\n\(error)")
                    }
                    //            return response.response?.statusCode ?? 9999
                case let .failure(error):
                    print(error)
                    appData.isLoggedIn = false
                } // response
            } // AF
        return appData.isLoggedIn
    }
    
    func logout() {
        self.appData.needsAuthentication = true
        self.appData.isLoggedIn = false
    }
    
    func onboarded() {
        self.appData.needsOnboarding = false
    }
    
    func offboarded() {
        self.appData.needsOnboarding = true
    }
}
