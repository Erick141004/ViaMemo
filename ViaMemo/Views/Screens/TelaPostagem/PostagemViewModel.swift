//
//  PostagemViewModel.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 13/02/25.
//

import SwiftUI
import CoreData
import PhotosUI
import CoreLocation
import UIKit
import SwiftData

class PostagemViewModel: NSObject, ObservableObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {
    @Published var postagens: [PostagemSwiftData] = []
    @Published var imagemSelecionadaItem: PhotosPickerItem?
    @Published var imagemSelecionada: UIImage?
    @Published var titulo: String = ""
    @Published var notas: String = ""
    @Published var cidade: String = ""
    @Published var data: String = ""
    @Published var bairro: String = ""
    @Published var textoProcura: String = ""
    @Published var buscaAtiva: Bool = false
    @Published var categoriaSelecionada: CategoriaSwiftData?
    @Published var favoritoSelecionado: Bool = false
    
    var modelContext: ModelContext
    private let localGerenciador = CLLocationManager()
    private var localAtual: CLLocation?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        super.init()
        self.localGerenciador.delegate = self
        self.localGerenciador.requestWhenInUseAuthorization()
        self.localGerenciador.startUpdatingLocation()
        fetchPostagens()
    }
    
    func existePostagem() -> Bool {
        do {
            let fetchDescriptor = FetchDescriptor<PostagemSwiftData>()
            let postagens = try modelContext.fetch(fetchDescriptor)
            return !postagens.isEmpty
        } catch {
            print("Error fetching postagens: \(error)")
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let local = locations.last {
            localAtual = local
        }
    }
    
    func filtrarPorCategoria(nome: String) -> CategoriaSwiftData?{
            let categoriaEscolhida = FetchDescriptor<CategoriaSwiftData>(predicate: #Predicate{$0.nome == nome})
            
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
        do {
            let request = FetchDescriptor<PostagemSwiftData>(
                sortBy: [SortDescriptor(\.titulo)]
            )
            
            var resultados = try modelContext.fetch(request)

            if !textoProcura.isEmpty {
                resultados = resultados.filter { postagem in
                    postagem.titulo.localizedCaseInsensitiveContains(textoProcura) ||
                    postagem.bairro.localizedCaseInsensitiveContains(textoProcura) ||
                    postagem.cidade.localizedCaseInsensitiveContains(textoProcura)
                }
                buscaAtiva = true
            } else {
                buscaAtiva = false
            }
            
            if let categoria = categoriaSelecionada {
                resultados = resultados.filter { postagem in
                    postagem.postagemCategoria?.id == categoria.id
                }
            }
            
            if favoritoSelecionado {
                resultados = resultados.filter { postagem in
                    postagem.favorito == true
                }
            }

            postagens = resultados

        } catch {
            print("Erro ao buscar desejos: \(error)")
        }
    }
    
    func adicionarPostagem(categoria: String) {
        let imagemData = imagemSelecionada?.jpegData(compressionQuality: 0.8)
        let catego = filtrarPorCategoria(nome: categoria)
                
        let newPostagem = PostagemSwiftData(
            bairro: self.bairro,
            cidade: self.cidade,
            data: self.data,
            favorito: false,
            imagem: imagemData!,
            notas: self.notas,
            titulo: self.titulo,
            postagemCategoria: catego)
        
        modelContext.insert(newPostagem)
        salvarContexto()
        
        self.categoriaSelecionada = nil
        self.imagemSelecionada = nil
        self.imagemSelecionadaItem = nil
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
    
    func selecionarImagem() {
        guard let pickerItem = imagemSelecionadaItem else { return }
        Task {
            if let data = try? await pickerItem.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await MainActor.run {
                    self.imagemSelecionada = uiImage
                    extrairMetadados(from: data)
                }
            }
        }
    }
    
    func atualizarPostagem(postagem: PostagemSwiftData, titulo: String, notas: String) {
        postagem.titulo = titulo
        postagem.notas = notas
        salvarContexto()
    }
    
    func excluirPostagem(postagem: PostagemSwiftData) {
       modelContext.delete(postagem)
       salvarContexto()
    }

    
    private func extrairMetadados(from imageData: Data) {
        if let source = CGImageSourceCreateWithData(imageData as CFData, nil),
           let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: Any] {
            
            if let exifData = metadata[kCGImagePropertyExifDictionary as String] as? [String: Any],
               let date = exifData[kCGImagePropertyExifDateTimeOriginal as String] as? String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
                if let dateObj = dateFormatter.date(from: date) {
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    DispatchQueue.main.async {
                        self.data = dateFormatter.string(from: dateObj)
                    }
                }
            }
            
            if let gpsData = metadata[kCGImagePropertyGPSDictionary as String] as? [String: Any],
               let latitude = gpsData[kCGImagePropertyGPSLatitude as String] as? Double,
               let longitude = gpsData[kCGImagePropertyGPSLongitude as String] as? Double {
                let location = CLLocation(latitude: latitude * -1, longitude: longitude * -1)
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let placemark = placemarks?.first {
                        self.cidade = placemark.locality ?? ""
                        self.bairro = placemark.subLocality ?? ""
                    }
                }
            }
        }
    }
    
    func toggleFavorito(postagem: PostagemSwiftData) {
        postagem.favorito.toggle()
        salvarContexto()
    }
}
