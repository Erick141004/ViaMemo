//
//  ListaDesejos.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 13/02/25.
//
//

import Foundation
import SwiftData


@Model
class ListaDesejosSwiftData {
    var id: UUID
    var titulo: String
    var local: String
    var desejoCategoria: CategoriaSwiftData?
    
    init(id: UUID = UUID(), titulo: String, local: String, desejoCategoria: CategoriaSwiftData? = nil) {
        self.id = id
        self.titulo = titulo
        self.local = local
        self.desejoCategoria = desejoCategoria
    }
}
