//
//  UIViewController + Navigation.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/16/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

extension UIViewController {
    private static func resetWindow(with rootViewController: UIViewController, apiNumber: Int?) {
        
        
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("could not reset window rootViewController")
        }
        
        window.rootViewController = rootViewController
    }
    
    public static func showViewController(storyboardName: String, viewControllerId: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let newViewController = storyboard.instantiateViewController(identifier: viewControllerId)
        resetWindow(with: newViewController, apiNumber: nil)
    }
    
    public static func showAnotherViewController(storyboardName: String, viewControllerId: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let newViewController = storyboard.instantiateViewController(identifier: viewControllerId)
        resetWindow(with: newViewController, apiNumber: nil)
    }
    
    public static func showSomeView(apiNumber: Int, storyboardName1: String, viewControllerId1: String, storyboardName2: String, viewControllerId2: String) {
        if apiNumber == 0 {
            let storyboard = UIStoryboard(name: storyboardName1, bundle: nil)
            let newViewController = storyboard.instantiateViewController(identifier: viewControllerId1)
            resetWindow(with: newViewController, apiNumber: apiNumber)
        } else if apiNumber == 1 {
            let storyboard = UIStoryboard(name: storyboardName2, bundle: nil)
            let newViewController = storyboard.instantiateViewController(identifier: viewControllerId2)
            resetWindow(with: newViewController, apiNumber: apiNumber)
        }
    }
}
