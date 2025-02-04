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
    
    var body: some View {
        TabView {
            NavigationStack {
                TelaDesejosView(viewModel: desejoViewModel)
            }
            .tabItem {
                Label("Lista de Desejos", systemImage: "square.and.pencil")
            }

            NavigationStack {
                TelaPostagem(viewModel: postagemViewModel)
            }
            .tabItem {
                Label("Memórias", systemImage: "cat.fill")
            }
        }
    }
}

#Preview {
    TabBar()
}
