//
//  TelaDesejosViewModelSwiftData.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 12/02/25.
//

import Foundation
import SwiftData

class TelaDesejosViewModelSwiftData: ObservableObject{
    @Published var desejos: [ListaDesejos] = []
    @Published var titulo: String = ""
    @Published var local: String = ""
    
    @Published var textoProcura: String = ""
    @Published var buscaAtiva: Bool = false
    
    @Published var categoriaSelecionada: Categoria?
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
        fetchDesejos()
    }
    
    func imagemCategoria(nomeCategoria: String) -> String {
        switch nomeCategoria.lowercased() {
        case "praia":
            return "praiaImagem"
        case "montanha":
            return "montanhaImagem"
        case "cidade":
            return "cidadeImagem"
        case "deserto":
            return "desertoImagem"
        case "mochilao":
            return "mochilaoImagem"
        case "natureza":
            return "naturezaImagem"
        case "campo":
            return "campoImagem"
        case "outros":
            return "outros"
        default:
            return "outros"
        }
    }
    
    func filtrarPorCategoria(categoria: String) -> Categoria?{
        let categoriaEscolhida = FetchDescriptor<Categoria>(predicate: #Predicate{$0.nome == categoria})
        
        do {
            let categoria = try modelContext.fetch(categoriaEscolhida)
            categoriaSelecionada = categoria.first
            return categoriaSelecionada
        }
        catch {
            print("Erro ao buscar uma categoria: \(error)")
            return nil
        }
    }
    
    func fetchDesejos() {
        do {
            let request = FetchDescriptor<ListaDesejos>(
                sortBy: [SortDescriptor(\.titulo)]
            )
            
            var resultados = try modelContext.fetch(request)

            if !textoProcura.isEmpty {
                resultados = resultados.filter { desejo in
                    desejo.titulo.localizedCaseInsensitiveContains(textoProcura) ||
                    desejo.local.localizedCaseInsensitiveContains(textoProcura)
                }
            }
            
            if let categoria = categoriaSelecionada {
                resultados = resultados.filter { desejo in
                    desejo.desejoCategoria?.id == categoria.id
                }
            }

            desejos = resultados

        } catch {
            print("Erro ao buscar desejos: \(error)")
        }
    }
    
    func adicionarDesejo(titulo: String, local: String, categoria: String){
        let catego = filtrarPorCategoria(categoria: categoria)
        let desejo = ListaDesejos(local: local, titulo: titulo, desejoCategoria: catego)
        modelContext.insert(desejo)
        try? modelContext.save()
        fetchDesejos()
    }
    
    func deletarDesejo(at offsets: IndexSet){
        offsets.forEach { index in
            let desejo = desejos[index]
            modelContext.delete(desejo)
        }
        fetchDesejos()
    }
}
