//
//  SquareModel.swift
//  TapTapMiss
//
//  Created by Nathania Wiranda on 23/05/23.
//

import Foundation
import SpriteKit


struct SquareModel: Identifiable, Hashable {
    let id = UUID()
    let square: SKSpriteNode  // Change the type to SKSpriteNode
    let moveSpeed = 0.5
    var targetYPosition: Double?

    func update() {
        if let targetPos = targetYPosition {
            if square.position.y > CGFloat(targetPos) {
                square.position.y = square.position.y * (1-moveSpeed) + CGFloat(targetPos) * (moveSpeed)
            }
        }
    }
}
