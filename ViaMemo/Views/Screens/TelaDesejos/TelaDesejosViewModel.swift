//
//  TelaDesejosViewModel.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 31/01/25.
//

import SwiftUI
import CoreData

class TelaDesejosViewModel: ObservableObject {
    @Published var desejos: [ListaDesejos] = []
    @Published var titulo: String = ""
    @Published var local: String = ""
    private let contexto: NSManagedObjectContext
    private let container: NSPersistentContainer
    
    @Published var textoProcura: String = ""
    @Published var buscaAtiva: Bool = false
    
    init() {
        self.container = PersistenceController.shared.container
        self.contexto = container.viewContext
        fetchDesejos()
    }
    
    func fetchDesejos() {
        let request: NSFetchRequest<ListaDesejos> = ListaDesejos.fetchRequest()
        
        if !textoProcura.isEmpty {
            request.predicate = NSPredicate(
                format: "titulo CONTAINS[cd] %@ OR local CONTAINS[cd] %@",
                textoProcura, textoProcura, textoProcura
            )
            buscaAtiva = true
        } else {
            request.predicate = nil
            buscaAtiva = false
        }
        
        do {
            desejos = try contexto.fetch(request)
        } catch {
            print("Erro ao buscar o desejo: \(error)")
        }
    }
    
    func adicionarDesejo(titulo: String, local: String) {
        let novoDesejo = ListaDesejos(context: contexto)
        novoDesejo.local = local
        novoDesejo.titulo = titulo
        salvarContexto()
    }
    
    func deletarDesejo(at offsets: IndexSet) {
        offsets.forEach { index in
            let desejo = desejos[index]
            contexto.delete(desejo)
        }
        salvarContexto()
    }
    
    func salvarContexto() {
        do {
            try contexto.save()
            fetchDesejos()
        } catch {
            print("Erro ao salvar o contexto: \(error)")
        }
    }
}
