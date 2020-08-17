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
    DummyFactory.autoCreate() // 30 개 데이터 만들어주는 아이
    return DBHelper.getInstance().readPostList()
}

var listData = posts()
