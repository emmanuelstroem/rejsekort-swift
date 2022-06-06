//
//  CardScreen.swift
//  rejseprofil
//
//  Created by Emmanuel on 06/06/2022.
//

import SwiftUI
import CoreData

struct CardScreen: View {
  // CoreData
  @Environment(\.managedObjectContext) var moc
  
  //  Fetch Cards
  @FetchRequest(entity: Card.entity(), sortDescriptors: []) var cards: FetchedResults<Card>
  
  
//  @FetchRequest var fetchCards: FetchedResults<Card>
  
  var body: some View {
    GeometryReader { geometry in                    // Get the geometry
      ScrollView(showsIndicators: false) {
        
        VStack {
        
          ForEach(cards, id: \.self) { card in
            
            if card.name != nil && card.balanceAmount != nil && card.number != nil {
              
                CardView(image: "", name: card.name ?? "No Name", amount: card.balanceAmount ?? "9999", number: card.number ?? "1 2 3 4 5 6 7 8 9 0")
            }
            
          } // ForEach
        }
        .padding()
        .frame(minWidth: geometry.size.width)      // Make the scroll view full-width
        .frame(minHeight: geometry.size.height) // Set the content’s min height to the parent
        
      } // ScrollView
    }
  } // Body
}

struct CardScreen_Previews: PreviewProvider {
  static var previews: some View {
    CardScreen()
  }
}
