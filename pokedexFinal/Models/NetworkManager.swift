//
//  NetworkManager.swift
//  pokedexFinal
//
//  Created by Tafadzwa Mushamba on 18/08/2021.
//

import Foundation


class NetworkManager{
    var pokemon: [PokemonListResult] = []
    
    func APICall(){
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let entries = try JSONDecoder().decode(PokemonListResults.self, from: data)
                return self.pokemon = entries.results
                
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
}

