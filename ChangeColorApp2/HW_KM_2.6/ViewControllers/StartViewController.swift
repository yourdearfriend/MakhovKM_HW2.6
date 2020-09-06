//
//  StartViewController.swift
//  HW 2
//
//  Created by Konstantin on 06.09.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import UIKit

protocol colorDelegate {
    func getColor(redColor: Float, greenColor: Float, blueColor: Float)
}

class StartViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var startView: UIView!
    
    //MARK: - Private Properties
    private var redColorForStartView: Float = 1.0
    private var greenColorForStartView: Float = 1.0
    private var blueColorForStartView: Float = 1.0
    
    override func viewDidLoad() {
        startView.backgroundColor = UIColor(
            red: CGFloat(redColorForStartView),
            green: CGFloat(greenColorForStartView),
            blue: CGFloat(blueColorForStartView),
            alpha: 1
        )
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! SettingsViewController
        
        settingsVC.valueForRedSlider = redColorForStartView
        settingsVC.valueForBlueSlider = blueColorForStartView
        settingsVC.valueForGreenSlider = greenColorForStartView
        settingsVC.delegate = self
    }
}

// MARK: - Delegate methods 
extension StartViewController: colorDelegate {
    func getColor(redColor: Float, greenColor: Float, blueColor: Float) {
        
        redColorForStartView = redColor
        greenColorForStartView = greenColor
        blueColorForStartView = blueColor
        
        startView.backgroundColor = UIColor(
            red: CGFloat(redColor),
            green: CGFloat(greenColor),
            blue: CGFloat(blueColor),
            alpha: 1
        )
    }
}
