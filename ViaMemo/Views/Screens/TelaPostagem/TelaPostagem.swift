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
    @State private var procurar: String = ""
    @State private var categoriaViewModel = BotaoCategoriaViewModel()
    
    var body: some View {
        VStack {
            SearchBar(textoPesquisa: $procurar)
                .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categoriaViewModel.nomeCategoria, id: \.self) { categoria in
                        BotaoCategoria(categoria: categoria)
                            .onTapGesture {
                                categoriaViewModel.filtrarCategoria(categoria: categoria)
                            }
                    }
                }
                .padding(.horizontal)
            }
            
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
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color.fundo)
        .navigationTitle("ViaMemo")
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
    }
}
