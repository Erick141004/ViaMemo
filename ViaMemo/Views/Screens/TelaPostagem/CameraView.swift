//
//  CameraView.swift
//  ViaMemo
//
//  Created by BRUNA KINJO LUIZ PINTO on 04/02/25.
//

import SwiftUI
import UIKit
import CoreLocation

struct CameraView: UIViewControllerRepresentable {
    @Binding var imagem: UIImage?
    @Binding var cidade: String
    @Binding var bairro: String
    @Binding var data: String
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {
        var camera: CameraView
        let localGerenciador = CLLocationManager()
        var localAtual: CLLocation?
        
        init(_ camera: CameraView) {
            self.camera = camera
            super.init()
            self.localGerenciador.delegate = self
            self.localGerenciador.requestWhenInUseAuthorization()
            self.localGerenciador.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let local = locations.last {
                localAtual = local
                print("Localização capturada: \(local.coordinate.latitude), \(local.coordinate.longitude)")
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                camera.imagem = uiImage

                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                camera.data = formatter.string(from: Date())

                if let local = localAtual {
                    let geocoder = CLGeocoder()
                    geocoder.reverseGeocodeLocation(local) { [weak self] placemarks, error in
                        guard let self = self else { return }
                        
                        if let error = error {
                            print("Erro ao obter endereço: \(error.localizedDescription)")
                            return
                        }
                        
                        if let placemark = placemarks?.first {
                            let cidade = placemark.locality ?? "Cidade desconhecida"
                            let bairro = placemark.subLocality ?? "Bairro desconhecido"
                            
                            DispatchQueue.main.async {
                                self.camera.cidade = cidade
                                self.camera.bairro = bairro
                            }
                        } else {
                            print("Nenhuma localização encontrada")
                        }
                    }
                } else {
                    camera.cidade = "Localização desconhecida"
                    camera.bairro = ""
                }
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
