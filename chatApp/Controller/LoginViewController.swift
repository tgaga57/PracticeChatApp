//
//  LoginViewController.swift
//  chatApp
//
//  Created by 志賀大河 on 2020/01/14.
//  Copyright © 2020 志賀大河. All rights reserved.
//

import UIKit
import Firebase
import Lottie

// UIViewcontrollerクラス
class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextfiled: UITextField!
    @IBOutlet weak var passwordTextfiled: UITextField!
    
    // ローディング画面のアニメーションの表示など
       let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        // アニメーション
        startAnimation()
        
        Auth.auth().signIn(withEmail: emailTextfiled.text!, password: passwordTextfiled.text!) { (user, error) in
            // エラーが存在しているなら
            if error != nil {
                
                print ("エラー")
                
            }else {
                
                print("ログイン成功")
                
                self.stopAnimation()
                // 遷移先に移動
                self.performSegue(withIdentifier: "chat", sender: nil)
            }
            
        }
    }
    

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
