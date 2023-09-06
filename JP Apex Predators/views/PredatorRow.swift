//
//  PredatorRow.swift
//  JP Apex Predators
//
//  Created by Jimmy Ghelani on 2023-09-05.
//

import SwiftUI

struct PredatorRow: View {
    
    let predator: ApexPredator
    
    var body: some View {
        HStack {
            // Dinosaur image
            Image(predator.name.lowercased().filter {$0 != " "})
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(color: .white, radius: 1, x: 0, y: 0)
            VStack(alignment: .leading) {
                // NAME
                Text(predator.name)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accent)
                // TYPE
                Text(predator.type)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accent)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(predator.typeOverlay().opacity(0.33))
                    )
            }
        }
    }
}

struct PredatorRow_Previews: PreviewProvider {
    static let movieScene = MovieScene(id: 1, movie: "Jurrasic Park", sceneDescription: "Some Description")
    static var previews: some View {
        PredatorRow(predator: ApexPredator(id: 1, name: "Tyrannosaurus Rex", type: "air", movies: ["Jurrasic Park", "Jurrasic Park 3"], movieScenes: [movieScene], link: ""))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
