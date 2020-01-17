//
//  Animation.swift
//  chatApp
//
//  Created by 志賀大河 on 2020/01/14.
//  Copyright © 2020 志賀大河. All rights reserved.
//

import Foundation
import Lottie

class Animation {
   
    // アニメーションのメソッド作り
       // start
       func startAnimation() {
           
           let animation = Animation.named("loading")
           // loadingのデザイン
           animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/1.5)
           
           animationView.animation = animation
           animationView.contentMode = .scaleAspectFit
           // アニメーションのループ
           animationView.loopMode = .loop
           // loadingの再生
           animationView.play()
           
           view.addSubview(animationView)
           
       }
       
       //　アニメーション
       // stop
       func stopAnimation() {
           // アニメーションを排除する
           animationView.removeFromSuperview()
       }
       
    
}
