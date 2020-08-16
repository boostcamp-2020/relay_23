//
//  WriteView.swift
//  BoostcampRelay23
//
//  Created by 양어진 on 2020/08/14.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import SwiftUI

struct WriteView: View {
    
    @State var title = ""
    @State var content = ""
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("제목")){
                    TextField("제목을 입력해주세요", text: $title)
                        .keyboardType(.default)
                }
                
                Section(header: Text("내용")) {
                    HStack {
                        TextView(text: $content)
                                .frame(minWidth: 0,
                                        maxWidth: .infinity,
                                        minHeight: 0,
                                        maxHeight: .infinity,
                                        alignment: .topLeading)
                        Spacer()
                    }
                }
                }.navigationBarTitle("게시글 작성 페이지!")
        }
    }
}

struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView()
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        myTextView.font = UIFont(name: "HelveticaNeue", size: 18)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}
