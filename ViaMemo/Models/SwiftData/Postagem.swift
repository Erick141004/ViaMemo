//
//  Postagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 11/02/25.
//
//

import Foundation
import SwiftData


@Model public class Postagem {
    var bairro: String?
    var cidade: String?
    var data: String?
    var favorito: Bool?
    var id: UUID?
    var imagem: Data?
    var notas: String?
    var titulo: String?
    var postagemCategoria: Categoria?
    public init() {

    }
    
}
