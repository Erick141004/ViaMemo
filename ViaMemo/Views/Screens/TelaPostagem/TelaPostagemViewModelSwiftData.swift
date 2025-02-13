//
//  TelaPostagemViewModelSwiftData.swift
//  ViaMemo
//
//  Created by ERICK COSTA REIMBERG DE LIMA on 12/02/25.
//

//
//  TelaPostagemViewModel.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 03/02/25.
//

import SwiftUI
import SwiftData
import PhotosUI
import CoreLocation

class TelaPostagemViewModelSwiftData: ObservableObject {
    @Published var postagens: [Postagem] = []
    @Published var imagemSelecionadaItem: PhotosPickerItem?
    @Published var imagemSelecionada: UIImage?
    @Published var titulo: String = ""
    @Published var notas: String = ""
    @Published var cidade: String = ""
    @Published var data: String = ""
    @Published var bairro: String = ""
    
    @Published var textoProcura: String = ""
    @Published var buscaAtiva: Bool = false
    
    @Published var categoriaSelecionada: Categoria?
    
    @Published var favoritoSelecionado: Bool = false
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
    }
    
    func filtrarPorCategoria(nome: String) -> Categoria?{
        let categoriaEscolhida = FetchDescriptor<Categoria>(predicate: #Predicate{$0.nome == nome})
        
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
    
    func fetchPostagens() {
//        let request: NSFetchRequest<Postagem> = Postagem.fetchRequest()
//        var predicates = [NSPredicate]()
//        
//        if !textoProcura.isEmpty {
//            predicates.append(NSPredicate(
//                format: "titulo CONTAINS[cd] %@ OR bairro CONTAINS[cd] %@ OR cidade CONTAINS[cd] %@",
//                textoProcura, textoProcura, textoProcura
//            ))
//        }
//        
//        if let categoria = categoriaSelecionada {
//            predicates.append(NSPredicate(format: "ANY postagemCategoria == %@", categoria))
//        }
//         
//        if favoritoSelecionado{
//            predicates.append(NSPredicate(format: "favorito == YES"))
//        }
//        
//        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
//            
//        do {
//            postagens = try context.fetch(request)
//        } catch {
//            print("Erro ao buscar postagens: \(error)")
//        }
    }
    
    func adicionarPostagem(categoria: String) {
        let imagemData = imagemSelecionada?.jpegData(compressionQuality: 0.8)
        
        var newPostagem = Postagem(
            bairro: self.bairro,
            cidade: self.cidade,
            data: self.data,
            favorito: false,
            id: UUID(),
            imagem: imagemData!,
            notas: self.notas,
            titulo: self.titulo,
            postagemCategoria: filtrarPorCategoria(nome: categoria))
        
        self.categoriaSelecionada = nil
        self.imagemSelecionada = nil
        self.imagemSelecionadaItem = nil
    }
    
    func cancelarPostagem() {
        self.imagemSelecionada = nil
        self.imagemSelecionadaItem = nil
    }
    
    func salvarContexto() {
        do {
            try modelContext.save()
            fetchPostagens()
        } catch {
            print("Erro ao salvar contexto: \(error)")
        }
    }

    func atualizarPostagem(postagem: Postagem, titulo: String, notas: String) {
        postagem.titulo = titulo
        postagem.notas = notas
        salvarContexto()
    }
    
    func excluirPostagem(postagem: Postagem) {
        modelContext.delete(postagem)
        salvarContexto()
    }

    func selecionarImagem() {
        guard let pickerItem = imagemSelecionadaItem else { return }
        Task {
            if let data = try? await pickerItem.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.imagemSelecionada = uiImage
                    self.cidade = ""
                    self.data = ""
                    extrairMetadados(from: data)
                }
            }
        }
    }
    
    private func extrairMetadados(from imageData: Data) {
        if let source = CGImageSourceCreateWithData(imageData as CFData, nil),
           let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: Any],
           let exifData = metadata[kCGImagePropertyExifDictionary as String] as? [String: Any] {
            
            if let date = exifData[kCGImagePropertyExifDateTimeOriginal as String] as? String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
                if let dateObj = dateFormatter.date(from: date) {
                    dateFormatter.dateFormat = "dd/MM/yyyy" // Novo formato
                    self.data = dateFormatter.string(from: dateObj)
                }
            }
            
            if let gpsData = metadata[kCGImagePropertyGPSDictionary as String] as? [String: Any] {
                if let latitude = gpsData[kCGImagePropertyGPSLatitude as String] as? Double,
                   let longitude = gpsData[kCGImagePropertyGPSLongitude as String] as? Double {
                    
                    print("Latitude: \(latitude), Longitude: \(longitude)")
                    
                    let location = CLLocation(latitude: latitude * -1, longitude: longitude * -1)
                    let geocoder = CLGeocoder()
                    geocoder.reverseGeocodeLocation(location) { placemarks, error in
                        if let placemark = placemarks?.first, error == nil {
                            self.cidade = placemark.locality ?? ""
                            self.bairro = placemark.subLocality ?? ""
                        } else {
                            self.cidade = ""
                            self.bairro = ""
                        }
                    }
                }
            }
        }
    }
    
    func formatarLocalizacao(cidade: String?, bairro: String?) -> String {
        let cidadeFormatada = cidade?.isEmpty ?? true ? nil : cidade
        let bairroFormatado = bairro?.isEmpty ?? true ? nil : bairro

        if let cidade = cidadeFormatada, let bairro = bairroFormatado {
            return "\(cidade) - \(bairro)"
        } else if let cidade = cidadeFormatada {
            return cidade
        } else if let bairro = bairroFormatado {
            return bairro
        } else {
            return "Local não encontrado"
        }
    }

    func toggleFavorito(postagem: Postagem) {
        postagem.favorito.toggle()
        salvarContexto()
    }
}
