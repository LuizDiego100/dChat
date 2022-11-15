//
//  MessagesViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 08/09/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MessageViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var contacts: [Contact] = []
    
    private let repo: MessageRepository
    
    init(repo: MessageRepository) {
        self.repo = repo
    }
    
    func getContacts() {
        repo.getContacts { contacts in
            self.contacts.removeAll()
            self.contacts = contacts
        }
    }
    
    func logout() {
        repo.logout()
    }
}
