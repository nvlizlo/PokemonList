//
//  Pokemon.swift
//  PokemonList
//
//  Created by Nazariy Vlizlo on 7/15/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import Foundation

typealias LoadPokemonsCallback = ([Pokemon]) -> Void

struct Pokemon: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case names = "name"
    }
    
    let id: Int
    var names: [String: String]
    
    var name: String {
        return names["english"] ?? ""
    }
}

extension Pokemon {
    static func loadPokemons(callback: @escaping LoadPokemonsCallback) {
        DispatchQueue.global(qos: .background).async {
            do {
                guard let path = Bundle.main.path(forResource: "pokedex", ofType: "json") else { return }
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let object = try decoder.decode([Pokemon].self, from: data)
                callback(object)
            } catch {
                print(error)
            }
        }
    }
}
