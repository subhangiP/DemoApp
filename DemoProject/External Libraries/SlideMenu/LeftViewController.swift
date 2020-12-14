//
//  LeftViewController.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 13/12/20.
//

import UIKit
import GoogleSignIn

enum LeftMenu: String {
    case dashboard = "Dashboard"
    case changeLanguage = "Change Language"
    case nonMenu = "nonMenu"
    
    static func controllerName(value:String) -> LeftMenu{
        switch  value{
        case  LeftMenu.dashboard.rawValue : return LeftMenu.dashboard
        case  LeftMenu.changeLanguage.rawValue: return  LeftMenu.changeLanguage
        default: return LeftMenu.nonMenu
        }
    }
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController {
    
    @IBOutlet weak var tblMain: UITableView!
    @IBOutlet weak var btnLogout: UIButton!

    var menuArr = [LeftMenu.dashboard.rawValue, LeftMenu.changeLanguage.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnLogout.setTitle(self.setLanguageChange(stringKey: LocalizableString.Logout.rawValue), for: .normal)
    }

    //MARK:- Button Action
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        let alertController = UIAlertController(title: self.setLanguageChange(stringKey: LocalizableString.Alert.rawValue),
                                                message: self.setLanguageChange(stringKey: LocalizableString.Are_you_sure_you_want_to_logout.rawValue),
                                                preferredStyle:.alert)
        let firstAction = UIAlertAction(title: self.setLanguageChange(stringKey: LocalizableString.OK.rawValue),
                                        style: .default) { (alert: UIAlertAction!) -> Void in
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            GIDSignIn.sharedInstance()?.signOut()
            let loginView = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
            let loginVC = UINavigationController(rootViewController: loginView)
            self.slideMenuController()?.changeMainViewController(loginVC, close: true)
            alertController.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: self.setLanguageChange(stringKey: LocalizableString.Cancel.rawValue),
                                         style: .cancel) { (alert: UIAlertAction!) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(firstAction)
        alertController.addAction(cancelAction)
        closeLeft()
        self.present(alertController, animated: true, completion: nil)
    }
    
 
}
//  MARK: -  LeftMenuProtocol
extension LeftViewController: LeftMenuProtocol {
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .dashboard:
            let dashboard = self.storyboard?.instantiateViewController(identifier: "DashboardVC") as! DashboardVC
            let dashboardVC = UINavigationController(rootViewController: dashboard)
            self.slideMenuController()?.changeMainViewController(dashboardVC, close: true)
        case .changeLanguage:
            let changeLanguage = self.storyboard?.instantiateViewController(identifier: "ChangeLanguageVC") as! ChangeLanguageVC
            let changeLanguageVC = UINavigationController(rootViewController: changeLanguage)
            self.slideMenuController()?.changeMainViewController(changeLanguageVC, close: true)
        default:
            break
        }
    }
}

//  MARK: - UITableViewDataSource, UITableViewDelegate
extension LeftViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMain.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath)
        let lblTitle = cell.viewWithTag(10) as! UILabel
        lblTitle.text = menuArr[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeViewController(LeftMenu.controllerName(value: menuArr[indexPath.row]))
    }
    
}

