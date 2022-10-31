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
    
    @State var textSize: CGSize = .zero
    
    @Namespace var bottomId
    
    var body: some View {
        VStack {
            ScrollViewReader { value in
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.messages, id: \.self) { message in
                        MessageRow(message: message)
                    }
                    .onChange(of: viewModel.messages.count) { newValue in
                        print("count is \(newValue)")
                        withAnimation {
                            value.scrollTo(bottomId)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Color.clear
                        .frame(height: 1)
                        .id(bottomId)
                }
            }
            
            
            Spacer()
            
            HStack {
                ZStack {
                    TextEditor(text: $viewModel.text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(24.0)
                        .overlay(RoundedRectangle(cornerRadius: 24.0)
                            .stroke(Color(UIColor.separator), style: StrokeStyle(lineWidth: 1.0))
                        )
                        .frame(maxHeight: (textSize.height + 50) > 100 ? 100 : textSize.height + 50)
                    
                    Text(viewModel.text)
                        .opacity(0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(ViewGeometry())
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 21)
                        .onPreferenceChange(ViewSizeKey.self) { size in
                            print("textSize is \(size)")
                            textSize = size
                        }
                }
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

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewSizeKey.self, value: geometry.size)
        }
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        print("new value is \(value)")
        value = nextValue()
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
