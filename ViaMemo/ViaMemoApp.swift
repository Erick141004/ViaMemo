// ViaMemoApp.swift
// ViaMemo
//
// Created by ERICK COSTA REIMBERG DE LIMA on 30/01/25.
//
import SwiftUI

@main
struct ViaMemoApp: App {
    @StateObject private var postagemViewModel = TelaPostagemViewModel()
    @StateObject private var desejoViewModel = TelaDesejosViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
