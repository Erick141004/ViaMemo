//
//  SheetDesejo.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI

struct SheetDesejo: View {
    @ObservedObject var viewModel: TelaDesejosViewModel
    @Environment(\.dismiss) var dismiss
    
    private var podeSalvar: Bool {
        return !viewModel.titulo.isEmpty && !viewModel.local.isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Título")) {
                    TextField("Digite o nome do local que deseja visitar", text: $viewModel.titulo)
                }
            
                Section(header: Text("Local")) {
                    TextField("Digite o local", text: $viewModel.local)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                       dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Criar") {
                        if !viewModel.titulo.isEmpty {
                            viewModel.adicionarDesejo(titulo: viewModel.titulo, local: viewModel.local)
                            
                            viewModel.titulo = ""
                            viewModel.local = ""
                            
                            dismiss()
                        }
                    }
                    .disabled(!podeSalvar)
                }
            }
        }
        
    }
}
