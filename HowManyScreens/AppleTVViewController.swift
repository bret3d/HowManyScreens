//
//  AppleTVViewController.swift
//  HowManyScreens
//
//  Created by Bret Dahlgren on 4/14/17.
//  Copyright © 2017 elfinda apps. All rights reserved.
//

import UIKit
import AVFoundation

public class AppleTVViewController: UIViewController {

    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var borderViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var screen1Label: UILabel!
    
    @IBOutlet weak var screen2Label: UILabel!
    
    var initialConstraint:CGFloat = 0.0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        initialConstraint = borderViewWidthConstraint.constant
        reset()

    }

    public func startAnimation() {
        
        animateLayer(layer: borderView.layer)
        
        UIView.animate(withDuration: 4.0, animations: {
        self.borderViewWidthConstraint.constant = 1200
        self.view.layoutIfNeeded()
        
        }, completion: { finish in
        
        
            self.screen2Label.alpha = 0.0
            self.screen2Label.isHidden = false
            UIView.animate(withDuration: 1.0, animations: {
                self.screen2Label.alpha = 1.0
            })
        
        
        })
        
        UIView.animate(withDuration: 1.0, animations: {
            self.screen1Label.alpha = 0.0
        })
        
        playSound()
    }
    
    func animateLayer(layer:CALayer) {
        
        let color = CABasicAnimation(keyPath: "borderColor")
        color.fromValue = layer.borderColor
        color.toValue = UIColor.blue.cgColor
        layer.borderColor = UIColor.blue.cgColor
        
        let width = CABasicAnimation(keyPath: "borderWidth")
        width.fromValue = layer.borderWidth
        width.toValue = 15.0
        layer.borderWidth = 15.0
        
        let both = CAAnimationGroup()
        both.duration = 4.0
        both.animations = [color, width]
        both.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer.add(both, forKey: "color and width")
        
    }

    var player: AVAudioPlayer?
    
    func playSound() {
        let url = Bundle.main.url(forResource: "THX", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
            player.currentTime = (player.duration/2.0)
            player.volume = 0.0
            player.play()
            player.setVolume(1.0, fadeDuration: 1.0)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func reset() {
        
        borderView.layer.borderColor = UIColor.white.cgColor
        
        borderView.layer.borderWidth = 5.0
        borderView.backgroundColor = UIColor.black
        screen1Label.alpha = 1.0
        screen2Label.isHidden = true
        borderViewWidthConstraint.constant = initialConstraint
        
    }
    
}
