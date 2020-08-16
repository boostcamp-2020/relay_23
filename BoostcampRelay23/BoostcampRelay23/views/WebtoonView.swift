//
//  WebtoonView.swift
//  BoostcampRelay23
//
//  Created by Imho Jang on 2020/08/14.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import SwiftUI

// MARK:- BoardDetailView
struct WebtoonView: View {
    @State private var isTranslated = false
    @State private var content = ""
    @State private var isExistTranslte = false
    @State private var imageContent = [UIImage.init(named: "toon1.png")!, UIImage.init(named: "toon2.png")!, UIImage.init(named: "toon3.png")!, UIImage.init(named: "toon4.png")!, UIImage.init(named: "toon5.png")!, UIImage.init(named: "toon6.png")!, UIImage.init(named: "toon7.png")!]
    @State private var count = 0
    
    /**
     To Do
     1. 초기화 시, 번역 안 된 이미지는 originContent에, 번역된 이미지는 translatedContent에, 담아서 처리하고 싶었으나 실패
     2. translating 구조 단순화
     */
    
    var detailData: Post
    let originContent = [UIImage.init(named: "toon1.png")!, UIImage.init(named: "toon2.png")!, UIImage.init(named: "toon3.png")!, UIImage.init(named: "toon4.png")!, UIImage.init(named: "toon5.png")!, UIImage.init(named: "toon6.png")!, UIImage.init(named: "toon7.png")!]
    @State private var translatedContent = [UIImage.init(named: "toon1.png")!, UIImage.init(named: "toon2.png")!, UIImage.init(named: "toon3.png")!, UIImage.init(named: "toon4.png")!, UIImage.init(named: "toon5.png")!, UIImage.init(named: "toon6.png")!, UIImage.init(named: "toon7.png")!]
    
    init(detailData: Post) {
        self.detailData = detailData
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(detailData.getTitle())").font(.title)
                            .modifier(TitleFont())
                        Text("작성자: \(detailData.getAuthor())")
                            .modifier(SubFont())
                            .modifier(SubFont())
                    }
                    Spacer()
                    Button(action: {
                        // TODO:- 번역 작업 불러오기
                        // 번역 통신은 초기 한번만 하자.
                        if self.isTranslated {
                            self.imageContent = self.originContent
                        } else {
                            //self.imageContent = self.translatedContent
                            self.originContent.enumerated().forEach({ (idx, image) in
                                let translater = Translater()
                                translater.setup(image: image)
                                translater.start()
                                translater.getTranslatedImage = { image in
                                    if let image = image {
                                        self.imageContent[idx] = image
                                    }
                                }
                            })
                        }
                        self.isTranslated.toggle()
                    }) {
                        Text(isTranslated ? "가👉A" : "A👉가" )
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .font(.headline)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
                
                Spacer()
                VStack {
                    ForEach(0..<imageContent.count) { index in
                        Image(uiImage: self.imageContent[index]).resizable().aspectRatio(contentMode: .fit)
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                HStack {
                    Button(action: {
                        self.count += 1}) {
                            Text("👍 \(String(count))")
                                .padding(5)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                    }
                    .cornerRadius(10)
                }
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
    
    struct WebtoonView_Previews: PreviewProvider {
        static var previews: some View {
            WebtoonView(detailData: Post(title: "PreView Title", author: "PreView Content"))
        }
    }
}
