//
//  ContentView.swift
//  dChat
//
//  Created by Luiz Andrade on 08/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
        if viewModel.isLogged {
            MessagesView()
        } else {
            SignInView()
        }
        }.onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
