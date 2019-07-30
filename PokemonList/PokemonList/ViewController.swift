//
//  ViewController.swift
//  PokemonList
//
//  Created by Nazariy Vlizlo on 7/15/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Pokemon.loadPokemons { [weak self] object in
            self?.pokemons = object
            DispatchQueue.main.async {
                self?.pokemonTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PokemonTableViewCell.self), for: indexPath) as? PokemonTableViewCell
            else { return UITableViewCell() }
        cell.setupWith(pokemon: pokemons[indexPath.row])
        //cell.avatarImageView.frame.size.width = 144.5
        //cell.avatarImageView.frame.size.height = 72.5
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        
        let logo = UIImage(named: "pokemon-logo")
        let logoImageView = UIImageView(image: logo)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.frame.size = CGSize(width: logoImageView.frame.size.width, height: logoImageView.frame.size.height + 0.5)
        header.addSubview(logoImageView)
        return header
    }
}

private extension PokemonTableViewCell {
    func setupWith(pokemon: Pokemon) {
        avatarImageView.image = UIImage.init(named: pokemon.name)
        nameLabel.text = pokemon.name
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
        let img = UIImage.init(named: pokemon.name)
        // avatarImageView.image = img?.roundedImage(sizeToRound: avatarImageView.bounds.size)
        avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.shadowRadius = 30
        avatarImageView.layer.shadowOpacity = 0.25
        // let shadowPath = UIBezierPath(rect: avatarImageView.bounds)
        // avatarImageView.layer.shadowPath = shadowPath.cgPath
    }
}

extension UIView {
    func align() {
        frame = CGRect(x: CGFloat(ceilf(Float(frame.origin.x))), y: CGFloat(ceilf(Float(frame.origin.y))), width: CGFloat(ceilf(Float(frame.size.width))), height: CGFloat(ceilf(Float(frame.size.height))))
    }
}

extension UIImage {
    func roundedImage(sizeToRound: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: sizeToRound)
        
        UIGraphicsBeginImageContextWithOptions(sizeToRound, false, UIScreen.main.scale)
        UIGraphicsGetCurrentContext()?.addPath((UIBezierPath(roundedRect: rect, cornerRadius: sizeToRound.height / 2).cgPath))
        UIGraphicsGetCurrentContext()?.clip()
        
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

