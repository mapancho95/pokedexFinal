//
//  ViewController.swift
//  pokedexFinal
//
//  Created by Tafadzwa Mushamba on 17/08/2021.
//
import UIKit
import Kingfisher

class PokemonViewController: UIViewController {
    var url: String!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet weak var image1: UIImageView!
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPokemon()
        nameLabel.text = ""
        numberLabel.text = ""
        type1Label.text = ""
        type2Label.text = ""
    }
    func loadPokemon() {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(PokemonResult.self, from: data)
                DispatchQueue.main.async {
                    self.navigationItem.title = self.capitalize(text: result.name)
                    self.nameLabel.text = self.capitalize(text: result.name)
                    self.numberLabel.text = String(format: "#%03d", result.id)
                    let turl = URL(string: result.sprites.front_default)
                    self.image1.kf.setImage(with: turl!)
                    for typeEntry in result.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
}

