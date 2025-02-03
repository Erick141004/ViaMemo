//
//  TabBar.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI

struct TabBar: View {
    let contexto = PersistenceController.shared.container.viewContext
    var body: some View {
        TabView {
            NavigationView{
                TelaDesejosView(contexto: contexto)
            }
            .tabItem {
                Label("Lista de Desejos", systemImage: "square.and.pencil")
            }
        }
    }
}

#Preview {
    TabBar()
}
