//
//  ViewController.swift
//  PokemonList
//
//  Created by Nazariy Vlizlo on 7/15/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let logoOffsetHeight: CGFloat = 0
        static let tableHeaderHeight: CGFloat = 150
		static let tableFooterHeight: CGFloat = 1000
		
		static let headerOrigin = CGPoint(x: 0.1, y: 0.1)
    }
    
	@IBOutlet weak var pokemonTableView: UITableView!
	
	var pokemons = [Pokemon]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadPokemons()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.tableHeaderHeight
    }
	
	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return Constants.tableFooterHeight
	}
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let logo = UIImage(named: "pokemon-logo")
        let logoImageView = UIImageView(image: logo)
        logoImageView.contentMode = .scaleAspectFit
		logoImageView.frame.size = headerSize(logoImageView.frame.size)
		logoImageView.frame.origin = Constants.headerOrigin
        logoImageView.isOpaque = true
        
        let header = UIView()
        header.addSubview(logoImageView)
        return header
    }
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let footerImage = footerImage()
		let footer = UIView()
		
		let imageView = UIImageView(image: footerImage)
		imageView.frame.size = .init(width: UIScreen.main.bounds.width, height: Constants.tableFooterHeight)
		footer.addSubview(imageView)
		return footer
	}
}

private extension PokemonTableViewCell {
    func setupWith(pokemon: Pokemon) {
        avatarImageView.layer.masksToBounds = true
        var image = UIImage.init(named: pokemon.name)
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height / 2
        avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
        avatarImageView.layer.borderWidth = 2
                
        avatarImageView.layer.shadowRadius = 30
        avatarImageView.layer.shadowOpacity = 0.25
        
        avatarImageView.image = image
        nameLabel.text = pokemon.name
    }
}

private extension ViewController {
	func loadPokemons() {
		Pokemon.loadPokemons { [weak self] object in
			self?.pokemons = object
			DispatchQueue.main.async {
				self?.pokemonTableView.reloadData()
			}
		}
	}
	
	func footerImage() -> UIImage {
		let imageName = "footer.jpg"
		let path = Bundle.main.path(forResource: imageName, ofType: nil)
		let image: UIImage = .init(contentsOfFile: path!)!
		return image.optimizeSize(size: .init(width: UIScreen.main.bounds.width, height: 200))!
	}
	
	func headerSize(_ size: CGSize) -> CGSize {
		return .init(width: size.width, height: size.height + Constants.logoOffsetHeight)
	}
}
