//
//  SheetDetalhesPostagem.swift
//  ViaMemo
//
//  Created by CARLA DHEYSLANE FERREIRA BRITO on 05/02/25.
//

import SwiftUI

struct SheetDetalhesPostagem: View {
    let postagem: Postagem
    @ObservedObject var viewModel: TelaPostagemViewModel
    
    @State private var isEditing: Bool = false
    @State private var tituloEditado: String
    @State private var notasEditadas: String
    @State private var showDeleteAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    init(postagem: Postagem, viewModel: TelaPostagemViewModel) {
        self.postagem = postagem
        self.viewModel = viewModel
        _tituloEditado = State(initialValue: postagem.titulo ?? "")
        _notasEditadas = State(initialValue: postagem.notas ?? "")
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                if let imageData = postagem.imagem, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 4) {
                            if isEditing {
                                TextField("Titulo", text: $tituloEditado)
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .cornerRadius(10)
                                    .padding(.leading, 5)
                                    .frame(height: 40)
                                    .background(.verdePrincipal)
                                    .cornerRadius(10)
                                    .scrollContentBackground(.hidden)
                                    .padding(.horizontal, 15)
                                
                            } else {
                                Text(postagem.titulo ?? "Sem título")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .padding(.leading)
                                    .padding(.top)
                            }
                            
                            Rectangle()
                                .frame(height: 3)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .foregroundStyle(.divisaoDetalhes)
                            
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(.verdePrincipal)
                                Text(viewModel.formatarLocalizacao(cidade: postagem.cidade, bairro: postagem.bairro))
                            }
                            .foregroundColor(.white)
                            .padding(.leading)
                            .padding(.top, 10)
                            
                            Text("Observações")
                                .foregroundStyle(.white)
                                .bold()
                                .padding(.leading)
                                .padding(.top, 30)
                            
                            Rectangle()
                                .frame(width: 110, height: 3)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .foregroundStyle(.divisaoDetalhes)
                            
                            if isEditing {
                                TextEditor(text: $notasEditadas)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .cornerRadius(10)
                                    .padding(.leading, 5)
                                    .frame(height: 100)
                                    .background(.verdePrincipal)
                                    .cornerRadius(10)
                                    .scrollContentBackground(.hidden)
                                    .padding(.horizontal, 15)
                            } else {
                                if let notas = postagem.notas, !notas.isEmpty {
                                    Text(notas)
                                        .foregroundStyle(.white)
                                        .padding(.leading)
                                        .padding(.top, 6)
                                } else {
                                    Text("Sem observações")
                                        .foregroundStyle(.white)
                                        .padding(.leading)
                                        .padding(.top, 6)
                                }
                            }

                            Spacer()
                        }
                    }
                    
                    if isEditing {
                        HStack {
                            Button("Cancelar") {
                                tituloEditado = postagem.titulo ?? ""
                                notasEditadas = postagem.notas ?? ""
                                isEditing = false
                            }
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(.botoes)
                            .foregroundColor(.red)
                            .cornerRadius(10)
                            .padding(.horizontal, 15)
                            
                            Spacer()
                            
                            Button("Salvar") {
                                postagem.titulo = tituloEditado
                                postagem.notas = notasEditadas
                                viewModel.salvarContexto()
                                isEditing = false
                            }
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(.botoes)
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .padding(.horizontal, 15)
                            .disabled(tituloEditado.isEmpty)
                        }
                        .padding(.bottom, 20)
                    }
                }

                if !isEditing {
                    VStack {
                        Button("Excluir") {
                            showDeleteAlert = true 
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(.botoes)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 20)
                    }
                }
            }
            .background(.telaDetalhes)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // Botões de edição e favorito
            HStack {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .foregroundStyle(.botoes)
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(10)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.toggleFavorito(postagem: postagem)
                }) {
                    Image(systemName: postagem.favorito ? "heart.fill" : "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(postagem.favorito ? .verdePrincipal : .white)
                        .padding(10)
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .background(Color.fundo)
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Tem certeza que deseja excluir?"),
                message: Text("Esta ação não pode ser desfeita."),
                primaryButton: .destructive(Text("Excluir")) {
                    viewModel.excluirPostagem(postagem: postagem)
                    dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
}
