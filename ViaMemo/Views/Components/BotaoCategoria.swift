//
//  SwiftUIView.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 31/01/25.
//

import SwiftUI
import CoreData
import Foundation

class BotaoCategoriaViewModel: ObservableObject {
    @Published var nomeCategoria: [String] =
        ["Favoritos ❤️", "Montanha ⛰️", "Praia 🏖️", "Natureza 🍃", "Campo 🏕️", "Outros ✈️"]
    
    func extrairCategoria(categoria: String) -> String{
         let categoriaSeparada = categoria.split(separator: " ")
         print(categoriaSeparada[0])
         return String(categoriaSeparada[0])
    }
}

struct BotaoCategoria: View {
    var categoria: String
    var tapCategoria: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .center){
            Text(categoria)
                .font(.subheadline)
                .foregroundStyle(.iconeSelecionado)
        }
        .onTapGesture {
            tapCategoria()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(.verdeBotao)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    BotaoCategoria(categoria: "Montanha ⛰️")
}
