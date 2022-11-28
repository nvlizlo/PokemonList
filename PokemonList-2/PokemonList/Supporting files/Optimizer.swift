//
//  Optimizer.swift
//  PokemonList
//
//  Created by Nazariy Vlizlo on 8/4/19.
//  Copyright © 2019 Nazariy Vlizlo. All rights reserved.
//

import UIKit

extension UIView {
    func align() {
        let newRect = CGRect(x: ceil(Double(frame.origin.x)),
                             y: ceil(Double(frame.origin.y)),
                             width: ceil(Double(frame.size.width)),
                             height: ceil(Double(frame.size.height)))
        frame = newRect
    }
    
    func addShadowPath() {
        let path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 15)
        layer.shadowPath = path.cgPath
    }
}

extension UIImage {
    func optimizeImage(alpha: CGFloat = 1.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func optimizeSize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let updated = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return updated
    }
}

extension UIImage {
	func redraw() -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: size)
		return renderer.image { context in
			draw(at: .zero)
		}
	}
}

extension UIImage {
    func roundedImage(sizeToRound: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: sizeToRound)
        
        UIGraphicsBeginImageContextWithOptions(sizeToRound, false, UIScreen.main.scale)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: sizeToRound.height)
        UIGraphicsGetCurrentContext()?.addPath(path.cgPath)
        UIColor.white.setFill()
        path.fill()
        UIGraphicsGetCurrentContext()?.clip()
        
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
