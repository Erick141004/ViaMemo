//
//  TelaDesejosView.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI
import CoreData

struct TelaDesejosView: View {
    @StateObject private var viewModel: TelaDesejosViewModel
    @Environment(\.managedObjectContext) private var contexto
    @State var mostrarSheet = false
    @State var categoriaViewModel = BotaoCategoriaViewModel()
    @State private var procurar: String = ""
    
    init(contexto: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: TelaDesejosViewModel(contexto: contexto))
    }
    
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
                .padding()
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
            Button(action: {
                mostrarSheet = true
            }) {
                Label("", systemImage: "plus")
                    .font(.title)
            }.sheet(isPresented: $mostrarSheet) {
                SheetDesejo(viewModel: viewModel)
            }
        }
        .navigationTitle("Lista de Desejos")
        
    }
    
    func deletarDesejo(at offsets: IndexSet) {
        viewModel.desejos.remove(atOffsets: offsets)
    }
}
