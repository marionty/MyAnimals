//
//  ListAnimalsView.swift
//  MyAnimals
//
//  Created by Abdellah Skoundri on 28/12/2023.
//

import SwiftUI

struct ListAnimalsView: View {
    @State var searchTerm = ""
    var filteredAnimals : [Animal] {
        guard !searchTerm.isEmpty else { return animals }
        return animals.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    var body: some View {
        NavigationStack{
            if animals.isEmpty {
                ContentUnavailableView(label: {
                    VStack {
                        Image(.sorry)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text("Pas d'animaux").bold()
                    }
                }, description: {
                    Text("Ajoutez des animaux à votre collection.")
                }, actions: {
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .frame(width: 20, height: 30)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.yellow)
                })
                .navigationTitle("Animals")
            } else {
                ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()]){
                            ForEach(filteredAnimals) { animal in
                                NavigationLink {
                                    AnimalView(animal: animal)
                                } label: {
                                    AnimalView(animal: animal)
                                }
                        }
                    }
                }
                .navigationTitle("Animals")
                .searchable(text: $searchTerm)
                .overlay {
                    if filteredAnimals.isEmpty {
                        ContentUnavailableView.search(text: searchTerm)
                    }
                }
            }
        }
    }
}

#Preview {
    ListAnimalsView()
}
