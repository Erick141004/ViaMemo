//
//  TabBar.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    @Environment(\.modelContext) private var modelContext
    @State private var postagemViewModel: TelaPostagemViewModelSwiftData?
    @State private var desejoViewModel: TelaDesejosViewModelSwiftData?
    
    @State var tabSelecionado = 1
    
    var body: some View {
        TabView(selection: $tabSelecionado,
                content:  {
            NavigationStack {
                if let postagemViewModel {
                    TelaPostagem(viewModel: postagemViewModel)
               } else {
                   ProgressView()
               }
                
            }
            .tabItem {
                Text("Memórias")
                Image(tabSelecionado == 1 ? "memoriaSelecionado" : "memoria")
            }.tag(1)
            
            NavigationStack {
                if let desejoViewModel {
                   TelaDesejosView(viewModel: desejoViewModel)
               } else {
                   ProgressView()
               }
            }
            .tabItem {
                Text("Desejos")
                Image(tabSelecionado == 2 ? "desejoSelecionado" : "desejo")
            }.tag(2)
            
        })
        .onAppear(){
            if desejoViewModel == nil {
                desejoViewModel = TelaDesejosViewModelSwiftData(modelContext: modelContext)
            }
            
            if postagemViewModel == nil{
                postagemViewModel = TelaPostagemViewModelSwiftData(modelContext: modelContext)
            }
        }
    }
}

