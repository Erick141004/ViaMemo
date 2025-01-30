//
//  CardDesejo.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 30/01/25.
//

import SwiftUI

struct LocalDesejo {
    var titulo: String
    var categoria: UIImage
    var local: String
}

struct CardDesejo: View {
    //var desejo: LocalDesejo
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image(.pin)
                    .padding()
                VStack(alignment: .leading){
                    Text("Praia dos Morangos")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    Text("Santo Amar, SP")
                        .foregroundColor(.white)
                }
            }
            
        }
        .frame(width: 350, height: 80)
        .background(.pink)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    CardDesejo()
}
