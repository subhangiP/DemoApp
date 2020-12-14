//
//  DashboardVC.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 14/12/20.
//

import UIKit

class DashboardVC: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtViewMessage: UITextView!
    @IBOutlet weak var tfSecretKey: UITextField!
    @IBOutlet weak var lblEncryptedKey: UILabel!
    @IBOutlet weak var btnDecrypt: UIButton!
    @IBOutlet weak var btnEncrypt: UIButton!
    
    var toDoListVC: ToDoListVC?
    var stopWatchVC: StopWatchVC?
    var dashboardVC: DashboardVC?
    var isEncrypted = false
    var encryptedMsg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.navigationItem.title = "\(self.setLanguageChange(stringKey: LocalizableString.Welcome.rawValue)) \(UserDefaults.standard.value(forKey: defaultsKeys.name) as? String ?? "")"
        txtViewMessage.text = self.setLanguageChange(stringKey: LocalizableString.Message.rawValue)
        txtViewMessage.textColor = UIColor.lightGray
        initialSetUp()
    }
    
    private func initialSetUp(){
        btnDecrypt.alpha = 0.5
        btnDecrypt.isUserInteractionEnabled = false
        btnDecrypt.setTitle(self.setLanguageChange(stringKey: LocalizableString.Decrypt.rawValue), for: .normal)
        btnEncrypt.setTitle(self.setLanguageChange(stringKey: LocalizableString.Encrypt.rawValue), for: .normal)
        tfSecretKey.placeholder = self.setLanguageChange(stringKey: LocalizableString.Secret_Key.rawValue)
    }
    //  MARK: -  BUtton Action
    @IBAction func btnDecryptClicked(_ sender: UIButton) {
        do {
            let decryptedMsg = try decryptMessage(encryptedMessage: encryptedMsg, encryptionKey: tfSecretKey.text ?? "")
            lblEncryptedKey.text = decryptedMsg
            //lblEncryptedKey.sizeToFit()
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    @IBAction func btnEncryptClicked(_ sender: UIButton) {
        if validateText().0 {
            btnDecrypt.alpha = 1.0
            btnDecrypt.isUserInteractionEnabled = true
            do {
                encryptedMsg = try encryptMessage(message: txtViewMessage.text, encryptionKey: tfSecretKey.text ?? "")
                lblEncryptedKey.text = encryptedMsg
                print("encryptedMsg")
               // lblEncryptedKey.sizeToFit()
            } catch let error{
                print(error.localizedDescription)
            }
        } else {
            self.displayAlert(msg: validateText().1)
        }
    }
    
    func encryptMessage(message: String, encryptionKey: String) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }
    
    func decryptMessage(encryptedMessage: String, encryptionKey: String) throws -> String {
        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
        return decryptedString
    }
    
    private func validateText() -> (Bool, String) {
        var success = false
        var errorMsg = ""
        if !(txtViewMessage.text.count > 0) {
            errorMsg = "Enter Message"
        } else if !(tfSecretKey.text?.count ?? 0 > 0) {
            errorMsg = "Enter secret key"
        } else {
            success = true
        }
        return (success, errorMsg)
    }
}
extension DashboardVC: UITabBarDelegate {
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            if dashboardVC == nil {
                dashboardVC = self.storyboard?.instantiateViewController(identifier: "DashboardVC") as? DashboardVC
            }
            self.view.insertSubview((dashboardVC?.view)!, belowSubview: tabBar)
            initialSetUp()
        case 2:
            if toDoListVC == nil {
                toDoListVC = self.storyboard?.instantiateViewController(identifier: "ToDoListVC") as? ToDoListVC
            }
            mainView.isHidden = true
            self.view.insertSubview((toDoListVC?.view)!, belowSubview: tabBar)
        case 3:
            if stopWatchVC == nil {
                stopWatchVC = self.storyboard?.instantiateViewController(identifier: "StopWatchVC") as? StopWatchVC
            }
            mainView.isHidden = true
            self.view.insertSubview((stopWatchVC?.view)!, belowSubview: tabBar)
        default:
            break
        }
    }
    
}
//  MARK: - UITextField Delegate
extension DashboardVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//Mark: - TextView Delegate
extension DashboardVC: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = self.setLanguageChange(stringKey: LocalizableString.Secret_Key.rawValue)
            textView.textColor = UIColor.lightGray
        }
    }
}
