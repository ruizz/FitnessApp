//
//  ViewController.swift
//  FitnessApp
//
//  Created by Ruiz Akpan on 9/23/16.
//  Copyright © 2016 helloruiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var plusButton: PushButton!
    @IBOutlet weak var minusButton: PushButton!
    
    // Variables
    private var graphViewShowing: Bool = false
    
    // View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.graphView.isHidden = true
        self.counterLabel.text = String(self.counterView.counter)
        
    }
    
    // UI changes
    
    @IBAction func counterViewTapped(_ sender: UITapGestureRecognizer?) {
        if (self.graphViewShowing) {
            // Hide
            UIView.transition(from: self.graphView, to: self.counterView, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        } else {
            // Show
            UIView.transition(from: self.counterView, to: self.graphView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
        self.graphViewShowing = !self.graphViewShowing
        
    }
    
    // IBActions
    
    @IBAction func pushButtonPressed(_ sender: PushButton) {
        if (self.graphViewShowing) {
            self.counterViewTapped(nil)
            return
            
        }
        if (sender == self.plusButton) {
            self.counterView.counter += 1
            
        } else {
            self.counterView.counter -= 1
            
        }
        self.counterLabel.text = String(self.counterView.counter)
        
        
    }

}

