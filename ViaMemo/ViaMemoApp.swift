// ViaMemoApp.swift
// ViaMemo
//
// Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//
import SwiftUI
import SwiftData

@main
struct ViaMemoApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for:  Postagem.self,
                ListaDesejos.self,
                Categoria.self
            )
            criarCategoriasPadrao()
        } catch {
            fatalError("Falha ao configurar o ModelContainer.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
    
    func criarCategoriasPadrao() {
        let categoriasPadrao = ["Praia", "Montanha", "Cidade", "Deserto", "Mochilão", "Natureza", "Campo", "Outros"]
        let context = ModelContext(container)
        
        for nome in categoriasPadrao {
            let request = FetchDescriptor<Categoria>(predicate: #Predicate { $0.nome == nome })
            if (try? context.fetchCount(request)) == 0 {
                context.insert(Categoria(nome: nome))
            }
        }
        try? context.save()
    }
}
