//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Oron Ben Zvi on 04/02/2016.
//  Copyright © 2016 Oron Ben Zvi. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextImgEvo: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvoImg.image = img
        
        setUIAlpha(0)
        
        pokemon.downloadPokemonDetails {
            // download is done
            self.updateUI()
        }
    }
    
    func setUIAlpha(alpha: CGFloat) {
        descriptionLbl.alpha = alpha
        typeLbl.alpha = alpha
        defenseLbl.alpha = alpha
        heightLbl.alpha = alpha
        weightLbl.alpha = alpha
        pokedexIdLbl.alpha = alpha
        baseAttackLbl.alpha = alpha
        currentEvoImg.alpha = alpha
        nextImgEvo.alpha = alpha
        evoLbl.alpha = alpha
    }
    
    func fadeInUI() {
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations: {
                self.setUIAlpha(1)
            }, completion: nil)
    }
    
    func updateUI() {
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        baseAttackLbl.text = "\(pokemon.baseAttack)"
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextImgEvo.hidden = true
        } else {
            nextImgEvo.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionName)"
            if pokemon.nextEvolutionLevel != "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            evoLbl.text = str
        }
        fadeInUI()
    }

    @IBAction func backBtnClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
