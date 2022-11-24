//
//  OnBoarding.swift
//  Meditation
//
//  Created by user on 17.11.2022.
//

import UIKit

class OnBoarding: UIViewController {
    let userDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = userDefault.set(true, forKey: "wasLaunched")

        }
    
}
