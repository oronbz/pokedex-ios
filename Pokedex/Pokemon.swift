//
//  Pokemon.swift
//  Pokedex
//
//  Created by Oron Ben Zvi on 04/02/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    var name: String!
    var pokedexId: Int!
    var description: String!
    var type: String?
    var defense: String?
    var height: String?
    var weight: String?
    var baseAttack: String?
    var nextEvolutionText: String?
    var pokemonUrl: String!
    
    init(name: String, pokedexId: Int) {
        self.name = name
        self.pokedexId = pokedexId
        
        pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        Alamofire.request(.GET, pokemonUrl).responseJSON { response in
            let result = response.result
            if let dict = result.value as? [String: AnyObject] {
                if let height = dict["height"] as? String {
                    self.height = height
                }
                if let weight = dict["weight"] as? String {
                    self.weight = weight
                }
                if let attack = dict["attack"] as? Int {
                    self.baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self.defense = "\(defense)"
                }
                if let types = dict["types"] as? [[String: String]] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self.type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for index in 1..<types.count {
                            if let name = types[index]["name"] {
                                self.type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self.type = ""
                }
                
                print(self.height)
                print(self.weight)
                print(self.baseAttack)
                print(self.defense)
                print(self.type)
            }
        }
    }
}
