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
    @State var categoriaViewModel = BotaoCategoriaViewModel()
    @State private var procurar: String = ""
    
    var body: some View {
        VStack{
            SearchBar(textoPesquisa: $procurar)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(categoriaViewModel.nomeCategoria, id: \.self){ categoria in
                        BotaoCategoria(categoria: categoria)
                            .onTapGesture {
                                categoriaViewModel.filtrarCategoria(categoria: categoria)
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            
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
                    Label("", systemImage: "plus")
                        .font(.title)
                        .bold()
                }
                .sheet(isPresented: $mostrarSheet) {
                    SheetDesejo(viewModel: viewModel)
                }
            }
        }
        .navigationTitle("Lista de Desejos")
        
    }
    
    func deletarDesejo(at offsets: IndexSet) {
        viewModel.desejos.remove(atOffsets: offsets)
    }
}
