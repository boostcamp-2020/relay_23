//
//  DBHelper.swift
//  BoostcampRelay23
//
//  Created by Seungeon Kim on 2020/08/08.
//  Created by 오태양 on 2020/08/08.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import Foundation
import RealmSwift

class DBHelper{
    private static let instance: DBHelper = DBHelper()
    let realm: Realm = try! Realm()
    
    private init(){ }
    
    static func getInstance()-> DBHelper{
        return instance
    }
    
    //내부 DB파일 주소 출력
    //일단 출력만 되게 해놓았습니다. 반환시 fileURL의 타입은 URL? 입니다
    func getDBFileURL() -> String{
        guard let realmPath = Realm.Configuration.defaultConfiguration.fileURL else{
            return "Could not find Realm DB Path"
        }
        return realmPath.absoluteString
    }
    
    func inputData(data: Object){
        do{
            try realm.write{ // realm.write{}는 git에서 commit을 해주는 것과 비슷하다.
                realm.add(data) // 데이터베이스에 park 모델을 더한다.
            }
        } catch {
            print("Error Add \(error)")
        }
        
    }
    
    func readPostList() -> Results<PostData>{
        var posts: Results<PostData>
        posts = realm.objects(PostData.self)
        return posts
    }
    
    func readPost(key: Int) -> PostData?{
        let posts = readPostList()
        
        for post in posts{
            if key == post.id{
                return post
            }
        }
        return nil
    }
    
    // 수정 필요 - 무얼 업데이트? 글만 업데이트 하면 되겟지?
    func updataDB(id: Int, text: String) -> Bool{
        guard let data = readPost(key: id) else{
            return false
        }
        
        do{
            try realm.write{
                data.content = text
            }
        }catch{
            return false
        }
        return true
    }
    
    func  deleteDB(data: Object) -> Bool{
        do{
            try realm.write{
                realm.delete(data)
            }
        }catch{
            print("Could not delete data")
            return false
        }
        return true
    }
    
    func repositoryClear() {
        do{
            try realm.write{
                realm.deleteAll()
            }
        }catch{
            print("Could not clear data")
        }
    }
}
