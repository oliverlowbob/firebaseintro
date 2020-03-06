//
//  cloudStorage.swift
//  firebaseIntro
//
//  Created by admin on 28/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class cloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let notes = "notes"
    private static let storage = Storage.storage()

    static func startListener(){
        print("starting listener")
        db.collection(notes).addSnapshotListener { (snap, error) in
            if error == nil {
                self.list.removeAll() // clears list before adding new items
                for note in snap!.documents{
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let newNote = Note(id: note.documentID, head: head, body: body)
                    self.list.append(newNote)
                }
            }
        }
    }

    
    static func downloadImage(name:String, vc:ViewController){
        let imgRef = storage.reference(withPath: name) // get filehandle
        imgRef.getData(maxSize: 400000) {(data, error) in
            if error == nil{
                print("succes downloading image")
                //set image using vc
                let img = UIImage(data: data!)
                DispatchQueue.main.async{
                    vc.imageView.image = img
                }
            }
            else{
                print("error: \(error.debugDescription)")
            }

        }
    }
    
    static func createNote(head:String, body:String){
        let docRef = db.collection(notes).document()
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
    }
    
    static func updateNote(index:Int, head:String, body:String){
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
        
    }
    
    static func deleteNote(id:String){
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
}
