//
//  TableList.swift
//  BoostcampRelay23
//
//  Created by In Taek Cho on 2020-08-07.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import SwiftUI

struct TableListView: View {

    var body: some View {
        NavigationView{
            
            List(listData) { item in
                NavigationLink(destination: DetailView(detailData: item)){
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
            }.navigationBarTitle("글 목록 페이지", displayMode: .inline)
            
            .navigationBarItems(trailing:
                NavigationLink(destination: WriteView()) {
                    Text("POST")
                })
        }
    }
}

struct TableList_Previews: PreviewProvider {
    static var previews: some View {
        TableListView()
    }
}
