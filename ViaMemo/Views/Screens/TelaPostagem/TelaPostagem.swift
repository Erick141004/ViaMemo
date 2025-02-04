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
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.postagens, id: \.id) { postagem in
                        CardPostagem(postagem: postagem, viewModel: viewModel)
                    }
                }
                .padding()
            }
            .background(.fundo)
            .navigationTitle("ViaMemo")
            .toolbar {
                Button(action: { mostrarSheet = true }) {
                    Image(systemName: "plus")
                        .bold()
                }
            }
            .sheet(isPresented: $mostrarSheet) {
                SheetPostagem(viewModel: viewModel)
            }
        }
    }
}
