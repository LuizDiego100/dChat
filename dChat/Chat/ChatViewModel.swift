//
//  ChatViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 11/09/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    
    @Published var text = ""
    
    var inserting = false
    var newCount = 0
    let limit = 20
    
    private let repo: ChatRepository
    
    init(repo: ChatRepository) {
        self.repo = repo
    }
    
    func onAppear(contact: Contact) {
        repo.fetchChat(limit: limit, contact: contact, lastMessage: self.messages.last) { message in
            
            if self.inserting || message.timestamp > self.messages.last?.timestamp ?? 0 {
                    self.messages.insert(message, at: 0)
                } else {
                    self.messages.append(message)
                }
            
                self.inserting = false
                self.newCount = self.messages.count
        }
    }
    
    func sendMessage(contact: Contact) {
        let text = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
        newCount = newCount + 1
        self.text = ""
        self.inserting = true
        
        repo.sendMessage(text: text, contact: contact)
    }
}
