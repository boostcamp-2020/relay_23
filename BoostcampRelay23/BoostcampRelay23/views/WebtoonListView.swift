//
//  TableList.swift
//  BoostcampRelay23
//
//  Created by In Taek Cho on 2020-08-07.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import SwiftUI

struct WebtoonListView: View {
    var listData2: [Post] = [Post(title: "Olympus", author: "Someone from America"), Post(title: "Olympus2", author: "Someone from America")]

    var body: some View {
        NavigationView{
            List(listData2) { item in
                NavigationLink(destination: WebtoonView(detailData: item)) {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(item.getTitle()).bold().font(.title)
                        HStack {
                            Text("작성자 : ")
                            Text(item.getAuthor())
                        }
                        Spacer()
                    }
                }
            }.navigationBarTitle("아마추어 만화 목록", displayMode: .inline)
        }
    }
}

struct WebtoonList_Previews: PreviewProvider {
    static var previews: some View {
        WebtoonListView()
    }
}
