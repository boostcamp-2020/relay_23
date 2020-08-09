//
//  DummyFactory.swift
//  BoostcampRelay23
//
//  Created by Seungeon Kim on 2020/08/08.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import Foundation

class DummyFactory{
    static func autoCreate(){
        DBHelper.getInstance().repositoryClear()
        print("DB 경로 : \(DBHelper.getInstance().getDBFileURL())")
        
        for i in (1...30){
            let title = "BoostCamp :: \(i)번째 글"
            let text = "안녕하세요, 부스트캠프 \(i)번째 글입니다."
            let post: PostData = PostData(title: title, text: text)
            
            DBHelper.getInstance().inputData(data: post)
        }
    }
}
