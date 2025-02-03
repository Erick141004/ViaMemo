//
//  CardDesejo.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 30/01/25.
//

import SwiftUI

struct CardDesejo: View {
    var desejo: ListaDesejos
    var body: some View {
        VStack (alignment: .leading){
            HStack(spacing: 20){
                Image(uiImage: .pin)
                VStack(alignment: .leading){
                    Text(desejo.titulo ?? "Sem título")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    Text(desejo.local ?? "Local Desconhecido")
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
