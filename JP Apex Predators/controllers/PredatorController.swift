//
//  PredatorController.swift
//  JP Apex Predators
//
//  Created by Jimmy Ghelani on 2023-09-05.
//

import Foundation

class PredatorController {
    private var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    let typeFilters = ["All", "Land", "Air", "Sea", "Movie"]
    
    let movieFilters = [
        "Jurassic Park",
        "The Lost World: Jurassic Park",
        "Jurassic Park III",
        "Jurassic World",
        "Jurassic World: Fallen Kingdom"
    ]
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding JSON Data: \(error)")
            }
        }
    }
    
    func sortByAlphabetical() {
        apexPredators.sort(by: {$0.name < $1.name})
    }
    
    func sortByMovieAppearance() {
        apexPredators.sort(by: {$0.id < $1.id})
    }
    
    func typeIcon(for type: String) -> String {
        switch type {
        case "All":
            "square.stack.3d.up.fill"
        case "Land":
            "leaf.fill"
        case "Air":
            "wind"
        case "Sea":
            "drop.fill"
        default:
            "quastionmark"
        }
    }
    
    func filterBy(type: String) {
        switch type {
        case
            "Land",
            "Air",
            "Sea" :
            apexPredators = allApexPredators.filter {
                $0.type == type.lowercased()
            }
        case "All":
            apexPredators = allApexPredators
        default:
            apexPredators = allApexPredators.filter {
                $0.movies.contains(type)
            }
        }
    }
    
    func search(for dino: String) {
        if dino != "" {
            apexPredators = apexPredators.filter {
                $0.name.contains(dino)
            }
        }
    }
}
