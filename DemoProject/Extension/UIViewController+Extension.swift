//
//  UIViewController+Extension.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 14/12/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    //  MARK: - AlertController
    func displayAlert(msg: String) {
        let alert = UIAlertController(title: "Alet!", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "menu")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
        self.navigationController?.navigationBar.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        //Customizing Navigation Bar
        self.navigationController?.navigationBar.barStyle = .default
//        UINavigationBar.appearance().barTintColor = UIColor(red: 161/255, green: 235/255, blue: 244/255, alpha: 1)//A1EBF4
//        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        // remove border of the navigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        self.navigationController?.navigationBar.layoutIfNeeded()
        // navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func setLanguageChange(stringKey: String) -> String {
        let currentLanguage = UserDefaults.standard.value(forKey: defaultsKeys.language) as? String ?? ""
        if currentLanguage == Language.english.rawValue {
            return stringKey.localizableString(loc: LanguageCode.english.rawValue)
        } else {
            return stringKey.localizableString(loc: LanguageCode.arabic.rawValue)
        }
    }
}

