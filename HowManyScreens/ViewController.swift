//
//  ViewController.swift
//  HowManyScreens
//
//  Created by Bret Dahlgren on 4/14/17.
//  Copyright © 2017 elfinda apps. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {

    @IBOutlet weak var borderView: UIView!
    var manager:ScreenManager?
    var appleTVViewController:AppleTVViewController?
    var isReset = true
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        
        
        borderView.layer.borderColor = UIColor.white.cgColor
        
        borderView.layer.borderWidth = 5.0
        borderView.backgroundColor = UIColor.black
        
        manager = ScreenManager()
        appleTVViewController = manager?.externalViewController as? AppleTVViewController
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        
        if let appleTVViewController = appleTVViewController {
            if isReset {
            appleTVViewController.startAnimation()
            } else {
                appleTVViewController.reset()
            }
            isReset = !isReset
        }
    }

    
    
    
}

