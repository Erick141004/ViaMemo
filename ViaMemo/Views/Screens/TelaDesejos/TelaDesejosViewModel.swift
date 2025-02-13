//
//  TelaDesejosViewModel.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI
import CoreData

//class TelaDesejosViewModel: ObservableObject {
//    @Published var desejos: [ListaDesejos] = []
//    @Published var titulo: String = ""
//    @Published var local: String = ""
//    private let contexto: NSManagedObjectContext
//    private let container: NSPersistentContainer
//    
//    @Published var textoProcura: String = ""
//    @Published var buscaAtiva: Bool = false
//    
//    @Published var categoriaSelecionada: Categoria?
//    
//    init() {
//        self.container = PersistenceController.shared.container
//        self.contexto = container.viewContext
//        fetchDesejos()
//    }
//    
//    func imagemCategoria(nomeCategoria: String) -> String {
//        switch nomeCategoria.lowercased() {
//        case "praia":
//            return "praiaImagem"
//        case "montanha":
//            return "montanhaImagem"
//        case "cidade":
//            return "cidadeImagem"
//        case "deserto":
//            return "desertoImagem"
//        case "mochilao":
//            return "mochilaoImagem"
//        case "natureza":
//            return "naturezaImagem"
//        case "campo":
//            return "campoImagem"
//        case "outros":
//            return "outros"
//        default:
//            return "outros"
//        }
//    }
//
//    func filtrarPorCategoria(nome: String) -> Categoria?{
//        let request: NSFetchRequest<Categoria> = Categoria.fetchRequest()
//        request.predicate = NSPredicate(format: "nome == %@", nome)
//        
//        do {
//            let categorias = try contexto.fetch(request)
//            categoriaSelecionada = categorias.first
//            return categoriaSelecionada
//        } catch {
//            print("Erro ao buscar categoria: \(error)")
//        }
//        
//        return nil
//    }
//    
//    func fetchDesejos() {
//        let request: NSFetchRequest<ListaDesejos> = ListaDesejos.fetchRequest()
//        var predicates = [NSPredicate]()
//        
//        if !textoProcura.isEmpty {
//            predicates.append(NSPredicate(
//                format: "titulo CONTAINS[cd] %@ OR local CONTAINS[cd] %@",
//                textoProcura, textoProcura
//            ))
//        }
//        
//        if let categoria = categoriaSelecionada {
//            predicates.append(NSPredicate(format: "ANY desejoCategoria == %@", categoria))
//        }
//        
//        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
//        
//        do {
//            desejos = try contexto.fetch(request)
//        } catch {
//            print("Erro ao buscar postagens: \(error)")
//        }
//    }
//    
//    func adicionarDesejo(titulo: String, local: String, categoria: String) {
//        let novoDesejo = ListaDesejos(context: contexto)
//        novoDesejo.local = local
//        novoDesejo.titulo = titulo
//        novoDesejo.desejoCategoria = filtrarPorCategoria(nome: categoria)
//        
//        categoriaSelecionada = nil
//        salvarContexto()
//    }
//    
//    func deletarDesejo(at offsets: IndexSet) {
//        offsets.forEach { index in
//            let desejo = desejos[index]
//            contexto.delete(desejo)
//        }
//        salvarContexto()
//    }
//    
//    func salvarContexto() {
//        do {
//            try contexto.save()
//            fetchDesejos()
//        } catch {
//            print("Erro ao salvar o contexto: \(error)")
//        }
//    }
//}
