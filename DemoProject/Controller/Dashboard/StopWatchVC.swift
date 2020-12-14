//
//  StopWatchVC.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 14/12/20.
//

import UIKit

class StopWatchVC: UIViewController {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTime.text = String(counter)
        btnPause.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    //MARK:- Button Action
    @IBAction func btnStartClicked(_ sender: UIButton) {
        if(isPlaying) {
            return
        }
        btnStart.isEnabled = false
        btnPause.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func btnPauseClicked(_ sender: UIButton) {
        btnStart.isEnabled = true
        btnPause.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
    }
    
    @IBAction func btnResetClicked(_ sender: UIButton) {
        btnStart.isEnabled = true
        btnPause.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        lblTime.text = String(counter)
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        lblTime.text = String(format: "%.1f", counter)
    }
}
