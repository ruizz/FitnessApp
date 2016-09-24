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
    @IBOutlet weak var plusButton: PushButton!
    @IBOutlet weak var minusButton: PushButton!
    
    // View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.counterLabel.text = String(self.counterView.counter)
        
    }
    
    // IBActions
    
    @IBAction func pushButtonPressed(_ sender: PushButton) {
        if (sender == self.plusButton) {
            self.counterView.counter += 1
            
        } else {
            self.counterView.counter -= 1
            
        }
        self.counterLabel.text = String(self.counterView.counter)
        
    }

}

