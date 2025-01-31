//
//  TabBar.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            NavigationStack{
                TelaDesejosView()
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
