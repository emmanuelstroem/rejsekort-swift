//
//  CardView.swift
//  rejseprofil
//
//  Created by Emmanuel on 06/06/2022.
//

import SwiftUI

struct CardModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .cornerRadius(10)
//      .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
//      .border(.gray)
      .overlay(
        RoundedRectangle(cornerRadius: 10.0)
          .stroke(lineWidth: 1.0)
          .opacity(0.3)
      )
  }
}

struct CardView: View {
  
  var image: String
  var name: String
  var amount: String
  var number: String
  
  let screenSize = UIScreen.main.bounds
  
  var body: some View {
//    GeometryReader { hstackGeometry in
//
//    }
    HStack() {
      GeometryReader { circleGeometry in
        HStack {
          Circle()
            .fill(RadialGradient(gradient: Gradient(colors: [.white, Color("rejsekortBlue")]), center: .center, startRadius: 0, endRadius: 150))
            .rotationEffect(.degrees(270))
            .offset(x: -circleGeometry.size.width / 4)
            .aspectRatio(contentMode: .fill)
          
          VStack() {
            HStack {
              Text(name)
                .font(.system(size: 16, weight: .bold, design: .default))
            }.padding(.top, 10)
              .frame(alignment: .trailing)
            Spacer()
            HStack {
              Text(String.init(format: amount) + " kr.")
                .font(.system(size: 20, weight: .bold, design: .default))
            }.frame(alignment: .center)
            Spacer()
            HStack {
              Text(number)
                .font(.system(size: 12, weight: .bold, design: .default))
                .opacity(0.3)
                .aspectRatio(contentMode: .fit)
            }
            .padding(.all, 10)
            .frame(alignment: .trailing)
          }
          .offset(x: -circleGeometry.size.width / 8)
          
        }
      }
      
      
    }
    .frame(minWidth: screenSize.width/2, maxWidth: screenSize.width/1.1, maxHeight: screenSize.height/4)
    .modifier(CardModifier())
  }
}


struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(image: "", name: "Emmanuel Opio", amount: "200", number: "1 2 3 4 5 6 7 8 9 0")
    
    CardView(image: "", name: "Emmanuel Opio", amount: "200", number: "1 2 3 4 5 6 7 8 9 0")
  }
}
