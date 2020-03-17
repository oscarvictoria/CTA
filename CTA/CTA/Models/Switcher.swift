//
//  Switcher.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/17/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class Switcher {
    static func updateRootVC() {
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        
        print(status)
        
        
        if(status == true){
            rootVC = UIStoryboard(name: "MainView", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        }else{
            rootVC = UIStoryboard(name: "MainView", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
        }
        
       guard let scene = UIApplication.shared.connectedScenes.first,
       let sceneDelegate = scene.delegate as? SceneDelegate,
           let window = sceneDelegate.window else {
               fatalError("could not reset window rootViewController")
       }
        
        window.rootViewController = rootVC
        
    }
    
    
}
