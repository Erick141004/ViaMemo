//
//  Postagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 11/02/25.
//
//

import Foundation
import SwiftData


@Model
class Postagem {
    var bairro: String
    var cidade: String
    var data: String
    var favorito: Bool
    var id: UUID
    var imagem: Data
    var notas: String
    var titulo: String
    var postagemCategoria: Categoria?
    
    init(bairro: String,
         cidade: String,
         data: String,
         favorito: Bool,
         id: UUID,
         imagem: Data,
         notas: String,
         titulo: String,
         postagemCategoria: Categoria?) 
    {
        self.bairro = bairro
        self.cidade = cidade
        self.data = data
        self.favorito = favorito
        self.id = id
        self.imagem = imagem
        self.notas = notas
        self.titulo = titulo
    }
    
}
