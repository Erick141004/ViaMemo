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
        GeometryReader { responsivo in
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    Image(uiImage: .pin)
                    
                    VStack(alignment: .leading) {
                        Text(desejo.titulo ?? "Sem título")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .lineLimit(2)
                        
                        Text(desejo.local ?? "Local Desconhecido")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .frame(width: responsivo.size.width * 1, alignment: .leading)
                .background(.verdePrincipal)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .frame(width: responsivo.size.width, alignment: .center)
        }
        .frame(height: 100)
    }
}
