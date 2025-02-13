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
    @State private var postagemViewModel: PostagemViewModel?
    
    @State private var desejoViewModel: TelaDesejosViewModel?

    @State var tabSelecionado = 1

    var body: some View {
        TabView(selection: $tabSelecionado) {
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
                    ProgressView() // Para evitar crashes enquanto o ViewModel é criado
                }
            }
            .tabItem {
                Text("Desejos")
                Image(tabSelecionado == 2 ? "desejoSelecionado" : "desejo")
            }.tag(2)
            
            NavigationStack {
                TelaSobreView()
            }
            .tabItem {
                Text("Sobre")
                Image(tabSelecionado == 3 ? "sobreSelecionado" : "sobre")
            }.tag(3)
        }
        .onAppear {
            if desejoViewModel == nil {
                desejoViewModel = TelaDesejosViewModel(modelContext: modelContext)
            }
            
            if postagemViewModel == nil {
                postagemViewModel = PostagemViewModel(modelContext: modelContext)
            }
        }
    }
}


#Preview {
    TabBar()
}
