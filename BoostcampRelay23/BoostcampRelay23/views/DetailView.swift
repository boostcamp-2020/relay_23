//
//  BoardDetailView.swift
//  BoostcampRelay23
//
//  Created by 서명렬 on 2020/08/07.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import SwiftUI

// 제목 폰트
struct TitleFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(3)
    }
}

// 서브 폰트
struct SubFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(.horizontal, 3)
    }
}


// MARK:- BoardDetailView
struct DetailView: View {
    @State private var isTranslate = false
    @State private var content = ""
    @State private var isExistTranslte = false
    
    var detailData: PostData
    
    var body: some View {
        //    NavigationView {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(detailData.getTitle())").font(.title)
                        
                        .modifier(TitleFont())
                    Text("작성자: \(detailData.getAuthor())")
                        .modifier(SubFont())
                    Text("작성날짜: \(detailData.getDate())")
                        .modifier(SubFont())
                }
                Spacer()
                Button(action: {
                    // TODO:- 번역 작업 불러오기
                    // 번역 통신은 초기 한번만 하자.
                    if !self.isExistTranslte{
                        TranslationAPI.shared.translate(text: self.detailData.getContent()) { (text) in
                            self.content = text
                            self.isExistTranslte = true
                        }
                    }
                    self.isTranslate.toggle()
                }) {
                    Text(isTranslate ? "Translate" : "번역하기")
                        .padding(5)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .font(.headline)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
            Text(isTranslate ? "\(content)" : detailData.getContent())
                .layoutPriority(1)
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 20)
            Spacer()
        }
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            DetailView(detailData: PostData(title: "PreView Title", text: "PreView Content"))
        }
    }
}
