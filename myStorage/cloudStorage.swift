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
    
    
    static func startListener(tableView:UITableView){
        print("starting listener")
        db.collection(notes).addSnapshotListener { (snap, error) in
            if error == nil {
                self.list.removeAll() // clears list before adding new items
                for note in snap!.documents{
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let imageid = map["imageid"] as? String ?? "empty"
                    let newNote = Note(id: note.documentID, head: head, body: body, imageid: imageid)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    //Read func
    static func readNotes(){
        db.collection(notes).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("error getting doc")
            } else {
                for document in querySnapshot!.documents {
                    print(document.data())
                }
            }
            
        }
    }
    
    static func getListSize() -> Int{
        return list.count
    }
    
    static func getNoteAt(index:Int) -> Note {
        return list[index]
    }
    
    static func uploadImage(name: String, vc:ViewController){
        let imgRef = storage.reference(withPath: name)
        if let imageData = vc.imageView.image!.jpegData(compressionQuality: 0.1) {
            
            let uploadTask = imgRef.putData(imageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("image uploaded succesfully")
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
            map["imageid"] = note.imageid
            docRef.setData(map)
            
        }
        
        static func deleteNote(id:String){
            let docRef = db.collection(notes).document(id)
            docRef.delete()
        }
        
}
