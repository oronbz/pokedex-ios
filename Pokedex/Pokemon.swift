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
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    var description: String {
        if _description == nil {
            _description =  ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var baseAttack: String {
        if _baseAttack == nil {
            _baseAttack = ""
        }
        return _baseAttack
    }
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    init(name: String, pokedexId: Int) {
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(_pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        Alamofire.request(.GET, _pokemonUrl).responseJSON { response in
            let result = response.result
            if let dict = result.value as? [String: AnyObject] {
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [[String: String]] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for index in 1..<types.count {
                            if let name = types[index]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                if let descArr = dict["descriptions"] as? [[String: String]] where descArr.count > 0 {
                    if let url = descArr[descArr.count - 1]["resource_uri"] {
                        Alamofire.request(.GET, "\(URL_BASE)\(url)").responseJSON { response in
                            if let descDict = response.result.value as? [String:AnyObject] {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self.description)
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                if let evolutions = dict["evolutions"] as? [[String:AnyObject]] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        // doesn't support mega pokemon right now
                        if !to.containsString("mega") {
                            // uri is formatted /api/v1/pokemon/[ID]/
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let num = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "").stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = num
                                self._nextEvolutionName = to
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }
                                print(self.nextEvolutionId)
                                print(self.nextEvolutionName)
                                print(self.nextEvolutionLevel)
                            }
                        }
                    }
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
