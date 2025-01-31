//
//  SwiftUIView.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 31/01/25.
//

import SwiftUI

struct BotaoCategoriaViewModel {
    var nomeCategoria: [String] =
        ["Montanha ⛰️", "Praia 🏖️", "Natureza 🍃", "Campo 🏕️", "Outros ✈️"]
    
    mutating func filtrarCategoria(categoria: String){
        var categoriaSeparada = categoria.split(separator: " ")
        var categoriaTratada = categoriaSeparada[0]
        
        
    }
}

struct BotaoCategoria: View {
    var categoria: String
    
    var body: some View {
        VStack(alignment: .center){
            Text(categoria)
                .font(.system(size: 20))
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
