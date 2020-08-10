  
//
//  TranslationAPI.swift
//  BoostcampRelay23
//
//  Created by 김신우 on 2020/08/07.
//  Created by 조수정 on 2020/08/07.
//  Created by 오동건 on 2020/08/07.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//
//  Last modified by 조수정 on 2020/08/08

  import Foundation

  class TranslationAPI {
      
       static let shared = TranslationAPI()
       private let userId = "다음 릴레이 프로젝트를 진행하실 캠퍼분의 user id를 넣어주세요"
       private let key = "다음 릴레이 프로젝트를 진행하실 캠퍼분의 key를 넣어주세요"
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
                  
                  // str to json --- Sue
                  var translatedText: String = ""
                  let decoder = JSONDecoder()
                  let data = str.data(using: .utf8)
                  
                  // decode json -> extract 'translated text'
                  if let data = data, let TransDatas = try? decoder.decode(Entry.self, from: data) {
                      translatedText = TransDatas.message.result.translatedText
                      callback(translatedText)
                  }
                  
                  
               } else {
                   callback("Failed")
               }
           }
           dataTask.resume()
       }
  }


