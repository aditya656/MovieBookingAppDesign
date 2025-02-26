//
//  CustomRoundedCorner.swift
//  MovieBookingAppDesign
//
//  Created by Aditya Patole on 26/02/25.
//

import SwiftUI

struct CustomRoundedCorner: Shape {
    var cornerRadii: [(UIRectCorner, CGFloat)] // List of corners with respective radius
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        let topLeftRadius = cornerRadii.first(where: { $0.0 == .topLeft })?.1 ?? 0
        let topRightRadius = cornerRadii.first(where: { $0.0 == .topRight })?.1 ?? 0
        let bottomLeftRadius = cornerRadii.first(where: { $0.0 == .bottomLeft })?.1 ?? 0
        let bottomRightRadius = cornerRadii.first(where: { $0.0 == .bottomRight })?.1 ?? 0
        
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        
        // Top Line
        path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        if topRightRadius > 0 {
            path.addArc(withCenter: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius),
                        radius: topRightRadius,
                        startAngle: CGFloat(-90).toRadians(),
                        endAngle: CGFloat(0).toRadians(),
                        clockwise: true)
        }
        
        // Right Line
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        if bottomRightRadius > 0 {
            path.addArc(withCenter: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius),
                        radius: bottomRightRadius,
                        startAngle: CGFloat(0).toRadians(),
                        endAngle: CGFloat(90).toRadians(),
                        clockwise: true)
        }
        
        // Bottom Line
        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        if bottomLeftRadius > 0 {
            path.addArc(withCenter: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius),
                        radius: bottomLeftRadius,
                        startAngle: CGFloat(90).toRadians(),
                        endAngle: CGFloat(180).toRadians(),
                        clockwise: true)
        }
        
        // Left Line
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        if topLeftRadius > 0 {
            path.addArc(withCenter: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius),
                        radius: topLeftRadius,
                        startAngle: CGFloat(180).toRadians(),
                        endAngle: CGFloat(270).toRadians(),
                        clockwise: true)
        }
        
        path.close()
        return Path(path.cgPath)
    }
}

// Extension to convert degrees to radians
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180
    }
}
