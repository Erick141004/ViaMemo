//
//  Categoria.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 13/02/25.
//
//

import Foundation
import SwiftData

@Model
class CategoriaSwiftData {
    var id: UUID
    var nome: String
    
    init(id: UUID = UUID(), nome: String) {
        self.id = id
        self.nome = nome
    }
}
