//
//  Workouts.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 10/14/21.
//

import Foundation

class Workouts: Identifiable, Hashable {
    static func == (lhs: Workouts, rhs: Workouts) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id = UUID()
    var name: String = ""
    var sets: String = ""
    var reps: String = ""
    var weight: String = ""
    
    
    init(name n: String, sets s: String, reps r: String,  weight w: String)
    {
        name = n
        sets = s
        reps = r
        weight = w
    }
}
