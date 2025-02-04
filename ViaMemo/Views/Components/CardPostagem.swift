//
//  CardPostagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 03/02/25.
//

import SwiftUI

struct CardPostagem: View {
    let postagem: Postagem
    @ObservedObject var viewModel: TelaPostagemViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Botão de coração
            HStack {
                Spacer()
                Button(action: {
                    viewModel.toggleFavorito(postagem: postagem)
                }) {
                    Image(systemName: postagem.favorito ? "heart.fill" : "heart")
                        .foregroundColor(postagem.favorito ? .red : .white)
                        .padding(8)
                }
            }
            
            // Imagem da postagem
            if let imageData = postagem.imagem, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
            }
            
            // Detalhes da postagem
            VStack(alignment: .leading) {
                Text(postagem.titulo ?? "Sem título")
                    .lineLimit(1)
                    .padding(.bottom, 1)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .bold()
                
                Text(postagem.data ?? "Sem data")
                    .foregroundStyle(.white)
                    .font(.caption)
                    .lineLimit(2)
                
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text(postagem.cidade?.isEmpty ?? true ? "Localização desconhecida" : postagem.cidade ?? "Localização desconhecida")
                }
                .font(.caption2)
                .foregroundColor(.iconeSelecionado)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .padding(.top, -5)
        }
        .background(Color.verdePrincipal)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
