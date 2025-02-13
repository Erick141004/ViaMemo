//
//  SheetPostagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 03/02/25.
//

import SwiftUI
import PhotosUI

struct SheetPostagem: View {
    @ObservedObject var viewModel: TelaPostagemViewModelSwiftData
    @Environment(\.dismiss) var dismiss
    @State var categoriaSelecionada: String = "Montanha ⛰️"
    @StateObject var categoriaViewModel = BotaoCategoriaViewModel()
    
    private var podeSalvar: Bool {
        return viewModel.imagemSelecionada != nil && !viewModel.titulo.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Imagem")) {
                    PhotosPicker(selection: $viewModel.imagemSelecionadaItem, matching: .images, photoLibrary: .shared()) {
                        Text("Selecionar Imagem")
                            .foregroundColor(.blue)
                    }
                    .onChange(of: viewModel.imagemSelecionadaItem) { item in
                        viewModel.selecionarImagem()
                    }
                    
                    if let imagem = viewModel.imagemSelecionada {
                        Image(uiImage: imagem)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .padding(.top)
                    }
                }
                
                Section(header: Text("Informações da Memória")) {
                    TextField("Título", text: $viewModel.titulo)
                        .autocapitalization(.sentences)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Observações")) {
                    TextEditor(text: $viewModel.notas)
                        .lineLimit(5)
                }
                
                Section(header: Text("Categoria")){
                    Picker("Categoria",selection: $categoriaSelecionada){
                        ForEach(categoriaViewModel.nomeCategoria, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                if !viewModel.data.isEmpty {
                    Text("Data: \(viewModel.data)")
                }
                
                if !(viewModel.cidade.isEmpty && viewModel.bairro.isEmpty) {
                    Text("Localização: \(viewModel.formatarLocalizacao(cidade: viewModel.cidade, bairro: viewModel.bairro))")
                }
                
            }
            .navigationTitle("Nova Postagem")
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        viewModel.cancelarPostagem()
                        limparCampos()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        viewModel.adicionarPostagem(categoria: categoriaViewModel.extrairCategoria(categoria: categoriaSelecionada))
                        limparCampos()
                        dismiss()
                    }
                    .disabled(!podeSalvar)
                }
            }
        }
    }
    
    private func limparCampos() {
        viewModel.imagemSelecionada = nil
        viewModel.titulo = ""
        viewModel.notas = ""
        viewModel.cidade = ""
        viewModel.data = ""
        categoriaSelecionada = ""
    }
    
}
