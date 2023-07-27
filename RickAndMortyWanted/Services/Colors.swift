//
//  Colors.swift
//  RickAndMortyWanted
//
//  Created by Iago on 24/07/23.
//

import SwiftUI

extension Color {
    func brightness() -> Double {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, opacity: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
        return (0.299 * Double(red) + 0.587 * Double(green) + 0.114 * Double(blue))
    }
}

struct ColorService {
    
    static var gradients: [LinearGradient] = getGradients()
    
    static func randomColor() -> Color {
        var randomColor: Color
        repeat {
            let red = Double.random(in: 0...1)
            let green = Double.random(in: 0...1)
            let blue = Double.random(in: 0...1)
            randomColor = Color(red: red, green: green, blue: blue)
        } while randomColor.brightness() > 0.8
        
        return randomColor
    }
    
    static  func createGradient() -> LinearGradient {
        let primaryColor = ColorService.randomColor()
        let darkColor = primaryColor.opacity(0.5)
        return LinearGradient(gradient: Gradient(colors: [primaryColor, darkColor]), startPoint: .leading, endPoint: .trailing)
        
    }
    
    static func getGradients() -> [LinearGradient] {
        var randomGradients: [LinearGradient] = []
            for _ in 1...DimensionType.count {
                let gradient = createGradient()
                randomGradients.append(gradient)
            }
        return randomGradients
    }
    
   static func gradientByDimensionType(locationType: String) -> LinearGradient {
        guard let type = DimensionType(rawValue: locationType) else {
            return gradients[0]
        }
        let index = type.rawValue.hashValue % ColorService.gradients.count
        return index >= 0 ? gradients[index] : gradients[-index]
    }
}
