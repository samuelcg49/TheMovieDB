//
//  FeedbackView.swift
//  TheMovieDB
//
//  Created by Samuel Cíes Gracia on 15/4/24.
//

import SwiftUI
import MessageUI
import SafariServices

struct FeedbackView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    private let mailComposeDelegate = MailDelegate()
    private let messageComposeDelegate = MessageDelegate()
    
    @State var isShowingActivityView = false
    @State var urlToShow = ""
    @State var isShowingURL = false
    
    let phoneNumber = "677777777"
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Form{
                    //MARK: - Contacto
                    Section{
                        //Llamada
                        Button{
                            if let phoneURL = URL(string: "tel://\(phoneNumber)"){
                                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
                            }
                        } label: {
                            HStack{
                                Image(systemName: "phone")
                                Text("Llamar")
                            }
                        }
                        //WhatsApp
                        Button{
                           openWhatsApp()
                        } label: {
                            HStack{
                                Image(systemName: "phone.bubble.left")
                                Text("Enviar WhatsApp")
                            }
                        }
                        
                        //Enviar email
                        Button{
                            self.presentMailCompose()
                        } label: {
                            HStack{
                                Image(systemName: "mail")
                                Text("Enviar un mail")
                            }
                        }
                        
                        //Enviar SMS
                        Button{
                            self.presentMessageCompose()
                        } label: {
                            HStack{
                                Image(systemName: "message")
                                Text("Enviar un SMS")
                            }
                        }
                    }header:{
                        HStack{
                            Text("Contacto")
                        }
                    }
                    //MARK: - Información
                    Section(header: Text("Información")){
                        ForEach(informationActions, id: \.id){ action in
                            Button{
                                urlToShow = action.url
                                isShowingURL = true
                            }label: {
                                HStack{
                                    Image(systemName: action.icon)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                    Text(action.name)
                                        .font(.body)
                                }
                            }
                        }
                    }
                    .listStyle(.inset)
                    .frame(height: 30)
                    
                    //MARK: - Cines
                    Section(header: Text("Cines")){
                        ForEach(cines, id: \.id){ cine in
                            Button{
                                urlToShow = cine.url
                                isShowingURL = true
                            }label: {
                                HStack{
                                    Image(systemName: cine.icon)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    
                                    Text(cine.name)
                                        .font(.body)
                                }
                            }
                        }
                    }
                    .listStyle(.inset)
                    .frame(height: 30)
                    
                    //MARK: - Apariencia
                    Section(header: Text("Apariencia")){
                        Toggle(isOn: $isDarkModeOn){
                            HStack{
                                if isDarkModeOn{
                                    Image(systemName: "moon")
                                        .imageScale(.large)
                                }else{
                                    Image(systemName: "sun.max")
                                        .imageScale(.large)
                                }
                                
                                Text("Modo Oscuro")
                            }
                        }.padding(.trailing, 20)
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                isShowingActivityView = true
            }, label: {
                Image(systemName: "square.and.arrow.up")
            }))
            .navigationBarTitle("Configuración", displayMode: .large)
            .sheet(isPresented: $isShowingActivityView, content: {
                ActivityView(activityItems: ["https://apps.apple.com/es/app/instagram/id389801252"])
            })
            .sheet(isPresented: $isShowingURL, content: {
                safari(urlString: $urlToShow)
            })
        }
    }
    func openWhatsApp(){
        let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=677777777&text=Hola")!
        
        if UIApplication.shared.canOpenURL(whatsappURL){
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    FeedbackView()
}

struct safari: UIViewControllerRepresentable{
    @Binding var urlString: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<safari>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: URL(string: urlString)!)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<safari>) {
    
    }
}

extension FeedbackView{
    private class MessageDelegate: NSObject, MFMessageComposeViewControllerDelegate{
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }
    
    private func presentMessageCompose(){
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let vc = UIApplication.shared.windows.filter{ $0.isKeyWindow}.first?.rootViewController
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate
        composeVC.recipients = ["677777777"]
        composeVC.body = "Me gustaría ..."
        vc?.present(composeVC, animated: true)
    }
}

extension FeedbackView{
    private class MailDelegate: NSObject, MFMailComposeViewControllerDelegate{
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
            controller.dismiss(animated: true)
        }
    }
    
    private func presentMailCompose(){
        guard MFMailComposeViewController.canSendMail() else{
            return
        }
        let vc = UIApplication.shared.windows.filter{ $0.isKeyWindow}.first?.rootViewController
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = mailComposeDelegate
        composeVC.setToRecipients(["prueba-email@yopmail.com"])
        composeVC.setSubject("Quiero hacer una pregunta")
        composeVC.setMessageBody("Me gustaría ...", isHTML: false)
        vc?.present(composeVC, animated: true)
    }
}
