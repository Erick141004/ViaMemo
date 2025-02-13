//
//  TelaDesejosViewModel.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI
import SwiftData

class TelaDesejosViewModel: ObservableObject {
    @Published var desejos: [ListaDesejosSwiftData] = []
    @Published var titulo: String = ""
    @Published var local: String = ""
    
    @Published var textoProcura: String = ""
    @Published var buscaAtiva: Bool = false
    
    @Published var categoriaSelecionada: CategoriaSwiftData?
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
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
        case "floresta":
            return "naturezaImagem"
        case "campo":
            return "campoImagem"
        case "outros":
            return "outros"
        default:
            return "outros"
        }
    }
    
    func filtrarPorCategoria(nome: String) -> CategoriaSwiftData?{
        let request = FetchDescriptor<CategoriaSwiftData>(predicate: #Predicate { $0.nome == nome })
        
        do {
            let categorias = try modelContext.fetch(request)
            categoriaSelecionada = categorias.first
            return categoriaSelecionada
        } catch {
            print("Erro ao buscar categoria: \(error)")
        }
        
        return nil
    }
    
    func fetchDesejos() {
        do {
            let request = FetchDescriptor<ListaDesejosSwiftData>(
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




    
//    func fetchDesejos() {
////        var predicates: [Predicate<ListaDesejosSwiftData>] = []
////
////        if !textoProcura.isEmpty {
////            predicates.append { desejo in
////                desejo.titulo.localizedCaseInsensitiveContains(textoProcura) ||
////                desejo.local.localizedCaseInsensitiveContains(textoProcura)
////            }
////        }
////
////        if let categoria = categoriaSelecionada {
////            predicates.append { desejo in desejo.desejoCategoria?.id == categoria.id }
////        }
//
//        let request = FetchDescriptor<ListaDesejosSwiftData>()
//
//        do {
//            let resultados = try modelContext.fetch(request)
//            desejos = resultados
//        } catch {
//            print("Erro ao buscar desejos: \(error)")
//        }
//
//    }
    
//    func fetchDesejos() {
//        do {
//            // Criando o predicado para filtrar apenas por categoria
//            let predicate = #Predicate<ListaDesejosSwiftData> { desejo in
//                // Verifica se a categoria está selecionada e se corresponde à categoria do desejo
//                guard let categoriaSelecionada = self.categoriaSelecionada else {
//                    // Se não houver categoria selecionada, retorna todos os desejos
//                    return true
//                }
//
//                // Se a categoria estiver selecionada, verifica se ela corresponde à categoria do desejo
//                return desejo.desejoCategoria?.nome == categoriaSelecionada.nome
//            }
//
//            // Configuração do FetchDescriptor com o predicado
//            let descriptor = FetchDescriptor<ListaDesejosSwiftData>(
//                predicate: predicate,
//                sortBy: [SortDescriptor(\.titulo)]  // Você pode mudar a ordem de classificação se necessário
//            )
//
//            // Realiza a busca
//            desejos = try modelContext.fetch(descriptor)
//
//        } catch {
//            print("Erro ao buscar desejos: \(error)")
//        }
//    }


    func adicionarDesejo(titulo: String, local: String, categoria: String) {
        let novaCategoria = filtrarPorCategoria(nome: categoria)
        let novoDesejo = ListaDesejosSwiftData(titulo: titulo, local: local, desejoCategoria: novaCategoria)
        
        modelContext.insert(novoDesejo)
        try? modelContext.save()
        fetchDesejos()
    }
    
    func deletarDesejo(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(desejos[index])
        }
        fetchDesejos()
    }
}
