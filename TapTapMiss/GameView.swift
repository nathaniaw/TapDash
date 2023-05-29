//
//  GameView.swift
//  TapTapMiss
//
//  Created by Nathania Wiranda on 23/05/23.
//

import SwiftUI
import SpriteKit


struct GameView: View {
    @State var totalScore: Int = 0
    @State var gameOver : Bool = false
    
//    var backsoundStart: AVAu÷ioPlayer?
    var gameSceneWidth: CGFloat { UIScreen.main.bounds.width }
    var gameSceneHeight: CGFloat { UIScreen.main.bounds.height - 100 }
    
    var scene: SKScene {
        let scene = GameScene()
        //        scene.size = CGSize(width:500 , height: 500)/
        scene.scaleMode = .resizeFill
        scene.gameView = self
        
        return scene
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                if gameOver == true{
                }
                
                else{
                    
                    SpriteView(scene: self.scene)
                        .frame(width: .infinity, height: .infinity)
                        .ignoresSafeArea(.all)
                        .onAppear{
//                            playBackgroundSound()
                            
                        }
                    //                    Image("Background")
                    
                    
                    Text( gameOver ? "Game Over" : "Score: \(self.totalScore)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 4.0))
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $gameOver){
                GameOverScene(totalScore: $totalScore)
            }
        }
        
        
    }
    
    
        
}

struct GameView_Previews: PreviewProvider{
    static var previews: some View{
        GameView()
    }
}
