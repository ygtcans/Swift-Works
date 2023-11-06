//
//  ViewController.swift
//  TimerApp2
//
//  Created by Yiğitcan Dursun on 31.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var startBut: UIButton!
    
    @IBOutlet weak var resetBut: UIButton!
    
    var timer = Timer()
    var count = 0
    var timerCounting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBut.setTitleColor(UIColor.green, for: .normal)
        resetBut.setTitleColor(UIColor.black, for: .normal)
    }

    @IBAction func startButton(_ sender: Any) {
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            startBut.setTitle("START", for: UIControl.State.normal)
            startBut.setTitleColor(UIColor.green, for: UIControl.State.normal
            )}else{
                timerCounting = true
                startBut.setTitle("STOP", for: UIControl.State.normal)
                startBut.setTitleColor(UIColor.red, for: UIControl.State.normal)
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            }
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure ypu would you like to reset the timer?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil ))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startBut.setTitle("START", for: .normal)
            self.startBut.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)

        
    }
    @objc func timerCounter() -> Void{
        count = count + 1
        let time = secondToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
        
    }
    func secondToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int){
        return ((seconds/3600),  ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String{
        var timesString = ""
        timesString += String(format: "%02d", hours) + " : "
        timesString += String(format: "%02d", minutes) + " : "
        timesString += String(format: "%02d", seconds)
        return timesString
    }
}


