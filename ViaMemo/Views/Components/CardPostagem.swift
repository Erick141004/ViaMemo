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
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                if let imageData = postagem.imagem, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(12)
                }
                
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
                        Text(formatarLocalizacao(cidade: postagem.cidade, bairro: postagem.bairro))
                    }
                    .font(.caption2)
                    .foregroundColor(.iconeSelecionado)
                    .padding(.top, 1)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                .padding(.top, -5)
            }
            .background(Color.verdePrincipal)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

            Button(action: {
                viewModel.toggleFavorito(postagem: postagem)
            }) {
                Image(systemName: postagem.favorito ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(postagem.favorito ? .verdePrincipal : .white)
                    .padding(10)
            }
        }
    }
    
    private func formatarLocalizacao(cidade: String?, bairro: String?) -> String {
        let cidadeFormatada = cidade?.isEmpty ?? true ? nil : cidade
        let bairroFormatado = bairro?.isEmpty ?? true ? nil : bairro
        
        if let cidade = cidadeFormatada, let bairro = bairroFormatado {
            return "\(cidade) - \(bairro)"
        } else if let cidade = cidadeFormatada {
            return cidade
        } else if let bairro = bairroFormatado {
            return bairro
        } else {
            return "Localização desconhecida"
        }
    }
}
