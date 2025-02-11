//
//  ListaDesejos.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 11/02/25.
//
//

import Foundation
import SwiftData


@Model public class ListaDesejos {
    var local: String?
    var titulo: String?
    var desejoCategoria: Categoria?
    public init() {

    }
    
}
