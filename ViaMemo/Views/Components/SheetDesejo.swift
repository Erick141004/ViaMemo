//
//  SheetDesejo.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI

struct SheetDesejo: View {
    @State private var titulo = ""
    @State private var local = ""
    @Binding var desejos: [LocalDesejo]
    @Environment(\.dismiss) var dismiss
    var maxCaracter = 50
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Título")
                .font(.headline)
            
            TextField("Digite o nome do local que deseja visitar", text: $titulo)
            
            Text("Localização")
                .font(.headline)
            
            TextField("Digite o local", text: $local)
            
            Button("Adicionar Desejo") {
                if !titulo.isEmpty {
                    let novoDesejo = LocalDesejo(titulo: titulo, local: local)
                    desejos.append(novoDesejo)
                    dismiss()
                }
            }
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct SheetDesejo_Previews: PreviewProvider {
    static var previews: some View {
        SheetDesejo(desejos: .constant([]))
    }
}
