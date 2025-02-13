//
//  CardDesejo.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 30/01/25.
//

import SwiftUI

struct CardDesejo: View {
    var desejo: ListaDesejos
    @ObservedObject var viewModel: TelaDesejosViewModelSwiftData
    
    var body: some View {
        GeometryReader { responsivo in
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    
                    if let categoriaNome = desejo.desejoCategoria?.nome {
                        Image(viewModel.imagemCategoria(nomeCategoria: categoriaNome))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(desejo.titulo )
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .lineLimit(2)
                        
                        Text(desejo.local )
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .frame(width: responsivo.size.width * 1, alignment: .leading)
                .background(.verdePrincipal)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .frame(width: responsivo.size.width, alignment: .center)
        }
        .frame(height: 100)
    }
}
