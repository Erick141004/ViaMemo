//
//  Categoria.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 11/02/25.
//
//

import Foundation
import SwiftData


@Model
class Categoria {
    var nome: String
    var categoriaDesejo: [ListaDesejos]?
    var categoriaPostagem: [Postagem]?
    
    init(nome: String) {
        self.nome = nome
    }
    
}
