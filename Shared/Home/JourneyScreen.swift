//
//  JourneyScreen.swift
//  rejseprofil
//
//  Created by Emmanuel on 06/06/2022.
//

import SwiftUI
import CoreData

struct JourneyScreen: View {
    // CoreData
    @Environment(\.managedObjectContext) var moc
    
    //  Fetch Cards
    @FetchRequest(entity: Journey.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)]) var journeys: FetchedResults<Journey>
    @FetchRequest(entity: Card.entity(), sortDescriptors: []) var cards: FetchedResults<Card>
    
    // Variables
    var notJourneyTrip = ["Reload", "Reload agreement", "Creation of Reload Agreement", "Balance correction"]
    //    @State private var selectedCard: Card =
    @State var selectedCard: Card?
    @State var selectedCardIndex : Int = 0
    
    
    
    var body: some View {
        VStack {
            Picker(cards[selectedCardIndex].number ?? "Card", selection: $selectedCardIndex) {
                ForEach(0 ..< cards.count, id: \.self) { index in
                    if (cards[index].number != nil && type(of: cards[index]) == Card.self) {
                        Text(self.cards[index].number ?? "Select Card").tag(index)
//                        self.selectedCard = self.cards[index]
                    }
                }
            }
            
//            Picker(selection: $selectedCardIndex, label: Text("")) {
//                ForEach(cards) { card in
//                    if (type(of: card) == Card.self ) {
//                        Text(card.number ?? "Select Card")
//                    }
//
//                }
//            }
            
            GeometryReader { geometry in                    // Get the geometry
                ScrollView(showsIndicators: false) {
                    ForEach(journeys, id: \.self) { journey in
                        if journey.from != nil && journey.to != nil && !notJourneyTrip.contains(journey.from ?? "false") && journey.card == cards[selectedCardIndex] {
                            let originStation = journey.to?.replacingOccurrences(of: "Line : ", with: "")
                            let destinationStation = journey.from?.replacingOccurrences(of: "Line : ", with: "")
                            JourneyView(date: journey.date, from: originStation, to: destinationStation, checkInTime: journey.time, checkOutTime: journey.time, balance: journey.balance)
                                .aspectRatio(contentMode: .fill)
                                .padding(0)
                        }
                    } // ForEach
                } // ScrollView
            }
            
        }
    } // Body
}

struct JourneyScreen_Previews: PreviewProvider {
    static var previews: some View {
        JourneyScreen()
    }
}
