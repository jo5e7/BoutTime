//
//  EventModel.swift
//  Bout Time
//
//  Created by Jose Maestre on 24/09/16.
//  Copyright © 2016 Jose Maestre. All rights reserved.
//

import Foundation

protocol EventType {
    
    var happening:String {get}
    
    // Yaer Before Christ must be imput as negative value
    var year:Int {get}
    var month:Int {get}
    var day:Int {get}
    
    var url:String? {get}
    
    func isLessRecentThan(event2:EventType) -> Bool
}

struct Event: EventType {
    
    var happening: String
    
    var year: Int
    var month: Int
    var day: Int
    
    var url: String?
    
    //Event at same date returns true in order to be accepted as correct answer in game
    func isLessRecentThan(event2: EventType) -> Bool {
        if self.year < event2.year {
            return true
        }else {
            if self.month < event2.month && self.year == event2.year {
                return true
            }else{
                if self.day <= event2.day && self.month == event2.month && self.year == event2.year{
                    return true
                }else{
                    return false
                }
            }
        }
    }
}

struct EventList {
    
    let e1:Event = Event(happening: "Christopher Columbus discovers America", year: 1492, month: 10, day: 12, url: "hhttps://en.wikipedia.org/wiki/Voyages_of_Christopher_Columbus")
    let e2:Event = Event(happening: "Fall of Constantinople", year: 1453, month: 5, day: 29, url: "https://en.wikipedia.org/wiki/Fall_of_Constantinople")
    let e3:Event = Event(happening: "Rodrigo Borgia is elected Pope of Rome", year: 1492, month: 8, day: 18, url: "https://es.wikipedia.org/wiki/Alejandro_VI")
    let e4:Event = Event(happening: "Dissolution of the Soviet Union", year: 1991, month: 12, day: 31, url: "")
    let e5:Event = Event(happening: "Apollo 11 lands on the moon", year: 1969, month: 7, day: 20, url: "")
    let e6:Event = Event(happening: "Fall of Berlin Wall", year: 1989, month: 11, day: 9, url: "")
    let e7:Event = Event(happening: "John F. Kennedy assassination", year: 1963, month: 11, day: 22, url: "")
    let e8:Event = Event(happening: "Chernobyl disaster", year: 1986, month: 4, day: 26, url: "")
    let e9:Event = Event(happening: "First airplane flies", year: 1903, month: 12, day: 17, url: "")
    let e10:Event = Event(happening: "Strike on twins towers New York", year: 2001, month: 9, day: 11, url: "")
    let e11:Event = Event(happening: "Cuban missile crisis", year: 1962, month: 10, day: 29, url: "")
    let e12:Event = Event(happening: "Princess Diana dies in car crash", year: 1997, month: 8, day: 31, url: "")
    let e13:Event = Event(happening: "Battle of Waterloo ", year: 1825, month: 6, day: 18, url: "")
    //Fisrt world war events
    let ww1_1:Event = Event(happening: "Start of the first world war", year: 1914, month: 7, day: 28, url: "https://en.wikipedia.org/wiki/World_War_I")
    let ww1_2:Event = Event(happening: "End of the first world war", year: 1918, month: 11, day: 11, url: "https://en.wikipedia.org/wiki/World_War_I")
    let ww1_3:Event = Event(happening: "Assassination of Archduke Franz Ferdinand of Austria", year: 1914, month: 6, day: 28, url: "https://en.wikipedia.org/wiki/Assassination_of_Archduke_Franz_Ferdinand_of_Austria")
    //Second World war events
    let ww2_1:Event = Event(happening: "Start of second world war", year: 1939, month: 9, day: 1, url: "https://en.wikipedia.org/wiki/World_War_II")
    let ww2_2:Event = Event(happening: "End of second world war", year: 1945, month: 9, day: 2, url: "https://en.wikipedia.org/wiki/World_War_II")
    let ww2_3:Event = Event(happening: "Japanese attack on Pearl Harbor", year: 1941, month: 12, day: 7, url: "https://en.wikipedia.org/wiki/Attack_on_Pearl_Harbor")
    let ww2_4:Event = Event(happening: "Invasion of Normandy (WW2)", year: 1944, month: 6, day: 6, url: "https://en.wikipedia.org/wiki/Invasion_of_Normandy")
    let ww2_5:Event = Event(happening: "Allies reach Berlin (WW2)", year: 1945, month: 4, day: 16, url: "https://en.wikipedia.org/wiki/Race_to_Berlin")
    //Football events
    let f1:Event = Event(happening: "Brazil wins its first FIFA world cup", year: 1958, month: 6, day: 29, url: "https://en.wikipedia.org/wiki/1958_FIFA_World_Cup")
    let f2:Event = Event(happening: "Start of the first FIFA world cup", year: 1930 , month: 7, day: 13, url: "https://en.wikipedia.org/wiki/1930_FIFA_World_Cup")
    let f3:Event = Event(happening: "Argenita wins its first FIFA world cup", year: 1978, month: 6, day: 25, url: "https://en.wikipedia.org/wiki/1978_FIFA_World_Cup")
    let f4:Event = Event(happening: "Maradona wins his first FIFA world cup", year: 1986, month: 6, day: 29, url: "https://en.wikipedia.org/wiki/1986_FIFA_World_Cup")
    let f5:Event = Event(happening: "Pele wins his first FIFA world cup", year: 1958, month: 6, day: 29, url: "https://en.wikipedia.org/wiki/1958_FIFA_World_Cup")
    //Movie events
    let m1:Event = Event(happening: "Skynet`s Judgment Day", year: 1997, month: 8, day: 29, url: "http://terminator.wikia.com/wiki/Judgment_Day")
    let m2:Event = Event(happening: "Pulp Finction Premier", year: 1994, month: 10, day: 10, url: "")
    
    
    var eventsArray:[Event] = []
    
    init() {
    eventsArray = [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12,
                   ww1_1, ww1_2, ww1_3,
                   ww2_1, ww2_2, ww2_3, ww2_4, ww2_5,
                   f1, f2, f3, f4, f5,
                   m1, m2]
    }
}


















