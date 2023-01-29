//
//  Note.swift
//  NoteMacos
//
//  Created by huang on 2023/1/29.
//

import SwiftUI

// Note Model and sample Notes...

struct Note: Identifiable {
    var id = UUID().uuidString
    var note : String
    var date : Date
    var carColor : Color
}

// sample dates
func getSampleDate(offset: Int) -> Date {
    let calender = Calendar.current
    let date = calender.date(byAdding: .day, value: offset, to:Date())
    return date ?? Date()
}

var notes:[Note] = [
    Note(note: "The begining of screenless design UI jobs to be taken...", date: getSampleDate(offset: 1), carColor: Color("Skin")),
    Note(note: "13 thing you should know if you want to be a successful Designer", date: getSampleDate(offset: -10), carColor: Color("Purple")),
    Note(note: "The Psychology Priciples Every UI/UX Desinger need to Konw", date: getSampleDate(offset: -15), carColor: Color("Green")),
    Note(note: "The begining of screenless design UI jobs to be taken...", date: getSampleDate(offset: 10), carColor: Color("Blue")),
    Note(note: "The begining of screenless design UI jobs to be taken...", date: getSampleDate(offset: -3), carColor: Color("Orange")),
]
