//
//  SignUpViewModel.swift
//  dChat
//
//  Created by Luiz Andrade on 03/09/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var image = UIImage()
    
    @Published var formInvalid = false
    var alertText = ""
    
    @Published var isLoading = false
    
    func signUp() {
        print("nome: \(name), email: \(email), senha: \(password)")
        
        if (image.size.width <= 0) {
            formInvalid = true
            alertText = "Selecione uma foto"
            return
        }
        
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            guard let user = result?.user, err == nil else {
                self.formInvalid = true
                self.alertText = err!.localizedDescription
                print(err)
                self.isLoading = false
                return
            }
            self.isLoading = false
            print("usuario criado \(user.uid)")
            
            self.uploadPhoto()
        }
    }
    
    private func uploadPhoto() {
        let filename = UUID().uuidString
        
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg"
        
        let ref = Storage.storage().reference(withPath: "/images/\(filename).jpg")
        
        ref.putData(data, metadata: newMetadata) { metadata, err in
            print(err)
            ref.downloadURL { url, error in
                print(error)
                self.isLoading = false
                guard let url = url else { return }
                print("foto criada \(url)")
                self.createUser(photoUrl: url)
            }
        }
    }
    
    private func createUser(photoUrl: URL) {
        let id = Auth.auth().currentUser!.uid
        Firestore.firestore().collection("users")
            .document(id)
            .setData([
                "name": name,
                "uuid": id,
                "profileUrl": photoUrl.absoluteString
            ]) { err in
                if err != nil {
                    print(err!.localizedDescription)
                    return
                }
                
            }
    }
    
}
