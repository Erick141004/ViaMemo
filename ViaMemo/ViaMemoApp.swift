// ViaMemoApp.swift
// ViaMemo
//
// Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//
import SwiftUI

@main
struct ViaMemoApp: App {
    @StateObject private var viewModel = TelaPostagemViewModel()
    
    var body: some Scene {
        WindowGroup {
            TelaPostagem(viewModel: viewModel)
                .environmentObject(viewModel)
        }
    }
}
