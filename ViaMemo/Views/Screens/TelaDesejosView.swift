//
//  TelaDesejosView.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI

struct TelaDesejosView: View {
    @State private var desejos = [LocalDesejo]()
    @State var mostrarSheet = false
     
    var body: some View {
        VStack {
                ForEach(desejos, id: \.titulo) { desejo in
                    CardDesejo(desejo: desejo)
                }
                .padding()
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
                SheetDesejo(desejos: $desejos)
            }
        }
        .navigationTitle("Lista de Desejos")
        
    }
}

#Preview {
    TelaDesejosView()
}
