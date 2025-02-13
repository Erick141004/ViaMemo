//
//  Postagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 13/02/25.
//
//

import Foundation
import SwiftData


@Model class PostagemSwiftData {
    var bairro: String
    var cidade: String
    var data: String
    var favorito: Bool
    var imagem: Data
    var notas: String
    var titulo: String
    var postagemCategoria: CategoriaSwiftData?
    
    init(bairro: String, cidade: String, data: String, favorito: Bool, imagem: Data, notas: String, titulo: String, postagemCategoria: CategoriaSwiftData? = nil) {
        self.bairro = bairro
        self.cidade = cidade
        self.data = data
        self.favorito = favorito
        self.imagem = imagem
        self.notas = notas
        self.titulo = titulo
        self.postagemCategoria = postagemCategoria
    }
}

