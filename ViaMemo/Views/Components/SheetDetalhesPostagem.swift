//
//  SheetDetalhesPostagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 05/02/25.
//

import SwiftUI

struct SheetDetalhesPostagem: View {
    let postagem: Postagem
    @ObservedObject var viewModel: PostagemViewModel
    
    @State private var isEditing: Bool = false
    @State private var tituloEditado: String
    @State private var notasEditadas: String
    @State private var showDeleteAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    init(postagem: Postagem, viewModel: PostagemViewModel) {
        self.postagem = postagem
        self.viewModel = viewModel
        _tituloEditado = State(initialValue: postagem.titulo ?? "")
        _notasEditadas = State(initialValue: postagem.notas ?? "")
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ScrollView {
                    if let imageData = postagem.imagem, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 450)
                            .clipped()
                            .cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 4) {
                            if isEditing {
                                TextField("Titulo", text: $tituloEditado)
                                    .font(.title)
                                    .foregroundStyle(.textos)
                                    .bold()
                                    .cornerRadius(10)
                                    .padding(.leading, 5)
                                    .frame(height: 40)
                                    .background(.verdePrincipal.opacity(0.2))
                                    .cornerRadius(10)
                                    .scrollContentBackground(.hidden)
                                    .padding(.horizontal, 15)
                                    .padding(.top)
                                
                            } else {
                                Text(postagem.titulo ?? "Sem título")
                                    .font(.title)
                                    .foregroundStyle(.textos)
                                    .bold()
                                    .padding(.leading)
                                    .padding(.top)
                            }
                            
                            Rectangle()
                                .frame(height: 3)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .foregroundStyle(.divisaoDetalhes.opacity(0.3))
                                .blur(radius: 1)
                            
                            HStack {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundStyle(.verdePrincipal)
                                    Text(viewModel.formatarLocalizacao(cidade: postagem.cidade, bairro: postagem.bairro))
                                        .font(.subheadline)
                                }
                                .foregroundColor(.textos)
                                .padding(.leading)
                                .padding(.top, 10)
                                
                                Spacer()
                                
                                let categoriasComEmoji: [String: String] = [
                                    "Favoritos": "❤️",
                                    "Montanha": "⛰️",
                                    "Praia": "🏖️",
                                    "Natureza": "🍃",
                                    "Campo": "🏕️",
                                    "Outros": "✈️"
                                ]
                                
                                let nomeCategoria = postagem.postagemCategoria?.nome ?? "Sem categoria"
                                let emoji = categoriasComEmoji[nomeCategoria] ?? ""
                                let categoriaFormatada = "\(nomeCategoria) \(emoji)"
                                
                                HStack {
                                    Text(categoriaFormatada)
                                        .font(.subheadline)
                                        .foregroundStyle(.textos)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.divisaoDetalhes.opacity(0.3))
                                        )
                                }
                                .padding(.trailing)
                                .padding(.top, 6)
                            }
                            Text("Observações")
                                .foregroundStyle(.textos)
                                .bold()
                                .padding(.leading)
                                .padding(.top, 30)
                            
                            Rectangle()
                                .frame(width: 110, height: 3)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .foregroundStyle(.divisaoDetalhes.opacity(0.3))
                                .blur(radius: 1)
                            
                            if isEditing {
                                TextEditor(text: $notasEditadas)
                                    .foregroundStyle(.textos)
                                    .cornerRadius(10)
                                    .padding(.leading, 5)
                                    .frame(height: 120)
                                    .lineLimit(7)
                                    .background(.verdePrincipal.opacity(0.2))
                                    .cornerRadius(10)
                                    .scrollContentBackground(.hidden)
                                    .padding(.horizontal, 15)
                                    .onChange(of: notasEditadas) { novoTexto in
                                        notasEditadas = limiteDeLinhas(texto: novoTexto)
                                    }
                            } else {
                                if let notas = postagem.notas, !notas.isEmpty {
                                    Text(notas)
                                        .foregroundStyle(.textos)
                                        .padding(.leading)
                                        .padding(.top, 6)
                                        .padding(.bottom)
                                        .lineLimit(8)
                                } else {
                                    Text("Sem observações")
                                        .foregroundStyle(.textos)
                                        .padding(.leading)
                                        .padding(.top, 6)
                                }
                            }
                        }
                    }
                }
                
                
                if !isEditing {
                    VStack {
                        Button("Excluir") {
                            showDeleteAlert = true
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 20)
                    }
                }
            }
            .background(Color.fundo)
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Tem certeza que deseja excluir?"),
                    message: Text("Esta ação não pode ser desfeita."),
                    primaryButton: .destructive(Text("Excluir")) {
                        viewModel.excluirPostagem(postagem: postagem)
                        dismiss()
                    },
                    secondaryButton: .cancel(Text("Cancelar"))
                )
            }
            .navigationTitle("Memória")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !isEditing {
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .bold()
                                .frame(width: 18, height: 18)
                                .padding(10)
                        }
                    }
                }
                
                if isEditing {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancelar") {
                            tituloEditado = postagem.titulo ?? ""
                            notasEditadas = postagem.notas ?? ""
                            isEditing = false
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Salvar") {
                            postagem.titulo = tituloEditado
                            postagem.notas = notasEditadas
                            viewModel.salvarContexto()
                            isEditing = false
                        }
                        .disabled(tituloEditado.isEmpty)
                    }
                }
            }
        }
    }
    
    func limiteDeLinhas(texto: String) -> String {
        let linhas = texto.split(separator: "\n")
        let maxLinhas = 7
        if linhas.count > maxLinhas {
            return linhas.prefix(maxLinhas).joined(separator: "\n")
        }
        return texto
    }
}
