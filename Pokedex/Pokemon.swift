//
//  Pokemon.swift
//  Pokedex
//
//  Created by Oron Ben Zvi on 04/02/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
