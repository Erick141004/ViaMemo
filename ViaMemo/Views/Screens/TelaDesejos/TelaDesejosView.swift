//
//  TelaDesejosView.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI
import CoreData

struct TelaDesejosView: View {
    @ObservedObject var viewModel: TelaDesejosViewModel
    @State var mostrarSheet = false
    @StateObject var categoriaViewModel = BotaoCategoriaViewModel()
    @State private var procurar: String = ""
    @State private var categoriaSelecionada: String = ""
    
    var body: some View {
        VStack{
            SearchBar(textoPesquisa: $viewModel.textoProcura, buscarItens: viewModel.fetchDesejos)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(categoriaViewModel.nomeCategoria, id: \.self){ categoria in
                        BotaoCategoria(
                            categoria: categoria,
                            tapCategoria: {
                                let categoriaExtraida = categoriaViewModel.extrairCategoria(categoria: categoria)
                                let _ = viewModel.filtrarPorCategoria(nome: categoriaExtraida)
                                viewModel.fetchDesejos()
                                
                                if categoriaSelecionada != categoria{
                                    categoriaSelecionada = categoria
                                }
                                else {
                                    categoriaSelecionada = ""
                                    viewModel.categoriaSelecionada = nil
                                    viewModel.fetchDesejos()
                                }
                                
                            },
                            selecionado: categoriaSelecionada == categoria)
                    }
                }
                .padding(.horizontal)
            }
            
            if (viewModel.desejos.isEmpty){
                if (viewModel.buscaAtiva){
                    ContentUnavailableView.search(text: viewModel.textoProcura)
                } else{
                    ContentUnavailableView(
                        "Nenhuma postagem",
                        systemImage: "photo.on.rectangle",
                        description: Text("Comece criando sua primeira postagem!")
                    )
                }
            }
            else {
                List {
                    ForEach(viewModel.desejos, id: \.self) { desejo in
                        CardDesejo(desejo: desejo)
                            .listRowBackground(Color.clear)
                            .scrollContentBackground(.hidden)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete { offsets in
                        viewModel.deletarDesejo(at: offsets)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .containerRelativeFrame([.horizontal, .vertical])
        .background(.fundo)
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
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    mostrarSheet = true
                }) {
                    Image(systemName: "plus")
                        .bold()
                }
                .sheet(isPresented: $mostrarSheet) {
                    SheetDesejo(viewModel: viewModel)
                }
            }
        }
        .navigationTitle("Lista de Desejos")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    func deletarDesejo(at offsets: IndexSet) {
        viewModel.desejos.remove(atOffsets: offsets)
    }
}
