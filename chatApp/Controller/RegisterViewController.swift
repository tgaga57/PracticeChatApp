//
//  RegisterViewController.swift
//  chatApp
//
//  Created by 志賀大河 on 2020/01/14.
//  Copyright © 2020 志賀大河. All rights reserved.
//

import UIKit
import Firebase
import Lottie

class RegisterViewController: UIViewController {

    
    // email
    @IBOutlet weak var emailTextFiled: UITextField!
    // password
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    // ローディング画面のアニメーションの表示など
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 新規登録　Firebaseにユーザーを登録する
    @IBAction func registerNewUser(_ sender: Any) {
        
        // animationのスタート
        startAnimation()
        // 新規登録を行う
        Auth.auth().createUser(withEmail: emailTextFiled.text!, password: passwordTextFiled.text!) { (user, error) in
            //  引数　User,errorのどちらかが呼ばれたら
            //  このカッコ内の処理がされる
            
            if error != nil { // errorがnil出ないなら
                
                print(error as Any)
                
            }else{ // isnot error
                print("ユーザーの作成が行われました")
                
                // animationのストップ
                // クロージャー内(メソッドの中に)にもう一つメソッドがあるからselfが必要
                // 自分自身のメソッドということ
                self.startAnimation()
                
                // 画面をチャット画面に遷移させる
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
