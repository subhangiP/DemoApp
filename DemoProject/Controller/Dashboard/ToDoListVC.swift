//
//  ToDoListVC.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 14/12/20.
//

import UIKit
import Foundation

class ToDoListVC: UIViewController {

    @IBOutlet weak var tblToDoList: UITableView!
    
    var arrTask = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
    }
    
    //MARK:- Button Action
    @IBAction func btnAddClicked(_ sender: UIButton) {
        let addTaskVC = self.storyboard?.instantiateViewController(withIdentifier: "AddTaskVC") as! AddTaskVC
        addTaskVC.completion = { (dict) in
            print(dict)
            self.arrTask.append(dict)
            self.saveData()
        }
        self.present(addTaskVC, animated: true, completion: nil)
    }
    
    private func loadInitialData(){
        arrTask = UserDefaults.standard.value(forKey: defaultsKeys.taskArr) as? [[String : String]] ?? []
        tblToDoList.reloadData()
    }
    
    private func saveData(){
        UserDefaults.standard.set(self.arrTask, forKey: defaultsKeys.taskArr)
        self.tblToDoList.reloadData()
    }
    
    private func displayConfirmationAlert(index: Int){
        let alertController = UIAlertController(title: self.setLanguageChange(stringKey: LocalizableString.Alert.rawValue),
                                                message: self.setLanguageChange(stringKey: LocalizableString.Are_you_sure_you_want_to_delete_this_task.rawValue),
                                                preferredStyle:.alert)
        let firstAction = UIAlertAction(title: self.setLanguageChange(stringKey: LocalizableString.OK.rawValue),
                                        style: .default) { (alert: UIAlertAction!) -> Void in
            self.arrTask.remove(at: index)
            self.saveData()
        }
        let cancelAction = UIAlertAction(title: self.setLanguageChange(stringKey: LocalizableString.Cancel.rawValue),
                                         style: .cancel) { (alert: UIAlertAction!) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(firstAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
//  MARK: - UITableViewDelegate, UITableViewDataSource
extension ToDoListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblToDoList.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as! To_Do_ListCell
        let dictTask = arrTask[indexPath.row]
        cell.lblTaskName.text = dictTask[Task.taskName.rawValue]
        cell.lblTaskTime.text = dictTask[Task.taskTime.rawValue]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            displayConfirmationAlert(index: indexPath.row)
        }
    }
}
