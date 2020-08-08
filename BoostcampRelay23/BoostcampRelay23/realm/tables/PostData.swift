//
//  PostData.swift
//  BoostcampRelay23
//
//  Created by Seungeon Kim on 2020/08/08.
//  Created by 오태양 on 2020/08/08.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import Foundation
import RealmSwift


class PostData: Object, Identifiable{
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var date : String = ""
  
    convenience init(title: String, text: String) {
        self.init()
        self.id = autoIncrement()
        self.author = "Camper \(self.id)"
        self.title = title
        self.content = text
        self.date = getDate()
    }
    
    
    func autoIncrement() -> Int{
        let realm = DBHelper.getInstance().realm
        let lastId = realm.objects(PostData.self)
        var id = 0
        
        if lastId.count != 0 {
            id = lastId[lastId.count - 1].id + 1
        }
        return id
    }
    
    func getDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        return date
    }
    
    func setContent(text: String){
        self.content = text
    }
    
    func setTitle(text: String){
        self.title = text
    }
    
    func getId() -> Int{
        return self.id
    }
    
    func getTitle() -> String{
        return self.title
    }
    
    func getContent() -> String{
        return self.content
    }
    
    func getAuthor() -> String{
        return self.author
    }
}


