//
//  ChatViewController.swift
//  chatApp
//
//  Created by 志賀大河 on 2020/01/14.
//  Copyright © 2020 志賀大河. All rights reserved.
//

import UIKit
import ChameleonFramework // 色あいのフレームワーク
import Firebase

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    // tableView
    @IBOutlet weak var tableView: UITableView!
    // messagetext
    @IBOutlet weak var messageTextFiled: UITextField!
    
    
    //　スクリーンのサイズ
    let screenSize = UIScreen.main.bounds.size
    
    var chatArray = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // このtableViewControllerで使うことを表記
        tableView.delegate = self
        tableView.dataSource = self
        
        // viewcontrollerクラスのこと
        messageTextFiled.delegate = self
        
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedRowHeight = 44
        
        // キーボード出てくるときに発動
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // キーボード閉じるときに発動
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // firebaseからデータをfetchしてくる(取得のこと)
        
    }
    
    //
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        let keyboardHeight = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        
        messageTextFiled.frame.origin.y = screenSize.height - keyboardHeight - messageTextFiled.frame.height
        
    }
    
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        
        messageTextFiled.frame.origin.y = screenSize.height - messageTextFiled.frame.height
        
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{return}
        
        UIView.animate(withDuration: duration) {
            
            let transform = CGAffineTransform(translationX: 0, y: 0)
            
            self.view.transform = transform
        }
        
    }
    
    // キーボードをタッチで閉じるのとリターンキーを押したら閉じる機能の追加
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        messageTextFiled.resignFirstResponder()
    }
    
    
//    becomeFirstResponder はキーボード出すとき
    // リターンキーを押したら閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

    
    //　メッセージの数を教えるメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        // メッセージの数　チャットの数を返す
        return chatArray.count
    }
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    //セルの数だけ呼び出される
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.messageLabel.text = chatArray[indexPath.row].message
        cell.userNameLabel.text = chatArray[indexPath.row].sender
        cell.iconImageView.image = UIImage(named: "Nohuman")
        
        // 色を決める
        cell.messageLabel.backgroundColor = UIColor.flatLime()
        
        if cell.userNameLabel.text == Autho
        
        return cell
        
    }
    
    
}
