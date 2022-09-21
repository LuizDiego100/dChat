//
//  ChatView.swift
//  dChat
//
//  Created by Luiz Andrade on 11/09/2022.
//

import SwiftUI

struct ChatView: View {
    
    let contact: Contact
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.messages, id: \.self) { message in
                    MessageRow(message: message)
                }
            }
            
            Spacer()
            
            HStack {
                TextField("Digite a mensagem", text: $viewModel.text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(24.0)
                    .overlay(RoundedRectangle(cornerRadius: 24.0)
                        .stroke(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0))
                    )
                
                Button {
                    viewModel.sendMessage(contact: contact)
                } label: {
                    Text("Enviar")
                        .padding()
                        .background(Color("BlueColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(24.0)
                }
                .disabled(viewModel.text.isEmpty)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.onAppear(contact: contact)
        }
    }
}

struct MessageRow: View {
    
    let message: Message
    
    var body: some View {
        VStack(alignment: .leading) {
        Text(message.text)
            .padding(.vertical, 5)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 10)
            .background(Color(white: 0.95))
            .frame(maxWidth: 260, alignment: message.isMe ? .leading : .trailing)
            //.padding(.leading, message.isMe ? 0 : 50)
            //.padding(.trailing, message.isMe ? 50 : 0)
            
        }
        
        .frame(maxWidth: .infinity, alignment: message.isMe ? .leading : .trailing)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(contact: Contact(uuid: UUID().uuidString, name: "ola mundo", profileUrl: ""))
    }
}
