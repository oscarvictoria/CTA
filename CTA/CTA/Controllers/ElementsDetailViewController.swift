//
//  ElementsDetailViewController.swift
//  CTA
//
//  Created by Oscar Victoria Gonzalez  on 3/18/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {
    
    var detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    



}
