//
//  ContentView.swift
//  TapTapMiss
//
//  Created by Nathania Wiranda on 23/05/23.
//

import SwiftUI
import SpriteKit


protocol SquareGameLogicDelegate {
    var totalScore: Int { get }
    
    mutating func addPoint() -> Void
}

// 1. Conform the ContentView to the SquareLogicDelegate protocol
struct ContentView: View, SquareGameLogicDelegate {
    // 2. Implement the totalScore variable and add the @State property wrapper
    // so once it changes value the user interface updates too
    @State var totalScore: Int = 0
    
    mutating func addPoint() {
        self.totalScore += 1
    }
    
    var screenWidth: CGFloat { UIScreen.main.bounds.width }
    var screenHeight: CGFloat { UIScreen.main.bounds.height }

    var gameSceneWidth: CGFloat { screenWidth }
    var gameSceneHeight: CGFloat { screenHeight - 100 }
    
    var squareGameGameScene: SquareGameGameScene {
        let scene = SquareGameGameScene()
        
        scene.size = CGSize(width: gameSceneWidth, height: gameSceneHeight)
        scene.scaleMode = .fill
        
    // 3. Remember to assign your view as the gameLogicDelegate of your game scene
        scene.gameLogicDelegate = self
        
        return scene
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                SpriteView(scene: self.squareGameGameScene)
                    .frame(width: gameSceneWidth, height: gameSceneHeight)

            // 4. An use the totalScore property to show the updated score
                Text("Score: \(self.totalScore)")
                    .font(.headline).fontWeight(.bold)
                    .padding().background(Color.white).cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 4.0))
            }

        }
    }
}

struct GameSizes {
    static let squareSize: CGFloat = 40.0
}

class SquareGameGameScene: SKScene {
    var gameLogicDelegate: SquareGameLogicDelegate? = nil
    
    var latestMinXPosition = 0.0
    var latestMinYPosition = 0.0
    
    var background = SKSpriteNode()
    
    // array untuk simpan square
    var squares: [SquareModel] = []
    
    private var lastTimeSpawnedSquare: TimeInterval = 0.0
    
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        latestMinYPosition = self.frame.height
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.lastTimeSpawnedSquare == 0.0 { self.lastTimeSpawnedSquare = currentTime }
        let timePassed = currentTime - self.lastTimeSpawnedSquare
//        print("timePassed \(timePassed)")
        if timePassed >= 2 {
            self.spawnNewSquare()
            self.lastTimeSpawnedSquare = currentTime
//            print("lastTimeSpawnedSquare \(lastTimeSpawnedSquare)")
        }
    }
}

// MARK: - Setting up the game
extension SquareGameGameScene {
    private func setUpGame() {
            let backgroundTexture = SKTexture(imageNamed: "background") // Replace "yourBackgroundImageName" with the name of your image asset
            let backgroundNode = SKSpriteNode(texture: backgroundTexture)
            backgroundNode.position = CGPoint(x: size.width/2, y: size.height/2)
            backgroundNode.size = size
            backgroundNode.zPosition = -1 // Place the background behind other nodes

            addChild(backgroundNode)
        }
}

// MARK: - Handling Interaction
extension SquareGameGameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchPosition = touch.location(in: self)
        
//        if let selectedNode = nodes(at: touchPosition).first as? SKShapeNode {
//            self.destroy(selectedNode)
//            self.addPoint()
//        }
        
        if touchPosition.y <= self.frame.height / 3 {
            let selectedNode = self.squares.first!
           removeSquare(toBeDeleted: selectedNode)
            self.addPoint()
        }
    }
    
    func removeSquare(toBeDeleted: SquareModel) {
        // hapus dari tampilan
        self.destroy(toBeDeleted.square)
        // hapus dari gerbong (array)
        self.squares.remove(at: 0)
    }
}

// MARK: - Square Creation Dynamics
extension SquareGameGameScene {
    
    private func spawnNewSquare() {
        
        let createAfter1s  = SKAction.wait(forDuration: 0.9)
        let spawn = SKAction.run {
            let square = self.getNewSquare()
            square.square.position = self.getRandomPosition()
            print("spawnNewSquare")
            self.addChild(square.square)
            self.squares.append(square)
        }
        
        let action = SKAction.sequence([createAfter1s, spawn])
        let forever = SKAction.repeatForever(action)
        self.run(forever)
        
    }
    
    private func getRandomPosition() -> CGPoint {
        let screeWidth = self.frame.width
        
        
        latestMinXPosition = screeWidth / 2
        
    
        for i in 0..<self.squares.count {
            let sq = self.squares[i]
            sq.square.position.y -= GameSizes.squareSize
        }
        
        // if sudah ada squares yg ke-spawn
        if self.squares.count > 0 {
            // square pertama di gerbong 0
            var sq = self.squares[0]
            
            while sq.square.position.y <= 0 {
                removeSquare(toBeDeleted: sq)
                sq = self.squares[0]
            }
        }
        
        return CGPoint(x: latestMinXPosition, y: latestMinYPosition)
    }

    
    
        private func getNewSquare() -> SquareModel {
            let newSquare = SquareModel(square: SKSpriteNode(color: .red, size: CGSize(width: GameSizes.squareSize, height: GameSizes.squareSize)))

            // Modify the properties of the SKSpriteNode as needed
            newSquare.square.texture = SKTexture(imageNamed: "panda") // Set the image texture


            return newSquare
        }
    
}


// MARK: - Square Destruction Dynamics
extension SquareGameGameScene {
    private func destroy(_ square: SKSpriteNode) {
        square.removeFromParent()
    }
}

// MARK: - Score Dynamics
extension SquareGameGameScene {
    private func addPoint() {
        if var gameLogicDelegate = self.gameLogicDelegate {
            gameLogicDelegate.addPoint()
        }
    }
}
