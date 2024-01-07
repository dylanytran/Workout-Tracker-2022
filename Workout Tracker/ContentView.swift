//
//  ContentView.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 10/7/21.
//

import SwiftUI

struct ContentView : View {
    
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [
            /*NSSortDescriptor(keyPath: \Exercise.name, ascending: false),
            NSSortDescriptor(keyPath: \Exercise.reps, ascending: false),
            NSSortDescriptor(keyPath: \Exercise.sets, ascending: false),*/
            NSSortDescriptor(keyPath: \Workout.date, ascending: false)
        ])
    var all: FetchedResults<Workout>
    @ObservedObject var dateObserver: DateObserver = DateViewController.shared
    var workouts: [Workout] {
        all.filter {
            w in DateFormatter(dateFormat: "MM-dd-yyyy").string(from: w.date!) == DateFormatter(dateFormat: "MM-dd-yyyy").string(from: dateObserver.date)
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                if(workouts.count == 0) {
                    Text("No Activity Today")
                        .font(.largeTitle)
                }
                
                DateViewController()

                List(workouts, id: \.self) { workout in
                    
                    ForEach(workout.exercises?.array as! [Exercise],id: \.self) {exercise in
                        //Text(exercise.name!)
                        
                        //List(workouts.first.exercises, id: \.self) { exercise in
                            VStack {
                                HStack {
                                    Text("Exercise")
                                        .font(.system(size: 12))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                HStack {
                                    Text(exercise.name ?? "Unknown")
                                        //.textFieldStyle(.roundedBorder)
                                }
                                HStack {
                                    
                                    VStack {
                                        Text("Sets")
                                            .font(.system(size: 12))
                                        Text(exercise.sets ?? "Unknown")
                                            //.textFieldStyle(.roundedBorder)
                                    }
                                    VStack {
                                        Text("Reps")
                                            .font(.system(size: 12))
                                        Text(exercise.reps ?? "Unknown")
                                            //.textFieldStyle(.roundedBorder)
                                    }
                                    VStack {
                                        Text("Weight")
                                            .font(.system(size: 12))
                                        Text(exercise.weight ?? "Unknown")
                                            //.textFieldStyle(.roundedBorder)
                                    }
                                }
                            }
                        //}
                    }
                    
                }
                
                //Text("\(workouts.count)")
                
                /*NavigationLink(destination: DateViewController()) {
                    Text("Hi")
                }*/
                
                Spacer()
                
                if workouts.isEmpty {
                    NavigationLink(destination: NewWorkout()) {
                        Text("+")
                        .frame(minWidth: 0, maxWidth: 30)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .font(.title)
                    }
                }
                else {
                    NavigationLink(destination: NewWorkout(workout: workouts)) {
                        Text("Edit")
                        .frame(minWidth: 0, maxWidth: 40)
                        .frame(minHeight: 0, maxHeight: 5)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        //.font(.title)
                        .font(.system(size: 20))
                    }
                }
          }
        }
        .environmentObject(dateObserver)
    }
}

class ChildHostingController : UIHostingController<ContentView>{
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ContentView());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
