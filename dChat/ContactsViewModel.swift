//
//  ContactsViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 09/09/2022.
//

import SwiftUI
import FirebaseFirestore

class ContactsViewModel: ObservableObject {
    
    @Published var contacts: [Contact] = []
    @Published var isLoading = false
    
    var isLoaded = false
    
    func getContacts() {
        if isLoaded { return }
        isLoading = true
        isLoaded = true
        Firestore.firestore().collection("users")
            .getDocuments { QuerySnapshot, error in
                if let error = error {
                    print("Erro ao buscar contatos: \(error)")
                    return
                }
                
                for document in QuerySnapshot!.documents {
                    print("ID \(document.documentID) \(document.data())")
                    self.contacts.append(Contact(uuid: document.documentID,
                                            name: document.data()["name"] as! String,
                                            profileUrl: document.data()["profileUrl"] as! String))
                }
                self.isLoading = false
            }
    }
}
