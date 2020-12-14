//
//  AddTaskVC.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 14/12/20.
//

import UIKit

class AddTaskVC: UIViewController {

    @IBOutlet weak var tfTaskName: UITextField!
    @IBOutlet weak var tfTaskTime: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    typealias completionHandler = ([String: String]) -> Void
    var completion: completionHandler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(sender:)))
        self.view.addGestureRecognizer(tap)
        initialSetUp()
    }
    
    //MARK:- Button Action
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        if tfTaskTime.text?.count ?? 0 > 2 {
            if tfTaskTime.text?.count ?? 0 > 2 {
                let dict: [String : String] = [(Task.taskName.rawValue ): tfTaskName.text ?? "", (Task.taskTime.rawValue ): tfTaskTime.text ?? ""]
                guard let completionBlock = completion else { return }
                completionBlock(dict)
                self.dismiss(animated: true, completion: nil)
            } else {
                self.displayAlert(msg: "Enter valid task time")
            }
        } else {
            self.displayAlert(msg: "Enter valid task name")
        }
    }
    
    @IBAction func btnClearClicked(_ sender: UIButton) {
        tfTaskName.text = ""
        tfTaskTime.text = ""
    }

    @IBAction func DateTimeTextFieldClicked(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
        tfTaskTime.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(AddTaskVC.datePickerFromValueChanged), for: UIControl.Event.valueChanged)
    }
        
    @objc func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy h:mm a"
        tfTaskTime.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer)  -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initialSetUp() {
        tfTaskName.placeholder = self.setLanguageChange(stringKey: LocalizableString.Task_Name.rawValue)
        tfTaskTime.placeholder = self.setLanguageChange(stringKey: LocalizableString.Date_and_time.rawValue)
        btnSave.setTitle(self.setLanguageChange(stringKey: LocalizableString.Save.rawValue), for: .normal)
        btnClear.setTitle(self.setLanguageChange(stringKey: LocalizableString.Clear.rawValue), for: .normal)
    }
}
//  MARK: - UITextField Delegate
extension AddTaskVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
