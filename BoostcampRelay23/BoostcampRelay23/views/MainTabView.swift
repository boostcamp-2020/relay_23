//
//  MainTabView.swift
//  BoostcampRelay23
//
//  Created by Imho Jang on 2020/08/14.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TableListView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("커뮤니티")
                }

            WebtoonListView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("웹툰")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

