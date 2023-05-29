//
//  GameOverScene.swift
//  TapTapMiss
//
//  Created by Nathania Wiranda on 24/05/23.
//

import SwiftUI

struct GameOverScene: View {
    @Binding var totalScore: Int
    var body: some View {
        ZStack {
            
            Image("Background")
            
            Rectangle()
                .opacity(0.25)

            
            
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: 300, maxHeight: 300)
                        .padding(.top, 100)
                    .foregroundColor(.white)
                    
                    VStack {
                        Text("You have fed")
                            .font(.title)
                            .bold()
                            .foregroundColor(.gray)
                            .padding(.top, 90)
                        .buttonStyle(.borderedProminent)
                        
                        Text("\(totalScore)")
                            .font(.system(size: 110))
                            .foregroundColor(Color("scoreBrown"))
                            .bold()
                            .padding(.all, 5)
                            .tint(Color("Brown"))
                        .buttonStyle(.borderedProminent)
                        
                        Text("animals")
                            .font(.title)
                            .foregroundColor(.gray)
                            .bold()
//                            .padding(.top, 100)
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                
                
                Spacer()
                
                ZStack {
                    
                }
                
                NavigationLink{
                    GameView()
                } label: {
                    Text("Retry")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: 150, maxHeight: 50)
                    
                        .buttonStyle(.borderedProminent)
                        .background(Color("Brown"))
                    //                        .padding(.top,16)
                }
                .cornerRadius(10)
                .padding(.bottom, 20)
                .shadow(color: .gray, radius: 4, x: 2, y: 4)
                
                //text
                NavigationLink{
                    StartingView()
                } label: {
                    Text("Quit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: 150, maxHeight: 50)
                        .shadow(color: .gray, radius: 4, x: 2, y: 4)
                    
                        .buttonStyle(.borderedProminent)
                        .background(Color("quitColor"))
//                        .tint(Color("quitColor")
                        .background(Color.blue)
                    //                        .padding(.top,30)
                    
                }.cornerRadius(10)
                    .padding(.bottom, 200)
                    .shadow(color: .gray, radius: 4, x: 2, y: 4)
            }
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
        
    
    
}
struct GameOverScene_Previews: PreviewProvider{
    static var previews: some View{
        GameOverScene(totalScore: .constant(0))
    }
}


