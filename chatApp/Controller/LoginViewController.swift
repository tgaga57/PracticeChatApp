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

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextfiled: UITextField!
    @IBOutlet weak var passwordTextfiled: UITextField!
    
    // ローディング画面のアニメーションの表示など
       let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
    }
    
}
