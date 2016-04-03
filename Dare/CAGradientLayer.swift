//
//  GradientLayer.swift
//  Dare
//
//  Created by Ronald Bernal on 4/2/16.
//  Copyright © 2016 Ronald Bernal. All rights reserved.
//

import UIKit

extension CAGradientLayer{
    
    func blueColor() -> CAGradientLayer {
        
        let topColor = UIColor(red:(57/255.0), green:(144/255.0), blue:(202/255.0), alpha: 1)
        let bottomColor = UIColor(red:(21/255.0), green:(84/255.0), blue:(126/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]

        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
    }
}
