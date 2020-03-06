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
        cloudStorage.startListener()
    }

    @IBOutlet weak var head: UITextField!
    
    @IBOutlet weak var body: UITextField!
    
    @IBAction func btnClicked(_ sender: Any) {
        //Storage.updateNote(index: 0, head: "test", body: "test")
        cloudStorage.createNote(head: head.text!, body: body.text!)

    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func downloadBtnPressed(_ sender: Any) {
        cloudStorage.downloadImage(name: "storfede.jpg", vc:self)
    }
    
    
    
}

