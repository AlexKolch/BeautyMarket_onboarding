//
//  ContentView.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 02.03.2025.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(users) { user in
                    Text(user.firstName)
                }
            }
            .padding()
            .task {
                await fetchData()
            }
        }
    }
    
    private func fetchData() async {
        do {
            users = try await DataManager().loadUsers()
            products = try await DataManager().loadProducts()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
