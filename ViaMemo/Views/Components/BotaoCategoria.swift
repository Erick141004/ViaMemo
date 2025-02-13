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
        ["Montanha ⛰️", "Praia 🏖️", "Floresta 🍃", "Campo 🏕️", "Outros ✈️"]
    var categoriaSelecionada: String = ""
    
    func extrairCategoria(categoria: String) -> String{
         let categoriaSeparada = categoria.split(separator: " ")
         print(categoriaSeparada[0])
         return String(categoriaSeparada[0])
    }
}

struct BotaoCategoria: View {
    var categoria: String
    var tapCategoria: () -> Void = {}
    var selecionado: Bool
    
    var body: some View {
        VStack(alignment: .center){
            Text(categoria)
                .font(.subheadline)
                .foregroundStyle(.white)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                tapCategoria()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(selecionado ? .verdeBotao : .verdeBotao.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    BotaoCategoria(categoria: "Montanha ⛰️", selecionado: false)
}
