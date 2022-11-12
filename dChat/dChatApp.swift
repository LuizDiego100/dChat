//
//  dChatApp.swift
//  dChat
//
//  Created by Luiz Andrade on 02/09/2022.
//

import SwiftUI
import Firebase

@main
struct dChatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
extension UIApplication {
    func endEdit() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
