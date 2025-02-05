//
//  TabBar.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI

struct TabBar: View {
    @ObservedObject private var postagemViewModel = TelaPostagemViewModel()
    @ObservedObject private var desejoViewModel = TelaDesejosViewModel()
    
    @State var tabSelecionado = 1
    
    var body: some View {
        TabView(selection: $tabSelecionado,
                content:  {
            NavigationStack {
                TelaPostagem(viewModel: postagemViewModel)
            }
            .tabItem {
                Text("Memórias")
                Image(tabSelecionado == 1 ? "memoriaSelecionado" : "memoria")
            }.tag(1)
            
            NavigationStack {
                TelaDesejosView(viewModel: desejoViewModel)
            }
            .tabItem {
                Text("Desejos")
                Image(tabSelecionado == 2 ? "desejoSelecionado" : "desejo")
            }.tag(2)
            
        })
    }
}

#Preview {
    TabBar()
}
