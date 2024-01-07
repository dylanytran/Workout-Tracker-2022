//
//  WorkoutRow.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 10/14/21.
//

import SwiftUI

struct WorkoutRow: View {
 
    @State private var workout: Workouts = Workouts(name: "Bench", sets: "5", reps: "5", weight: "100")
    
    init(_ workout: Workouts) {
        _workout = State(initialValue: workout)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Exercise")
                    .font(.system(size: 12))
            }
            HStack {
                TextField("", text: $workout.name)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
            }
            HStack {
                
                VStack {
                    Text("Sets")
                        .font(.system(size: 12))
                    TextField("", text: $workout.sets)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                }
                VStack {
                    Text("Reps")
                        .font(.system(size: 12))
                    TextField("", text: $workout.reps)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                }
                VStack {
                    Text("Weight")
                        .font(.system(size: 12))
                    TextField("", text: $workout.weight)
                        .textFieldStyle(.roundedBorder)
                        .disableAutocorrection(true)
                }
            }
        }
        .frame(height: 150)
    }
}

struct WorkoutRow_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutRow(Workouts(name: "Squats", sets: "5", reps: "5", weight: "100"))
    }
}
