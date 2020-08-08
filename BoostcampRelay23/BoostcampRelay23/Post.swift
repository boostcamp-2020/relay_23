//
//  Post.swift
//  BoostcampRelay23
//
//  Created by 임수현 on 2020/08/07.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import Foundation

class Post: Identifiable {
    internal let id: UUID = UUID()
    private let postId: Int
    private let title: String
    private var content: String
    private let author: String
    private let date: String
    private var translatedContent: String
    
    // ** 일단 String형태로 date가 들어온다고 가정하고 만들었습니다.
    // ** Date 객체로 들어올 경우 주석을 해제하고 사용하면 됩니다.
//    private let date: Date
    
    init(id: Int = 0, title: String = "title", content: String = "content", author: String = "author", date: String = "date") {
        self.postId = id
        self.title = title
        self.content = content
        self.author = author
        self.date = date
        self.translatedContent = ""
    }
    //** Date일 경우
//    init(id: Int = 0, title: String = "title", content: String = "content", author: String = "author", date: Date = Date()) {
//        self.id = id
//        self.title = title
//        self.content = content
//        self.author = author
//        self.date = date
//    }

    func getId() -> Int {
        return self.postId
    }
    func getTitle() -> String {
        return self.title
    }
    func getContent() -> String {
        return self.content
    }
    func setContent(text: String){
        self.content = text
    }
    func getAuthor() -> String {
        return self.author
    }
    func getDateStr() -> String {
        return self.date
    }
    func getDateFromStr() -> Date { // String to Date
        // 만약 2020. 08. 07 형태의 문자열이라면
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"   // 여기서 형식을 맞춰주면 됨
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        return dateFormatter.date(from: self.date)!
    }
    func getTranslatedContent() -> String {
        return translatedContent
    }

    //    func getDate() -> Date {
    //        return self.date
    //    }
    //    func getDateToStr() -> String {   // Date to String
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "YYYY. MM. DD"
    //        dateFormatter.locale = Locale(identifier: "ko_KR")
    //        return dateFormatter.string(from: self.date)) // 2020. 08. 07
    //
    //    func getGlobalDateToStr() -> String { // Global Date to String
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "MMM DD, YYYY"
    //        return dateFormatter.string(from: self.date) // Aug 7, 2020
    //    }
}
