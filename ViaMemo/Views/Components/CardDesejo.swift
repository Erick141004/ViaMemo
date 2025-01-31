//
//  CardDesejo.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 30/01/25.
//

import SwiftUI

struct LocalDesejo {
    var titulo: String
    var local: String
}

struct CardDesejo: View {
    var desejo: LocalDesejo
    var body: some View {
        VStack (alignment: .leading){
            HStack(spacing: 20){
                Image(uiImage: .pin)
                VStack(alignment: .leading){
                    Text(desejo.titulo)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Text(desejo.local)
                        .foregroundColor(.white)
                }
                .frame(width: 170, alignment: .leading)
            }
        }
        .padding(.trailing, 50)
        .padding()
        .background(.verdePrincipal)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct CardDesejo_Previews: PreviewProvider {
    static var previews: some View {
        let desejo = LocalDesejo(titulo: "Praia dos Morangos", local: "Santo Amaro, SP")
        CardDesejo(desejo: desejo)
    }
}


