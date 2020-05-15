//
//  ViewController.swift
//  firebaseIntro
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        cloudStorage.uploadImage(name: "download.jpeg", vc: self)
    }
    
}
