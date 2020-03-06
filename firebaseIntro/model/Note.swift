//
//  Note.swift
//  firebaseIntro
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
class Note {
    
    var id:String
    var head:String
    var body:String
    
    //constructor
    init(id:String, head:String, body:String){
        self.id = id
        self.head = head
        self.body = body
    }
}
