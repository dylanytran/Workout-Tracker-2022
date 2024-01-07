//
//  New Workout.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 10/13/21.
//


import SwiftUI

struct NewWorkout: View {
    
    @State var workouts: [Workouts]
    @State var theWorkout : Workout!
    
    init(w: [Workouts]) {
        _workouts = State(initialValue: w)
        theWorkout = nil
    }
    
    init(workout: [Workout]) {
        theWorkout = nil
        if(!workout.isEmpty) {
            theWorkout = workout[0]
        }
        
        var array : [Workouts] = []
       
        workout.forEach { w in
            for e in w.exercises!.array {
                let exer = e as! Exercise
                
                var ws = Workouts(name: exer.name!, sets: exer.sets!, reps: exer.reps!, weight: exer.weight!)
                array.append(ws)
                
            }
            
        }
        
        _workouts = State(initialValue:array)
    }
    
    init() {
        theWorkout = nil
        _workouts = State(initialValue: [Workouts(name: "", sets: "", reps: "", weight: "")])
    }
    
    var body: some View {
        
        List{
            ForEach(workouts, id: \.self) { workout in
                WorkoutRow(workout)
            }
            .onDelete(perform: delete)
        }

        Button("Add", action: {
            workouts.append(Workouts(name: "", sets: "", reps: "", weight: ""))
        })
        
        
        //if theWorkout is nil - everything is the same
        //otherwise, assign workout variable to be theWorkout
        Button("Save", action: {
            
            let set = NSMutableSet()
            if(workouts.count >= 1) {
                for i in 0...workouts.count-1 {
                    let exercise = Exercise(context: PersistenceController.shared.container.viewContext)
                    exercise.name = workouts[i].name
                    exercise.sets = workouts[i].sets
                    exercise.reps = workouts[i].reps
                    exercise.weight = workouts[i].weight
                    
                    set.add(exercise)
                }
                if let tW = theWorkout {
                    tW.exercises = NSOrderedSet.init(set: set as! Set<AnyHashable>)
                    PersistenceController.shared.save()
                }
                else {
                    let workout = Workout(context: PersistenceController.shared.container.viewContext)
                    
                    workout.exercises = NSOrderedSet.init(set: set as! Set<AnyHashable>)
                    workout.date = DateViewController.shared.date
                            
                    PersistenceController.shared.save()
                    theWorkout = workout
                }
            }
            else {
                PersistenceController.shared.container.viewContext.delete(theWorkout)
            }
            
            
        })

        }
    
    func delete(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
        
        }
    }

struct NewWorkout_Previews: PreviewProvider {
    static var previews: some View {
        NewWorkout()
    }
}
