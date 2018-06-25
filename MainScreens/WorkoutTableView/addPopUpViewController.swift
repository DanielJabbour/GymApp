//
//  addPopUpViewController.swift
//  GymApp
//
//  Created by Daniel Jabbour on 2018-06-24.
//  Copyright © 2018 Daniel Jabbour. All rights reserved.
//

import UIKit

class addPopUpViewController: UIViewController {

    @IBOutlet weak var muscleGroupTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
}
