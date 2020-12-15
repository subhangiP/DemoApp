//
//  ChangeLanguageVC.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 13/12/20.
//

import UIKit

class ChangeLanguageVC: UIViewController {

    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnArabic: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var currentLanguage: Language?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        setInitialSetUp()
    }
    
    @IBAction func btnLanguageAction(_ sender: UIButton) {
        if sender == btnEnglish {
            currentLanguage = Language.english
            btnEnglish.isSelected = true
        } else {
            currentLanguage = Language.arabic
            btnArabic.isSelected = true
        }
        setImage()
    }
    
    @IBAction func btnSaveLanguageClicked(_ sender: UIButton) {
        if currentLanguage == Language.english {
            UserDefaults.standard.set(Language.english.rawValue, forKey: defaultsKeys.language)
        } else {
            UserDefaults.standard.set(Language.arabic.rawValue, forKey: defaultsKeys.language)
        }
        UserDefaults.standard.synchronize()
        setInitialSetUp()
    }
    
    private func setInitialSetUp(){
        if (UserDefaults.standard.value(forKey: defaultsKeys.language) as! String) == Language.english.rawValue {
            currentLanguage = Language.english
            btnEnglish.setTitle(LocalizableString.English.rawValue.localizableString(loc: LanguageCode.english.rawValue), for: .normal)
            btnArabic.setTitle(LocalizableString.Arabic.rawValue.localizableString(loc: LanguageCode.english.rawValue), for: .normal)
            btnSave.setTitle(LocalizableString.Save.rawValue.localizableString(loc: LanguageCode.english.rawValue), for: .normal)
            self.navigationItem.title = LeftMenu.changeLanguage.rawValue.localizableString(loc: LanguageCode.english.rawValue)
        } else {
            currentLanguage = Language.arabic
            btnEnglish.setTitle(LocalizableString.Arabic.rawValue.localizableString(loc: LanguageCode.arabic.rawValue), for: .normal)
            btnArabic.setTitle(LocalizableString.Arabic.rawValue.localizableString(loc: LanguageCode.arabic.rawValue), for: .normal)
            btnSave.setTitle(LocalizableString.Save.rawValue.localizableString(loc: LanguageCode.arabic.rawValue), for: .normal)
            self.navigationItem.title = LeftMenu.changeLanguage.rawValue.localizableString(loc: LanguageCode.arabic.rawValue)
        }
        setImage()
    }
    
    private func setImage(){
        if currentLanguage == Language.english {
            btnEnglish.setImage(UIImage(named: "radio-on"), for: .normal)
            btnArabic.setImage(UIImage(named: "radio-off"), for: .normal)
        } else {
            btnArabic.setImage(UIImage(named: "radio-on"), for: .normal)
            btnEnglish.setImage(UIImage(named: "radio-off"), for: .normal)
        }
    }
    
}
