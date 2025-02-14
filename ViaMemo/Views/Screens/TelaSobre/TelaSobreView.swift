


import SwiftUI

struct TelaSobreView: View {
    @State private var showTermos = false
    @State private var showPolitica = false
    
    var body: some View {
        ScrollView {
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
                    .background(Color.verdePrincipal)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                if showTermos {
                    Text("""
    **1. Introdução**
    \nAo acessar e utilizar a aplicação **Viamemo**, você concorda com os termos e condições estabelecidos neste documento. Caso não concorde com qualquer item, recomenda-se que não utilize a aplicação.
    \nEste documento descreve as regras, direitos e responsabilidades dos usuários ao utilizar o **Viamemo**. A leitura atenta e a compreensão desses termos são essenciais para garantir uma experiência segura e adequada.
    \n**2. Descrição do Serviço**
    \nO **Viamemo** é um aplicativo que permite aos usuários registrarem e organizarem suas viagens, salvando fotos, endereços, notas e planejando futuras viagens.
    \nO uso da aplicação está sujeito aos termos e condições aqui estabelecidos, podendo ser alterados a qualquer momento mediante aviso prévio.
    \n**3. Propriedade Intelectual**
    \nTodos os direitos de propriedade intelectual relacionados à aplicação, incluindo estrutura, layout, design, código-fonte, logotipos, marcas, ilustrações, textos e demais elementos visuais e funcionais pertencem exclusivamente a **Luisiana Ramirez, Camila de Abreu, Erick Costa, Carla Brito e Bruna Kinjo**.
    \nO uso da aplicação é concedido ao usuário de forma **limitada, pessoal, intransferível e revogável**, sendo vedada qualquer forma de cópia, reprodução, modificação, distribuição ou comercialização sem autorização expressa.
    \n**4. Responsabilidades do Usuário**
    \nAo utilizar a aplicação **Viamemo**, você concorda em:
    \n- Não utilizar a aplicação para fins ilegais, fraudulentos ou não autorizados.
    - Respeitar os direitos de terceiros, incluindo propriedade intelectual, privacidade e segurança.
    - Não praticar atos que possam comprometer a segurança da plataforma, como disseminação de vírus, spam ou tentativas de invasão.
    \n**5. Limitação de Responsabilidade**
    \nA equipe de desenvolvimento da **Viamemo** não será responsável por:
    \n- Danos diretos, indiretos, incidentais ou consequenciais resultantes do uso ou impossibilidade de uso da aplicação.
    - Perda de dados ou informações devido a falhas técnicas, ataques cibernéticos ou outros eventos imprevistos.
    - Qualquer erro, interrupção ou mau funcionamento que possa afetar a experiência do usuário.
    \n**6. Alterações nos Termos de Uso**
    \nOs **Termos de Uso** podem ser atualizados periodicamente para refletir mudanças na legislação ou melhorias na aplicação. O usuário será notificado sobre alterações significativas, e a continuidade do uso da plataforma implica aceitação dos novos termos.
    \n**7. Legislação Aplicável e Foro**
    \nEstes **Termos de Uso** são regidos e interpretados de acordo com as leis da **República Federativa do Brasil**. Quaisquer disputas ou controvérsias decorrentes do uso da aplicação serão resolvidas no foro da comarca de domicílio do usuário ou, caso este resida fora do Brasil, no foro da cidade de **São Paulo - SP**.
    """)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding()
                    .background(Color.verdePrincipal)
                    .cornerRadius(10)
                    .padding(.horizontal)
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
                    .background(Color.verdePrincipal)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                if showPolitica {
                    Text("""
    **1. Informações Coletadas**
    \nO **ViaMemo** não coleta nem armazena dados pessoais identificáveis dos usuários. No entanto, para que algumas funcionalidades do aplicativo sejam oferecidas corretamente, solicitamos permissões para acessar determinados recursos do seu dispositivo:
    \n- **Localização**: Utilizada para permitir que o usuário registre e visualize locais em seu histórico de viagens.
    - **Câmera**: Utilizada para capturar fotos diretamente no aplicativo e adicioná-las aos registros de viagem.
    - **Galeria**: Utilizada para permitir que o usuário selecione imagens armazenadas no dispositivo e as adicione ao aplicativo.
    \nEssas permissões são utilizadas estritamente para oferecer a funcionalidade proposta pelo **ViaMemo** e não são compartilhadas com terceiros.
    \n**2. Compartilhamento de Dados**
    \nO **ViaMemo** não compartilha, vende ou transfere informações dos usuários para terceiros. O aplicativo também não armazena dados em servidores externos, garantindo que todas as informações permaneçam exclusivamente no dispositivo do usuário.
    \n**3. Alterações nesta Política**
    \nPodemos atualizar esta **Política de Privacidade** periodicamente. Qualquer alteração será comunicada por meio do aplicativo. O uso contínuo do **ViaMemo** após as atualizações será considerado como aceitação dos novos termos.
    """)
                    .foregroundColor(.white)
                    .font(.body)
                    .padding()
                    .background(Color.verdePrincipal)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top, 10)
        }
        .background(Color.fundo)
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
