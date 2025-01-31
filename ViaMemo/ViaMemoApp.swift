//
//  ViaMemoApp.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//

import SwiftUI

@main
struct ViaMemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TelaInicial()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
