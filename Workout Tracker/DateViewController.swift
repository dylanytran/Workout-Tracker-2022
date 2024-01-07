//
//  DateViewController.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 11/4/21.
//

import Foundation
import UIKit
import SwiftUI
import ADDatePicker

final class DateViewController : UIViewController {
    @IBOutlet weak var datePicker : ADDatePicker!
    static let shared = DateObserver()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

class DateObserver : ObservableObject {
    @Published var date: Date = Date()
}

extension DateViewController: UIViewControllerRepresentable {
    
    public func makeUIViewController(context: Context) -> DateViewController {
        let storyboard = UIStoryboard(name: "Date", bundle: nil)
        
        let obj = storyboard.instantiateViewController(withIdentifier: "DateViewController") as! DateViewController
        
        return obj
    }
    
    func updateUIViewController(_ uiViewController: DateViewController, context: Context) {
        uiViewController.datePicker.delegate = context.coordinator
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, ADDatePickerDelegate {
        
        
        func ADDatePicker(didChange date: Date) {
            DateViewController.shared.date = date
        }
        
        var parent: DateViewController
        init(_ parent: DateViewController) {
            self.parent = parent
        }
    }
}
