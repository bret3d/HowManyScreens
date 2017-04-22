//
//  ScreenManager.swift
//
//  Created by Bret Dahlgren on 4/14/17.
//  Copyright © 2017 elfinda apps. All rights reserved.
//

import UIKit

public class ScreenManager: NSObject {
    
    public var externalScreen: UIScreen?
    public var externalWindow: UIWindow?
    public var externalViewController: UIViewController?
    public var storyboard: UIStoryboard?
    
    public override init() {
        super.init()
        storyboard = UIStoryboard(name: "Main", bundle: Bundle.init(for: ScreenManager.self))
        registerForNotifications()
    }
    
    func registerForNotifications() {
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(screenDidConnect(notification:)), name: NSNotification.Name.UIScreenDidConnect, object: nil)
        center.addObserver(self, selector: #selector(screenDidDisconnect(notification:)), name: NSNotification.Name.UIScreenDidDisconnect, object: nil)
        center.addObserver(self, selector: #selector(screenModeDidChange(notification:)), name: NSNotification.Name.UIScreenModeDidChange, object: nil)
        
        setupOutputScreen()
    }
    
    func setupOutputScreen() {
        let connectedScreens = UIScreen.screens
        let localScreen = UIScreen.main
        let appleTVScreen = connectedScreens.filter{$0 != localScreen}.first
        setupExternalScreen(screen:appleTVScreen)
    }
    
    func setupExternalScreen(screen:UIScreen?) {
        if let screen = screen {
            
            externalScreen = screen
            
            let maxScreenMode = screen.availableModes.max{ $0.size.height < $1.size.height}
            
            screen.currentMode = maxScreenMode
            let window = UIWindow(frame: screen.bounds)
            externalWindow = window
            window.isHidden = false
            //window.layer.contentsGravity = kCAGravityResizeAspect
            window.screen = screen
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AppleTVViewController")
            externalViewController = viewController
            window.rootViewController = viewController
        }
    }
    
    func disableExternalScreen() {
        externalViewController = nil
        externalScreen = nil
        externalWindow = nil
    }
    
    
    func screenDidConnect(notification:NSNotification) {
        setupExternalScreen(screen: notification.object as? UIScreen)
    }
    
    func screenDidDisconnect(notification:NSNotification) {
        disableExternalScreen()
    }
    
    func screenModeDidChange(notification:NSNotification) {
        
    }
}


