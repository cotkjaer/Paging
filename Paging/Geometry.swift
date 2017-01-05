//
//  Geometry.swift
//  Paging
//
//  Created by Christian Otkjær on 05/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import Foundation


func + (lhs: CGSize, rhs: CGSize) -> CGSize
{
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint
{
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint
{
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

// MARK: - <#comment#>

extension CGPoint
{
    var magnitude: CGFloat { return sqrt(x*x + y*y) }
}

// MARK: - center

extension CGRect
{
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}
