//
//  HomeViewController.swift
//  ABC Planner
//
//  Created by Bartosz Gejgał on 25/09/2020.
//  Copyright © 2020 Bartosz Gejgał. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var goToTaskListsButton: UIButton!
    @IBOutlet weak var howToUseAppButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        goToTaskListsButton.layer.cornerRadius = 30
        howToUseAppButton.layer.cornerRadius = 30
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func goToTaskListsButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: K.goToTaskListSegueId, sender: self)
    }
    
    @IBAction func howToUseAppButtonClicked(_ sender: Any) {
        // performSegue(withIdentifier: K.goToHowToUseSegueId, sender: self)
        print("TODO IMPLEMENT THE HOW TO USE WINDOW!")
    }
}
