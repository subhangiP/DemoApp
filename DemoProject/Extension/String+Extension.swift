//
//  String+Extension.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 14/12/20.
//

import Foundation
import UIKit

extension String {
    
    func localizableString(loc: String) -> String {
        guard let path = Bundle.main.path(forResource: loc, ofType: "lproj") else { return "" }
        guard let bundle = Bundle(path: path) else { return "" }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
