//
//  JourneyView.swift
//  rejseprofil
//
//  Created by Emmanuel on 01/07/2023.
//

import SwiftUI

struct JourneyView: View {
    var date: String?
    var from: String?
    var to: String?
    var checkInTime: String?
    var checkOutTime: String?
    var amount: String?
    var balance: String?
    
    var body: some View {
        
        HStack {
            VStack{
                HStack {
                    VStack (alignment: .leading, spacing: 0) {
                        Text(from ?? "Origin")
                            .font(.system(size: 13, weight: .bold, design: .default))
//                            .padding(5)
                            .frame(alignment: .leading)
                            .lineLimit(1)
                            .aspectRatio(contentMode: .fit)
                        Text("↓")
                                .font(.system(size: 13, weight: .bold, design: .default))
                                .foregroundColor(.blue)
                        Text(to ?? "Destination")
                            .font(.system(size: 13, weight: .bold, design: .default))
//                            .padding(5)
                            .frame(alignment: .leading)
                            .lineLimit(1)
                            .aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                    VStack() {
                        Label(checkInTime ?? "CheckIn Time", systemImage: "figure.run") // figure.run airplane.departure
                            .padding(5)
                            .background(.teal)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .font(.system(size: 10, weight: .medium, design: .default))
                        Text("")
                                .font(.system(size: 10, weight: .bold, design: .default))
                                .foregroundColor(.blue)
                        
                        Label(checkOutTime ?? "CheckOut Time", systemImage: "figure.walk") //airplane.arrival
                            .padding(5)
                            .background(.teal)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .font(.system(size: 10, weight: .medium, design: .default))
                            
                    }.frame(alignment: .trailing)

                    VStack {
                        Text(amount ?? "Amount")
                            .font(.system(size: 13, weight: .regular, design: .default))
                            .foregroundColor(.red)
                            .padding(5)
                        Text("")
                                .font(.system(size: 10, weight: .bold, design: .default))
                                .foregroundColor(.blue)
                        Text(balance ?? "Balance")
                            .font(.system(size: 13, weight: .regular, design: .default))
                            .padding(5)
                    }
//                    .padding()
                    .frame(alignment: .trailing)
                }
            }
//            .frame(alignment: .trailing)
//            .padding()
//            .aspectRatio(contentMode: .fit)
//            Divider()
        }
    }
}

struct JourneyView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            JourneyView(from: "Femøren St.", to: "København H Centralbanegården", checkInTime: "11.32", checkOutTime: "12.02", amount: "15", balance: "75")
        }
        .aspectRatio(contentMode: .fit)
        
    }
}
