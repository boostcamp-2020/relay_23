  
//
//  TranslationAPI.swift
//  BoostcampRelay23
//
//  Created by 김신우 on 2020/08/07.
//  Created by 조수정 on 2020/08/07.
//  Created by 오동건 on 2020/08/07.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//


import Foundation

class TranslationAPI {
     static let shared = TranslationAPI()
     private let userId = "sniuqpwqjq"
     private let key = "qdC3nDk1s3LxwE5lbDMOe7vhIVynxFhZ2rL2pW7Q"
     private var request = URLRequest(url: URL(string: "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation")!)
     
     private init(){
         // url request 정의
         request.httpMethod = "POST"
         request.addValue(userId, forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
         request.addValue(key, forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
     }
     
     
     func translate(text: String,_ callback: @escaping (String)->Void) {
         let param = "source=ko&target=en&text=\(text)"
         let paramData = param.data(using: .utf8)
         
         request.httpBody = paramData
         request.setValue(String(paramData!.count),forHTTPHeaderField: "Content-Length")
         
         let dataTask = URLSession.shared.dataTask(with: request){ (data, response, error) in
             if let data = data {
                 //TODO: str to json or data to json
                 let str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
                 callback(str)
             } else {
                 callback("")
             }
         }
         dataTask.resume()
     }
}
