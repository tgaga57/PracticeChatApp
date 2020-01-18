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
    
    // 送信ボタン
    @IBOutlet weak var sendButton: UIButton!
    
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
        fetchChatData()
        
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
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        cell.messageLabel.text = chatArray[indexPath.row].message
        
        // ラベルの角を丸く
        cell.messageLabel.layer.cornerRadius = 20
        cell.messageLabel.layer.masksToBounds = true
        
        cell.userNameLabel.text = chatArray[indexPath.row].sender
        cell.iconImageView.image = UIImage(named: "Nohuman")
        

        // もしauthのCurentuser（自分）のemailアドレスだったら
        if cell.userNameLabel.text == Auth.auth().currentUser?.email as! String {
            // 色を決める
            cell.messageLabel.backgroundColor = UIColor.flatLime()
            
        }else{
            
            cell.messageLabel.backgroundColor = UIColor.flatPink()
            
        }
        
        return cell
        
    }
    
    // セルの高さを返すもの
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height / 10
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        // メッサージの入力が終わっているから
        messageTextFiled.endEditing(true)
        messageTextFiled.isEnabled = false
        sendButton.isEnabled = false
        
        if messageTextFiled.text!.count > 15 {
            print("十五文字以上ですよ")
            
            return
        }
        
        
        // 参照元を提示
        let chatDB = Database.database().reference().child("chats")
        
     //  キーバリュー型で内容を送信
        let messageInfo = ["sender":Auth.auth().currentUser?.email,"message":messageTextFiled.text!]
        
        // chatDBに入れる
        chatDB.childByAutoId().setValue(messageInfo) { (error,result) in
            
            if error != nil {
                print("エラーでした")
            }else {
               print("送信完了")
                self.messageTextFiled.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextFiled.text = ""
            }
            
        }
    }
    
    
    // データの受信　引っ張ってくるのか
    func fetchChatData() {
        
        // どこからデータを引っ張ってくるのか
        let fethchDataRef = Database.database().reference().child("chats")
        
        // 新しい更新があったときだけ取得したい取得したい
        fethchDataRef.observe(.childAdded) { (snapShot) in
            
            let snapShotData = snapShot.value as! AnyObject
            let text = snapShotData.value(forKey: "message")
            let sender = snapShotData.value(forKey: "sender")
            
            let message = Message()
            message.message = text as! String
            message.sender = sender as! String
            
            self.chatArray.append(message)
            self.tableView.reloadData()
            
            
        }
    }
    
    
    
    
}
