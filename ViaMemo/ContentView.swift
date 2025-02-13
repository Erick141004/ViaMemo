//
//  ContentView.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var primeiraVez: Bool = UserDefaults.standard.bool(forKey: "hasLaunchedBefore") == false

    var body: some View {
        Group {
            if primeiraVez {
               TelaInicial(primeiraVez: $primeiraVez)
            } else {
                TabBar()
            }
        }
    }
}

#Preview {
    ContentView()
}
