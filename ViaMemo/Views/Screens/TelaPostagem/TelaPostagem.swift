//
// TelaPostagem.swift
// ViaMemo
//
// Created by CARLA DHEYSLANE FERREIRA BRITO on 03/02/25.
//

import SwiftUI

struct TelaPostagem: View {
    @ObservedObject var viewModel: TelaPostagemViewModel
    @State private var mostrarSheet = false
    @State private var postagemSelecionada: Postagem?
    @State private var procurar: String = ""
    @StateObject private var categoriaViewModel = BotaoCategoriaViewModel()
    @State private var categoriaSelecionada: String = ""
    
    var body: some View {
        VStack {
            SearchBar(textoPesquisa: $viewModel.textoProcura, buscarItens: viewModel.fetchPostagens)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    BotaoCategoria(
                        categoria: "Favoritos ❤️",
                        tapCategoria: {
                            viewModel.favoritoSelecionado.toggle()
                            viewModel.fetchPostagens()
                        }, 
                        selecionado: viewModel.favoritoSelecionado)
                    
                    ForEach(categoriaViewModel.nomeCategoria, id: \.self) { categoria in
                        BotaoCategoria(
                            categoria: categoria,
                            tapCategoria: {
                                let categoriaExtraida = categoriaViewModel.extrairCategoria(categoria: categoria)
                                let _ = viewModel.filtrarPorCategoria(nome: categoriaExtraida)
                                viewModel.fetchPostagens()
                                
                                if categoriaSelecionada != categoria{
                                    categoriaSelecionada = categoria
                                }
                                else {
                                    categoriaSelecionada = ""
                                    viewModel.categoriaSelecionada = nil
                                    viewModel.fetchPostagens()
                                }
                            },
                            selecionado: categoriaSelecionada == categoria
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 5)
            
            if viewModel.postagens.isEmpty {
                if viewModel.buscaAtiva {
                    ContentUnavailableView.search(text: viewModel.textoProcura)
                } else {
                    ContentUnavailableView(
                        "Nenhuma postagem",
                        systemImage: "photo.on.rectangle",
                        description: Text("Comece criando sua primeira postagem!")
                    )
                }
            }
            else {
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ],
                        spacing: 16
                    ) {
                        ForEach(viewModel.postagens, id: \.id) { postagem in
                            CardPostagem(postagem: postagem, viewModel: viewModel)
                                .onTapGesture {
                                    postagemSelecionada = postagem
                                    print(postagem)
                                }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
        .background(Color.fundo)
        .navigationTitle("Memórias")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("ViaMemo")
                    .foregroundColor(.clear)
                    .overlay {
                        Image("Logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40)
                    }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { mostrarSheet = true }) {
                    Image(systemName: "plus")
                        .bold()
                }
            }
        }
        .sheet(isPresented: $mostrarSheet) {
            SheetPostagem(viewModel: viewModel)
        }
        .sheet(item: $postagemSelecionada) { postagem in
            SheetDetalhesPostagem(postagem: postagem, viewModel: viewModel)
        }
    }
}
