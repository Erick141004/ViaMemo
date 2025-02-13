


import SwiftUI

struct TelaSobreView: View {
    let termosTexto = """
    Termos de Uso

    Ao utilizar a aplicação Viamemo, você concorda com os termos e condições estabelecidos abaixo.
    
    É importante que você leia atentamente este documento, pois ele descreve as regras e responsabilidades ao usar o nosso aplicativo.

    1. Descrição do Serviço
    
        A aplicação Viamemo tem como objetivo permitir que os usuários registrem e organizem suas viagens, salvando fotos, endereços, notas e planejando futuras viagens.
    
        O uso da aplicação está sujeito aos termos e condições aqui estabelecidos.
    
    2. Propriedade intelectual
    3. Responsabilidades
    
    Ao utilizar a aplicação Viamemo, você concorda em:
    
      1) Fornecer informações precisas e atualizadas.
      2) Manter a confidencialidade de sua senha e conta.
      3) Não utilizar a aplicação para fins ilegais ou não autorizados.
      4) Ser responsável por todas as atividades realizadas em sua conta.
    
    4. Alterações nos Termos
    5. Limitação de Responsabilidade
    
    A equipe de desenvolvimento da Viamemo não será responsável por:
    
      1) Danos diretos ou indiretos resultantes do uso ou incapacidade de uso da aplicação.
      2) Perda de dados ou informações devido a falhas técnicas ou de segurança.
      3) Conteúdos gerados por terceiros ou links externos disponíveis na aplicação.
                                                     
    6. Alterações nos Termos de Uso
    
    Este Termo de Uso é regido pela legislação brasileira. A estrutura do site ou aplicativo, as marcas, logotipos, nomes comerciais, layouts, gráficos e design de interface, imagens, ilustrações, fotografias, apresentações, vídeos, conteúdos escritos e de som e áudio, programas de computador, banco de dados, arquivos de transmissão e quaisquer outras informações e direitos de propriedade intelectual de Luisiana Ramirez, Camila de Abreu, Erick Costa, Carla Brito, Bruna Kinjo**, observados os termos da **Lei da Propriedade Industrial (Lei nº 9.279/96), Lei de Direitos Autorais (Lei n° 9.610/98) e Lei do Software (Lei n° 9.609/98), estão devidamente reservados.
    
    Este Termo de Uso não cede ou transfere ao usuário qualquer direito, de modo que o acesso não gera qualquer direito de propriedade intelectual ao usuário, exceto pela licença limitada ora concedida.
    O uso da plataforma pelo usuário é pessoal, individual e intransferível, sendo vedado qualquer uso não autorizado, comercial ou não-comercial. Tais usos consistirão em violação dos direitos de propriedade intelectual de **Luisiana Ramirez, Camila de Abreu, Erick Costa, Carla Brito, Bruna Kinjo**, puníveis nos termos da legislação aplicável.
    """
    
    let politicaTexto = """
    Política de Privacidade

    Sua privacidade é importante para nós. Esta política explica como coletamos, usamos e protegemos suas informações pessoais.
    
    Para a solução de controvérsias decorrentes do presente instrumento será aplicado integralmente o Direito brasileiro.
    
    Os eventuais litígios deverão ser apresentados no foro da comarca em que se encontra a sede da empresa.
    """
    
    @State private var showTermos = false
    @State private var showPolitica = false
    
    var body: some View {
        ZStack {
            Color(red: 2/255, green: 29/255, blue: 29/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showTermos.toggle()
                    }
                    
                }) {
                    HStack {
                        Text("Termos de Uso")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Image(systemName: showTermos ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                if showTermos {
                    ScrollView {
                        Text(termosTexto)
                            .foregroundColor(.white)
                            .font(.body)
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .transition(.opacity)
                }
                            
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showPolitica.toggle()
                    }
                }) {
                    HStack {
                        Text("Política de Privacidade")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        Image(systemName: showPolitica ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                if showPolitica {
                    ScrollView {
                        Text(politicaTexto)
                            .foregroundColor(.white)
                            .font(.body)
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .transition(.opacity)
                }
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle("Via Memo")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("ViaMemo")
                    .foregroundColor(.clear)
                    .overlay {
                        Image("Logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40)
                    }
            }
        }
    }
}

struct TermosDeUsoView_Previews: PreviewProvider {
    static var previews: some View {
        TelaSobreView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(red: 2/255, green: 29/255, blue: 29/255))
    }
}
