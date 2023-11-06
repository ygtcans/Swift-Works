//
//  ViewController.swift
//  catchTheBall
//
//  Created by Yiğitcan Dursun on 2.11.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var tennisBall1: UIImageView!
    
    @IBOutlet weak var tennisBall2: UIImageView!
    
    @IBOutlet weak var tennisBall3: UIImageView!
    
    @IBOutlet weak var tennisBall4: UIImageView!
    
    @IBOutlet weak var tennisBall5: UIImageView!
    
    @IBOutlet weak var tennisBall6: UIImageView!
    
    @IBOutlet weak var tennisBall7: UIImageView!
    
    @IBOutlet weak var tennisBall8: UIImageView!
    
    @IBOutlet weak var tennisBall9: UIImageView!
    
    @IBOutlet weak var tennisBall10: UIImageView!
    
    @IBOutlet weak var tennisBall11: UIImageView!
    
    @IBOutlet weak var tennisBall12: UIImageView!
    
    @IBOutlet weak var tennisBall13: UIImageView!
    
    @IBOutlet weak var tennisBall14: UIImageView!
    
    @IBOutlet weak var tennisBall15: UIImageView!
    
    @IBOutlet weak var tennisBall16: UIImageView!
    
    @IBOutlet weak var tennisBall17: UIImageView!
    
    @IBOutlet weak var tennisBall18: UIImageView!
    
    @IBOutlet weak var tennisBall19: UIImageView!
    
    @IBOutlet weak var tennisBall20: UIImageView!
    
    @IBOutlet weak var tennisBall21: UIImageView!
    
    @IBOutlet weak var tennisBall22: UIImageView!
    
    @IBOutlet weak var tennisBall23: UIImageView!
    
    @IBOutlet weak var tennisBall24: UIImageView!
    
    var score =  0
    var timer = Timer()
    var counter  = 0
    var tennisBallArray = [UIImageView]()
    var ballTimer = Timer()
    var highScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        //Highscore check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")

        if(storedHighScore == nil){
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        tennisBall1.isUserInteractionEnabled = true
        tennisBall2.isUserInteractionEnabled = true
        tennisBall3.isUserInteractionEnabled = true
        tennisBall4.isUserInteractionEnabled = true
        tennisBall5.isUserInteractionEnabled = true
        tennisBall6.isUserInteractionEnabled = true
        tennisBall7.isUserInteractionEnabled = true
        tennisBall8.isUserInteractionEnabled = true
        tennisBall9.isUserInteractionEnabled = true
        tennisBall10.isUserInteractionEnabled = true
        tennisBall11.isUserInteractionEnabled = true
        tennisBall12.isUserInteractionEnabled = true
        tennisBall13.isUserInteractionEnabled = true
        tennisBall14.isUserInteractionEnabled = true
        tennisBall15.isUserInteractionEnabled = true
        tennisBall16.isUserInteractionEnabled = true
        tennisBall17.isUserInteractionEnabled = true
        tennisBall18.isUserInteractionEnabled = true
        tennisBall19.isUserInteractionEnabled = true
        tennisBall20.isUserInteractionEnabled = true
        tennisBall21.isUserInteractionEnabled = true
        tennisBall22.isUserInteractionEnabled = true
        tennisBall23.isUserInteractionEnabled = true
        tennisBall24.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer10 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer11 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer12 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer13 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer14 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer15 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer16 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer17 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer18 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer19 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer20 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer21 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer22 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer23 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer24 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        tennisBall1.addGestureRecognizer(recognizer1)
        tennisBall2.addGestureRecognizer(recognizer2)
        tennisBall3.addGestureRecognizer(recognizer3)
        tennisBall4.addGestureRecognizer(recognizer4)
        tennisBall5.addGestureRecognizer(recognizer5)
        tennisBall6.addGestureRecognizer(recognizer6)
        tennisBall7.addGestureRecognizer(recognizer7)
        tennisBall8.addGestureRecognizer(recognizer8)
        tennisBall9.addGestureRecognizer(recognizer9)
        tennisBall10.addGestureRecognizer(recognizer10)
        tennisBall11.addGestureRecognizer(recognizer11)
        tennisBall12.addGestureRecognizer(recognizer12)
        tennisBall13.addGestureRecognizer(recognizer13)
        tennisBall14.addGestureRecognizer(recognizer14)
        tennisBall15.addGestureRecognizer(recognizer15)
        tennisBall16.addGestureRecognizer(recognizer16)
        tennisBall17.addGestureRecognizer(recognizer17)
        tennisBall18.addGestureRecognizer(recognizer18)
        tennisBall19.addGestureRecognizer(recognizer19)
        tennisBall20.addGestureRecognizer(recognizer20)
        tennisBall21.addGestureRecognizer(recognizer21)
        tennisBall22.addGestureRecognizer(recognizer22)
        tennisBall23.addGestureRecognizer(recognizer23)
        tennisBall24.addGestureRecognizer(recognizer24)
        
        tennisBallArray = [tennisBall1,tennisBall2,tennisBall3,tennisBall4,
                           tennisBall5,tennisBall6,tennisBall7,tennisBall8,
                           tennisBall9,tennisBall10,tennisBall11,tennisBall12,
                           tennisBall13,tennisBall14,tennisBall15,tennisBall16,
                           tennisBall17,tennisBall18,tennisBall19,tennisBall20,
                           tennisBall21,tennisBall22,tennisBall23,tennisBall24]
        
        //Timer
        counter = 10
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        ballTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideTennisBall), userInfo: nil, repeats: true)

    }
    @objc func increaseScore(){
        score+=1
        scoreLabel.text = "Score: \(score)"
        
    }
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if(counter == 0){
            timer.invalidate()
            ballTimer.invalidate()
            // Save the Highscore
            if(self.score>self.highScore){
                self.highScore = self.score
                self.highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.setValue(self.highScore, forKey: "highscore")
            }
            //Alert
            let alert = UIAlertController(title: "Times's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton  = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.ballTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideTennisBall), userInfo: nil, repeats: true)

            }
            //adding Action
            alert.addAction(okButton)
            alert.addAction(replayButton
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func hideTennisBall(){
        for tennisBall in tennisBallArray{
            tennisBall.isHidden = true
        }
        let random =  arc4random_uniform(UInt32(tennisBallArray.count - 1))
        tennisBallArray[Int(random)].isHidden=false
    }
}

