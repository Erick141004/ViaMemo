//
//  TelaInicial.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//

import SwiftUI

struct TelaInicial: View {
    var body: some View {
        
        ZStack{
            Image("ImagemPrincipal")
                .resizable()
                .ignoresSafeArea()
            
            VStack(){
                Text("Teste")
            }
            .background(Color("verdePrincipal"))
        }
    }
}

#Preview {
    TelaInicial()
}
