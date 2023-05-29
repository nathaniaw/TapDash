//
//  StartingView.swift
//  TapTapMiss
//
//  Created by Nathania Wiranda on 24/05/23.
//

import SwiftUI
import AVFoundation
struct StartingView: View {
//    var audio = AudioManager()
    var body: some View {
        NavigationStack {
            ZStack {
                
                
//                Color("Blue")
//                    .ignoresSafeArea()
                Image ("startingPage")
                    .ignoresSafeArea()
//                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.5)
                Image ("game instruction")
                
                
                
                // untuk belajar dari icho
                //            Button(action: {
                //            Button{
                //                // action dari button
                //            }label: {
                //                HStack{
                //                    Image("Restart_button")
                //                        .resizable()
                //                        .frame(width: 30, height: 30)
                //                    Text("Take picture")
                //                }
                //            }
                
                VStack {
                    Spacer()
                    NavigationLink
                    {
                        GameView()
                    } label: {
                        Text("Start")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(30)
                            .frame(maxWidth: 250, maxHeight: 32)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Brown"))
                    .cornerRadius(20)
                    .padding(.bottom,80)
                    .shadow(color: .gray, radius: 4, x: 2, y: 4)
                }
                
            }
             .navigationBarBackButtonHidden(true)
             .onAppear{
                 AudioManager.instance.playSound()
             }
        }
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}


class AudioManager{
    static let instance = AudioManager()
    var player: AVAudioPlayer!

    func playSound(){
        guard let url = Bundle.main.url(forResource: "backgroundSound", withExtension: "mp3") else { return }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.play()
            player.volume = 1
        } catch{
            print("error")
        }
    }
}
