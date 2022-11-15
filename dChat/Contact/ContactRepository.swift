//
//  ContactRepository.swift
//  dChat
//
//  Created by Luiz Andrade on 15/11/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ContactRepositpry {
    
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        var contacts: [Contact] = []
        Firestore.firestore().collection("users")
            .getDocuments { QuerySnapshot, error in
                if let error = error {
                    print("Erro ao buscar contatos: \(error)")
                    return
                }
                
                for document in QuerySnapshot!.documents {
                    if Auth.auth().currentUser?.uid != document.documentID {
                        print("ID \(document.documentID) \(document.data())")
                        contacts.append(Contact(uuid: document.documentID,
                                                name: document.data()["name"] as! String,
                                                profileUrl: document.data()["profileUrl"] as! String))
                    }
                }
                completion(contacts)
            }
    }
}

