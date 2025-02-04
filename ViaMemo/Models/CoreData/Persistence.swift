//
// Persistence.swift
// ViaMemo
//
// Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ViaMemo")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Erro ao carregar o banco de dados: \(error), \(error.userInfo)")
            }
        }
    }
}
