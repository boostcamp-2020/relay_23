//
//  Data.swift
//  BoostcampRelay23
//
//  Created by In Taek Cho on 2020-08-07.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import UIKit
import SwiftUI
import RealmSwift


func posts() -> Results<PostData>{
    DummyFactory.autoCreate()
    return DBHelper.getInstance().readPostList()
}

var listData = posts()

//var listData: [Post] = [Post(id: 0, title: "Title1", content: "부스트캠프 프로젝트!", author: "cho", date: "2020. 08. 07"),
//                        Post(id: 1, title: "Title2", content: "안녕하세요.", author: "cho", date: "2020. 08. 07")]
