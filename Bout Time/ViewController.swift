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
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var nextRoundButton: UIButton!
    
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
    
    func startTimer() {
        timerCount = 60
        countDownLabel.text = "60"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func update() {
        if(timerCount > 0) {
            timerCount -= 1
            countDownLabel.text = String(timerCount)
        }else{
            //Time is out, end of the round
            qualyfyRound()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Shake gesture
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            //Do something
            qualyfyRound()
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
        populateRound()
        self.nextRoundButton.isHidden = true
        startTimer()
    }
    
    func qualyfyRound() {
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
        
    }
    
}

