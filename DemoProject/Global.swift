//
//  Global.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 13/12/20.
//

import Foundation

struct defaultsKeys {
    
    static var keepSignedIn = "keepSignedIn"
    static var emailId = "emailId"
    static var name = "name"
    static var language = "language"
    static var taskArr = "taskArr"
}

enum Task: String {
    case taskName = "taskName"
    case taskTime = "taskTime"
}

enum Language: String {
    case english = "English"
    case arabic = "Arabic"
}

enum LanguageCode: String {
    case english = "en"
    case arabic = "ar"
}

enum LocalizableString: String {
    case Demo_App = "Demo App"
    case Sign_in_with_google  = "Sign in with google"
    case Welcome = "Welcome"
    case Encryption = "Encryption"
    case To_Do = "To-Do"
    case Stopwatch = "Stopwatch"
    case Message = "Message"
    case Secret_Key = "Secret Key"
    case Encrypt = "Encrypt"
    case Decrypt = "Decrypt"
    case Delete = "Delete"
    case Are_you_sure_you_want_to_delete_this_task = "Are_you_sure_you_want_to_delete_this_task?"
    case Task_Name = "Task Name"
    case Date_and_time = "Date and time"
    case Save = "Save"
    case Clear = "Clear"
    case OK = "OK"
    case Cancel = "Cancel"
    case Change_Language = "Change Language"
    case Logout = "Logout"
    case Are_you_sure_you_want_to_logout = "Are_you_sure_you_want_to_logout?"
    case English = "English"
    case Arabic = "Arabic"
    case Dashboard = "Dashboard"
    case Alert = "Alert!"
}
