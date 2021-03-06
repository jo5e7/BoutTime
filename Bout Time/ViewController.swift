//
//  ViewController.swift
//  Bout Time
//
//  Created by Jose Maestre on 24/09/16.
//  Copyright © 2016 Jose Maestre. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    @IBOutlet weak var event0Label: UILabel!
    @IBOutlet weak var event1Label: UILabel!
    @IBOutlet weak var event2Label: UILabel!
    @IBOutlet weak var event3Label: UILabel!
    @IBOutlet weak var shakeToCompleteLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var down0Button: UIButton!
    @IBOutlet weak var up1Button: UIButton!
    @IBOutlet weak var down1Button: UIButton!
    @IBOutlet weak var up2Button: UIButton!
    @IBOutlet weak var down2Button: UIButton!
    @IBOutlet weak var up3Button: UIButton!
    
    @IBOutlet weak var finalScoreView: UIView!
    
    
    
    var eventList = EventList().eventsArray
    var roundEventArray = [Event]()
    var timer:Timer? = nil
    
    var timerCount = 0
    let roundsPerGame = 6
    var roundsPlayed = 0
    var roundsSuccessful = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateRound()
        startTimer()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Shake gesture
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            //Do something
            qualifyRound()
        }
        
    }

    func populateRound() {
        roundEventArray .removeAll()
      //Repopulate the array of events
        eventList = EventList().eventsArray
        for label in 0...3 {
            let eventNumber = GKRandomSource.sharedRandom().nextInt(upperBound: eventList.count)
            let event = eventList[eventNumber]
            
            switch label {
            case 0:
                event0Label.text = event.happening
                roundEventArray.insert(event, at: 0)
            case 1:
                event1Label.text = event.happening
                roundEventArray.insert(event, at: 1)
            case 2:
                event2Label.text = event.happening
                roundEventArray.insert(event, at: 2)
            case 3:
                event3Label.text = event.happening
                roundEventArray.insert(event, at: 3)
            default:
                break
            }
            //Remove the event of the array to avoid reapeted event at the same round
            eventList.remove(at: eventNumber)
        }
    }
    //Move event down in game
    @IBAction func upEventAction(_ sender: UIButton) {
        let tag = sender.tag
        
        switch tag {
        case 1:
            changeLabelPosition(label: event1Label, withLabel: event0Label)
            changeEventPosition(tag: tag, withTag: tag-1)
        case 2:
            changeLabelPosition(label: event2Label, withLabel: event1Label)
            changeEventPosition(tag: tag, withTag: tag-1)
        case 3:
            changeLabelPosition(label: event3Label, withLabel: event2Label)
            changeEventPosition(tag: tag, withTag: tag-1)
        default:
            break
        }
    }
    //Move event up in game
    @IBAction func downEventAction(_ sender: UIButton) {
        let tag = sender.tag
        
        switch tag {
        case 0:
            changeLabelPosition(label: event0Label, withLabel: event1Label)
            changeEventPosition(tag: tag, withTag: tag+1)
        case 1:
            changeLabelPosition(label: event1Label, withLabel: event2Label)
            changeEventPosition(tag: tag, withTag: tag+1)
        case 2:
            changeLabelPosition(label: event2Label, withLabel: event3Label)
            changeEventPosition(tag: tag, withTag: tag+1)
        default:
            break
        }
     
    }
    
    func changeLabelPosition(label:UILabel, withLabel:UILabel) {
        let labelText = label.text
        let withLabelText = withLabel.text
        
        label.text = withLabelText
        withLabel.text = labelText
    }
    
    func changeEventPosition(tag:Int, withTag:Int) {
        let tagEvent = roundEventArray[tag]
        let withTagEvent = roundEventArray[withTag]
        
        roundEventArray[tag] = withTagEvent
        roundEventArray[withTag] = tagEvent
    }
    
    func checkEventsOrder() -> Bool {
        let count = roundEventArray.count - 2
        var result = true
        
        for index in 0...count {
            let index2 = index + 1
            let event1 = roundEventArray[index]
            let event2 = roundEventArray[index2]
            let isCorrect = event1.isLessRecentThan(event2: event2)
            print(isCorrect)
            
            if isCorrect == false {
                result = false
            }
            
        }
        return result
    }
    
    @IBAction func nextRoundAction() {
        if roundsPerGame == roundsPlayed {
            self.finalScoreLabel.text = "\(roundsSuccessful)/\(roundsPerGame)"
            setUpViewsForFinalScore()
        }else{
            populateRound()
            self.nextRoundButton.isHidden = true
            startTimer()
        }
    }
    
    @IBAction func playAgainAction() {
        setUpViewsForGame()
        roundsPlayed = 0
        roundsSuccessful = 0
        startTimer()
        populateRound()
    }
    
    func qualifyRound() {
        let roundResult = checkEventsOrder()
        self.roundsPlayed += 1
        self.nextRoundButton.isHidden = false
        self.timer?.invalidate()
        
        if roundResult == true {
            let image = UIImage (named: "next_round_success")
            self.nextRoundButton .setImage(image, for: .normal)
            self.roundsSuccessful += 1
        }else{
            let image = UIImage (named: "next_round_fail")
            self.nextRoundButton .setImage(image, for: .normal)
        }
        //If is last round go directly to results
        if roundsPlayed == roundsPerGame {
            nextRoundAction()
        }
        
    }
    
    
    func startTimer() {
        timerCount = 60
        countDownLabel.text = "60"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if(timerCount > 0) {
            timerCount -= 1
            countDownLabel.text = String(timerCount)
        }else{
            //Time is out, end of the round
            qualifyRound()
        }
    }
    
    func setUpViewsForGame() {
        self.event0Label.isHidden = false
        self.event1Label.isHidden = false
        self.event2Label.isHidden = false
        self.event3Label.isHidden = false
        
        self.down0Button.isHidden = false
        self.down1Button.isHidden = false
        self.down2Button.isHidden = false
        self.up1Button.isHidden = false
        self.up2Button.isHidden = false
        self.up3Button.isHidden = false
        
        self.countDownLabel.isHidden  = false
        self.shakeToCompleteLabel.isHidden = false
        
        self.nextRoundButton.isHidden = true
        self.finalScoreView.isHidden = true
        
    }
    
    func setUpViewsForFinalScore() {
        self.event0Label.isHidden = true
        self.event1Label.isHidden = true
        self.event2Label.isHidden = true
        self.event3Label.isHidden = true
        
        self.down0Button.isHidden = true
        self.down1Button.isHidden = true
        self.down2Button.isHidden = true
        self.up1Button.isHidden = true
        self.up2Button.isHidden = true
        self.up3Button.isHidden = true
        
        self.countDownLabel.isHidden  = true
        self.nextRoundButton.isHidden = true
        self.shakeToCompleteLabel.isHidden = true
        
        self.finalScoreView.isHidden = false
    }
}

