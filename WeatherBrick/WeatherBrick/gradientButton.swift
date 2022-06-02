//
//  gradientButton.swift
//  WeatherBrick
//
//  Created by Admin on 01.06.2022.
//  Copyright © 2022 VAndrJ. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
public func setGradient(colorOne: UIColor, colorTwo: UIColor) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = bounds
    gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    layer.insertSublayer(gradientLayer, at: 0)
}
}
