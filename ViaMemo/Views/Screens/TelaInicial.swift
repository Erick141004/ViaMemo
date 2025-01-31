//
//  TelaInicial.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//

import SwiftUI

struct TelaInicial: View {
    var body: some View {
        VStack(){
            Spacer()
            ZStack{
                LogoInicial()
                InfosIniciais()
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
            .frame(maxWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100)
            .offset(y: -177)
            .zIndex(1.5)
    }
}

struct InfosIniciais: View {
    var body: some View {
        VStack(alignment: .center, spacing: 30){
            Text("ViaMemo")
                .font(.system(size: 35))
                .padding(.top, 28)
            
            Text("Todas as suas viagens em um só lugar")
                .font(.system(size: 26, design: .serif))
                .multilineTextAlignment(.center)
                
            Button{
                
            } label: {
                VStack(){
                    Text("Começar")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.white)
                }
                .frame(minWidth: 300, minHeight: 42)
                .background(Color("verdeBotao"))
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            Text("Ao continuar, você aceita nossos Termos de Uso e Política de Privacidade.")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 30)
        .frame(minWidth: 400, minHeight: 400)
        .background(Color("fundo"))
        .clipShape(RoundedRectangle(cornerRadius: 60))
    }
}

#Preview {
    TelaInicial()
}
