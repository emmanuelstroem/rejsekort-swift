//
//  Models.swift
//  rejseprofil
//
//  Created by Emmanuel on 08/05/2022.
//

import SwiftUI

struct UserDetailStruct: Codable {
  let user: UserStruct
  let cards: [CardStruct]
}

struct UserStruct: Codable {
  let name: String
  let address: String
  let email: String
  let landLine: String
  let mobile: String
  
  enum CodingKeys: String, CodingKey {
    case name = "Name"
    case address       = "Address"
    case email = "E-mail"
    case landLine = "Land line"
    case mobile = "Mobile"
  }
}

struct CardStruct: Codable {
  let name: String
  let number: String
  let balance: String
  let electricNumber: String
  let prefix: String
  let expiryDate: String
  let status: String
  let journeys: [JourneyStruct]
  let orders: [OrderStruct]
  
  enum CodingKeys: String, CodingKey {
    case name
    case number
    case balance
    case electricNumber = "electric_number"
    case prefix
    case expiryDate = "expiry_date"
    case status
    case journeys
    case orders
  }
}

struct HistoryStruct: Codable {
  let journeys: [JourneyStruct]
  let orders: [OrderStruct]
}

struct JourneyStruct: Codable {
  let number: String
  let date: String
  let time: String
  let from: String
  let to: String
  let balance: String
  
  enum CodingKeys: String, CodingKey {
    case number = "Journey no."
    case date = "Date"
    case time = "Time"
    case from = "From"
    case to = "To"
    case balance = "Balance DKK"
  }
}

struct OrderStruct: Codable {
  let transactionType: String
  let date: String
  let time: String
  let from: String
  let to: String
  let amount: String
  let balance: String?
  
  enum CodingKeys: String, CodingKey {
    case transactionType = "Transaction Type"
    case date = "Date"
    case time = "Time"
    case from = "From"
    case to = "To"
    case amount = "Amount DKK"
    case balance = "Balance DKK"
  }
}
