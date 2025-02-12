//
//  SearchBar.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 03/02/25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var textoPesquisa: String
    var buscarItens: () -> Void = {}
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.iconeSelecionado)
            
            TextField("Pesquisar", text: $textoPesquisa)
                .padding(5)
                .background(.verdePrincipal)
                .foregroundColor(.white)
                .tint(.iconeSelecionado)
                .onChange(of: textoPesquisa){
                    buscarItens()
                }
            
            if !textoPesquisa.isEmpty {
                    Button(action: {
                        textoPesquisa = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.iconeSelecionado)
                    }
                }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 3)
        .background(RoundedRectangle(cornerRadius: 10).fill(.verdePrincipal))
        .frame(height: 50)
        .padding(.horizontal, 15)
        .background(Color.clear.ignoresSafeArea(.keyboard))
    }
}

#Preview {
    SearchBar(textoPesquisa: .constant("Testeeee"))
}
