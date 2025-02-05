//
//  SheetDesejo.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI
import CoreData

struct SheetDesejo: View {
    @ObservedObject var viewModel: TelaDesejosViewModel
    @Environment(\.dismiss) var dismiss
    @State var categoriaSelecionada: String = ""
    @StateObject var categoriaViewModel = BotaoCategoriaViewModel()
    
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
                
                Section(header: Text("Categoria")){
                    Picker("Categoria",selection: $categoriaSelecionada){
                        ForEach(categoriaViewModel.nomeCategoria, id: \.self) {
                            Text($0)
                        }
                    }
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
                            viewModel.adicionarDesejo(titulo: viewModel.titulo, local: viewModel.local, categoria: categoriaViewModel.extrairCategoria(categoria: categoriaSelecionada))
                            
                            viewModel.titulo = ""
                            viewModel.local = ""
                            categoriaSelecionada = ""
                            
                            dismiss()
                        }
                    }
                    .disabled(!podeSalvar)
                }
            }
          
        }
    }
    
}


#Preview {
    var vm = TelaDesejosViewModel()
    
    return SheetDesejo(viewModel: vm)
}
