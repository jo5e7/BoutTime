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
    
    var eventList = EventList().eventsArray
    var roundEventArray = [Event]()
    var timer:Timer? = nil
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        populateRound()
        startTimer()
        
    }
    
    func startTimer() {
        count = 10
        countDownLabel.text = "60"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func update(timer:Timer) {
        if(count > 0) {
            count -= 1
            countDownLabel.text = String(count)
        }else{
            //Time is out, end of the round
            let result = checkEventsOrder()
            print(result)
            timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func populateRound() {
      
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
        }
    }
    
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
}

