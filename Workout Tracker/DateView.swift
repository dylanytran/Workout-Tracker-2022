//
//  DateViewController.swift
//  Workout Tracker
//
//  Created by Dylan Tran on 11/4/21.
//

import SwiftUI
import UIKit
import ADDatePicker

struct DateView: UIViewRepresentable {
    
    typealias UIViewType = ADDatePicker
    
    func makeUIView(context: Context) -> ADDatePicker {
        ADDatePicker()
    }
    
    func updateUIView(_ uiView: ADDatePicker, context: Context) {
        
    }
}
