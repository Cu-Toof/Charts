//
//  Platform+Gradient.swift
//  Charts
//
//  Created by Toof on 11/30/19.
//

#if canImport(UIKit)
public struct NSUIGradient {
    let gradientStart: CGPoint
    let gradientEnd: CGPoint
    let gradient: CGGradient
    
    public static func create(
        gradientPositions: [CGFloat]?,
        colors: [NSUIColor],
        boundingBox: CGRect,
        matrix: CGAffineTransform) -> NSUIGradient? {
        guard let gradientPositions = gradientPositions else {
            assertionFailure("Must set `gradientPositions if `dataSet.drawBarGradientEnabled` is true")
            return nil
        }
        
        let gradientStart = CGPoint(x: boundingBox.minX, y: boundingBox.minY)
        let gradientEnd = CGPoint(x: boundingBox.minX, y: boundingBox.maxY)
        var gradientColorComponents: [CGFloat] = []
        var gradientLocations: [CGFloat] = []
        
        for position in gradientPositions.reversed() {
            let location = CGPoint(x: boundingBox.minX, y: position).applying(matrix)
            let normalizedLocation = (location.y - boundingBox.minY) / (boundingBox.maxY - boundingBox.minY)
            switch normalizedLocation {
            case ..<0:
                gradientLocations.append(0)
            case 0..<1:
                gradientLocations.append(normalizedLocation)
            case 1...:
                gradientLocations.append(1)
            default:
                break
            }
        }
        
        for color in colors.reversed() {
            guard let (r, g, b, a) = color.nsuirgba else { continue }
            gradientColorComponents += [r, g, b, a]
        }
        
        let baseColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(
            colorSpace: baseColorSpace,
            colorComponents: &gradientColorComponents,
            locations: &gradientLocations,
            count: gradientLocations.count) else { return nil }
        
        return NSUIGradient(
            gradientStart: gradientStart,
            gradientEnd: gradientEnd,
            gradient: gradient)
    }
}
#endif
