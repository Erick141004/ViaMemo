//
//  Categoria.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 11/02/25.
//
//

import Foundation
import SwiftData


@Model public class Categoria {
    var nome: String?
    var categoriaDesejo: [ListaDesejos]?
    var categoriaPostagem: [Postagem]?
    public init() {

    }
    
}
