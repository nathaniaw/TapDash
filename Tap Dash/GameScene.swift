//
//  GameScene.swift
//  TapTapMiss
//
//  Created by Nathania Wiranda on 23/05/23.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    var gameView: GameView!
    var circleLeft = SKSpriteNode()
    var circleRight = SKSpriteNode()
    
    // array untuk simpan square
    var squares: [SquareModel] = []
    let squareSize: CGFloat = 40.0
    
    var background = SKSpriteNode()
    
    
    let gameover = SKSpriteNode (imageNamed: "gameover")
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.spawnNewSquare(interval: 0.5)
        self.addTapSection()
        
        let background = SKSpriteNode(imageNamed: "Background")
        background.zPosition = -1
        
        if let sceneView = self.view {
            let centerPoint = CGPoint(x: sceneView.bounds.midX, y: sceneView.bounds.midY)
            let convertedCenterPoint = self.convertPoint(fromView: centerPoint)
            background.position = convertedCenterPoint
        }
        
        addChild(background)
    }

    
    override func update(_ currentTime: TimeInterval) {
        if !gameView.gameOver{
            for i in 0..<squares.count {
                squares[i].update()
            }
        }
        if squares.count > 0 && squares[0].square.position.y <= 0 {
            //            squares[0].square.removeFromParent()
            //            squares.remove(at: 0)
            //            print("KO")
            gameView.gameOver = true
            
            gameover.run(SKAction.move(to: CGPoint(x: 197, y: 300), duration: 0.01))
            
            
            
        }
        
    }
}

// MARK: - Setting up the game
extension GameScene {
    func setUpGame() {
        backgroundColor = SKColor.white
    }
}

// MARK: - Handling Interaction
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if !gameView.gameOver {
            let touchPosition = touch.location(in: self)
            let tappedNode = atPoint(touchPosition)
            if tappedNode == circleLeft {
                let selectedNode = self.squares.first
                if let selectedNode {
                    if selectedNode.square.name == "Panda"{
                        removeSquare(toBeDeleted: selectedNode)
                        self.addPoint()
                    }else{
                        if gameView.totalScore > 0{
                            gameView.totalScore -= 1
                        }
                    }
                }
            }else if tappedNode == circleRight {
                let selectedNode = self.squares.first
                if let selectedNode {
                    if selectedNode.square.name == "Giraffe"{
                        removeSquare(toBeDeleted: selectedNode)
                        self.addPoint()
                    }else{
                        if gameView.totalScore > 0{
                            gameView.totalScore -= 1
                        }
                    }
                }
            }
            
        }
    }
    
    func removeSquare(toBeDeleted: SquareModel) {
        // hapus dari tampilan
        toBeDeleted.square.removeFromParent()
        // hapus dari gerbong (array)
        self.squares.remove(at: 0)
    }
}


// MARK: - Square Creation Dynamics
extension GameScene {
    
    private func spawnNewSquare(interval: Double) {
        var spawnInterval  = SKAction.wait(forDuration: interval)
        
        self.removeAllActions()
        
        
        let spawn = SKAction.run {
            let square = self.getNewSquare()
            self.updateSquarePositions()
            
            
            self.addChild(square.square)
            //            self.addChild(SKSpriteNode(texture: SKTexture(image: UIImage(named: "")!)))
            self.squares.append(square)
        }
        
        let action = SKAction.sequence([spawnInterval, spawn])
        let forever = SKAction.repeatForever(action)
        self.run(forever)
    }
    
    
    private func getNewSquare() -> SquareModel {
        var random = Bool.random()
        
        // Create an SKSpriteNode instead of SKShapeNode
        let squareNode: SKSpriteNode
        
        if random {
            squareNode = SKSpriteNode(imageNamed: "panda")
            squareNode.name = "Panda"
        } else {
            squareNode = SKSpriteNode(imageNamed: "giraffe")
            squareNode.name = "Giraffe"
        }
        
        // Adjust the size of the squareNode
        let desiredSize = CGSize(width: 75, height: 75)
        let scale = min(desiredSize.width / squareNode.size.width, desiredSize.height / squareNode.size.height)
        squareNode.scale(to: CGSize(width: squareNode.size.width * scale, height: squareNode.size.height * scale))
        
        squareNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        
        // Assign a higher zPosition value to make the new square overlap existing squares
        squareNode.zPosition = 5
        
        let newSquare = SquareModel(square: squareNode, targetYPosition: nil)
        
        return newSquare
    }


    
    
    private func updateSquarePositions() {
        for i in 0..<self.squares.count {
            self.squares[i].targetYPosition = self.squares[i].square.position.y - squareSize
        }
        
        if gameView.totalScore == 10 {
            spawnNewSquare(interval: 0.3)
        } else if gameView.totalScore == 25 {
            spawnNewSquare(interval: 0.25)
        } else if gameView.totalScore == 50 {
            spawnNewSquare(interval: 0.22)
        } else if gameView.totalScore == 75 {
            spawnNewSquare(interval: 0.20)
        } else if gameView.totalScore == 100 {
                    spawnNewSquare(interval: 0.17)
            }
    }
}

// MARK: - Score Dynamics
extension GameScene {
    private func addPoint() {
        gameView.totalScore += 1
    }
}

// MARK: - Tap Section
extension GameScene {
    private func addTapSection() {
        circleLeft = SKSpriteNode(imageNamed: "buttonPanda")
        
        circleLeft.position = CGPoint(x: size.width*1/5, y: size.height/10)
        self.addChild(circleLeft)
        
        circleRight = SKSpriteNode(imageNamed: "buttonGiraffe")
        
        circleRight.position = CGPoint(x: size.width*4/5, y: size.height/10)
        self.addChild(circleRight)
        
        
    }
}

