//
//  TelaInicial.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//

import SwiftUI

struct TelaInicial: View {
    @Binding var primeiraVez: Bool
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                LogoInicial()
                InfosIniciais(primeiraVez: $primeiraVez)
            }
            .offset(y: 25)
        }
        .background(
            Image("ImagemPrincipal")
                .resizable()
                .ignoresSafeArea()
        )
        .ignoresSafeArea()
    }
}

struct LogoInicial: View {
    var body: some View {
        Circle()
            .fill(.fundo)
            .frame(maxWidth: 120, maxHeight: 120)
            .offset(y: -180)
            .zIndex(1)

        Image("Logo")
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
            .offset(y: -180)
            .zIndex(1.5)
    }
}

struct InfosIniciais: View {
    @Binding var primeiraVez: Bool
    @State private var isPresentedTermos = false
    @State private var isPresentedPoliticas = false

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("ViaMemo")
                .font(.custom("Schoolbell-Regular", size: 50))
                .padding(.top, 10)

            Text("Todas as suas viagens em um só lugar")
                .font(.system(size: 26, design: .serif))
                .multilineTextAlignment(.center)

            Button {
                UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                primeiraVez = false
            } label: {
                VStack {
                    Text("Começar")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.white)
                }
                .frame(maxWidth: 300, minHeight: 42)
                .background(Color("verdeBotao"))
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, minHeight: 400)
            .background(Color("fundo"))
            .clipShape(RoundedRectangle(cornerRadius: 60))
        }
    }


#Preview {
    TelaInicial(primeiraVez: .constant(true))
}
