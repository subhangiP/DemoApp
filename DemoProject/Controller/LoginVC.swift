//
//  LoginVC.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 13/12/20.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {

    @IBOutlet weak var btnGoogleSignIN: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Login"
        GIDSignIn.sharedInstance()?.clientID = "112197673450-rug53ad7blp4jlbnlmlbnq4gm2b76ffp.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    
}
extension LoginVC: GIDSignInDelegate{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            UserDefaults.standard.set(user.profile.email, forKey: defaultsKeys.emailId)
            UserDefaults.standard.set(user.profile.name, forKey: defaultsKeys.name)
            UserDefaults.standard.set(true, forKey: defaultsKeys.keepSignedIn)
            UserDefaults.standard.set(Language.english.rawValue, forKey: defaultsKeys.language)
            UserDefaults.standard.synchronize()
            print("User email: \(user.profile.email ?? "No email")")
            print("User email: \(user.profile.name ?? "No email")")
            print("User email: \(user.profile.familyName ?? "No email")")
            
            let dashboard = self.storyboard?.instantiateViewController(identifier: "DashboardVC") as! DashboardVC
            self.navigationController?.pushViewController(dashboard, animated: true)
        }
    }
}
