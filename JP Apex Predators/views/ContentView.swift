//
//  ContentView.swift
//  JP Apex Predators
//
//  Created by Jimmy Ghelani on 2023-09-05.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    
    let apController = PredatorController()
    @State var sortAlphabetical = false
    @State var currentFilter = "All"
    @State var searchFilter = ""
    
    var body: some View {
        
        apController.filterBy(type: currentFilter)
        
        if sortAlphabetical {
            apController.sortByAlphabetical()
        } else {
            apController.sortByMovieAppearance()
        }
        apController.search(for: searchFilter)
        
        
        return NavigationStack {
            List {
                ForEach(apController.apexPredators) { predator in
                    NavigationLink(destination: PredatorDetail(predator: predator)) {
                        PredatorRow(predator: predator)
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            sortAlphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: sortAlphabetical ? "film" : "textformat")
                            .foregroundStyle(.accent)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentFilter.animation()) {
                            ForEach(apController.typeFilters, id: \.self) { type in
                                if type != "Movie" {
                                    HStack {
                                        Text(type)
                                        Spacer()
                                        Image(systemName: apController.typeIcon(for: type))
                                    }
                                } else {
                                    HStack {
                                        Text(type)
                                        Menu {
                                            Picker("Menu", selection: $currentFilter.animation()){
                                                ForEach(apController.movieFilters, id: \.self) {movie in
                                                    HStack {
                                                        Text(movie)
                                                    }
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "slider.horizontal.3")
                                        }
                                        
                                    }
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(.accent)
                    }
                    
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    TextField("Search", text: $searchFilter)
                }
            })
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
