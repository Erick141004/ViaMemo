//
//  ListaDesejos.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 11/02/25.
//
//

import Foundation
import SwiftData


@Model 
class ListaDesejos {
    var local: String
    var titulo: String
    var desejoCategoria: Categoria?

    public init(local: String, titulo: String, desejoCategoria: Categoria?) {
        self.local = local
        self.titulo = titulo
    }
    
}
