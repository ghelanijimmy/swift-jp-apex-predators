//
//  PredatorDetail.swift
//  JP Apex Predators
//
//  Created by Jimmy Ghelani on 2023-09-05.
//

import SwiftUI

struct PredatorDetail: View {
    let predator: ApexPredator
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type)
                        .resizable()
                        .scaledToFit()

                    
                    NavigationLink {
                        Image(predator.name.lowercased().filter {$0 != " "})
                            .resizable()
                            .scaledToFit()
                    } label: {
                        Image(predator.name.lowercased().filter {$0 != " "})
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 4)
                            .shadow(color: .black, radius: 6, x: 0, y: 0)
                            .rotation3DEffect(
                                .degrees(180),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }

                }
                
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                        .padding(.bottom, 8)
                    
                    Text("Appears in:")
                        .font(.title3)
                    
                    ForEach(predator.movies, id: \.self) {movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) {scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding([.top, .bottom], 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    
                    if let url = URL(string: predator.link) {
                        Text("Read More:")
                            .font(.caption)
                        Link(predator.link, destination: url)
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                }
                .padding()
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let movieScene = MovieScene(id: 3, movie: "Jurrasic Park III", sceneDescription: "The Velociraptors appear once again towards the end of The Lost World. When Roland’s team escape the Tyrannosaurus at their camp, they wonder into the tall grass. The raptors close in on them and start picking the team off one by one. Dr. Malcolm, Kelly and Sarah make it to the compound in the middle of the island. One of the raptors jumps on Sarah’s backpack and Sarah and Kelly flee into a nearby building with two raptors in pursuit. Malcolm tires to evade the other one by hiding in a nearby building and then inside a car. The other two velociraptors make it inside the building and Sarah and Kelly climb to the top. Kelly uses her acrobatic skills to impale a raptor on a metal pole. They escape through the top of the building with the other one right behind them. It falls off the roof and onto the other raptor on the ground. They start fighting each other which gives Sarah and Kelly the opportunity to escape.")
    let predator = ApexPredator(id: 1, name: "Tyrannosaurus Rex", type: "land", movies: ["Jurrasic Park III"], movieScenes: [movieScene, movieScene], link: "https://google.ca")
    return NavigationStack {
        PredatorDetail(predator: predator)
            .preferredColorScheme(.dark)
    }
}
