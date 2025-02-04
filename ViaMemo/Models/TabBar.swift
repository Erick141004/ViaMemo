//
//  TabBar.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI

struct TabBar: View {
    let contexto = PersistenceController.shared.container.viewContext
    @ObservedObject private var viewModel = TelaPostagemViewModel()
    
    var body: some View {
        TabView {
            NavigationStack {
                TelaDesejosView(contexto: contexto)
            }
            .tabItem {
                Label("Lista de Desejos", systemImage: "square.and.pencil")
            }

            NavigationStack {
                TelaPostagem(viewModel: viewModel)
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
