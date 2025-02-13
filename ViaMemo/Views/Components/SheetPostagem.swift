//
//  SheetPostagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 03/02/25.
//

import SwiftUI
import PhotosUI

struct SheetPostagem: View {
    @ObservedObject var viewModel: PostagemViewModel
    @Environment(\.dismiss) var dismiss
    @State private var categoriaSelecionada: String = "Montanha ⛰️"
    @StateObject private var categoriaViewModel = BotaoCategoriaViewModel()
    @State private var abrirCamera = false
    
    private var podeSalvar: Bool {
        !viewModel.titulo.isEmpty && viewModel.imagemSelecionada != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Imagem")) {
                    PhotosPicker(selection: $viewModel.imagemSelecionadaItem, matching: .images) {
                        Text("Selecionar Imagem")
                    }
                    .onChange(of: viewModel.imagemSelecionadaItem) { _ in
                        viewModel.selecionarImagem()
                    }
                    
                    if let imagem = viewModel.imagemSelecionada {
                        Image(uiImage: imagem)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    
                    Button("Tirar Foto") { abrirCamera = true }
                        .sheet(isPresented: $abrirCamera) {
                            CameraView(imagem: $viewModel.imagemSelecionada, cidade: $viewModel.cidade, bairro: $viewModel.bairro, data: $viewModel.data)
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
                
                Section(header: Text("Categoria")) {
                    Picker("Categoria", selection: $categoriaSelecionada) {
                        ForEach(categoriaViewModel.nomeCategoria, id: \.self) { Text($0) }
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
                        viewModel.adicionarPostagem(categoria: categoriaSelecionada)
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
