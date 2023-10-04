//
//  BookItemView.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/9/24.
//

import Kingfisher
import SwiftUI

struct BookItemCard: View {
    @ObservedObject var bookWatcher = BookWatcher.shared

//    @GestureState var isLongPressed = false // 用于刷新长按手势的状态
    var book: Book

    var body: some View {
//        let longPressGesture = LongPressGesture() // 初始化一个长按手势，该手势一旦识别到长按的触摸状态，就会调用手势的结束事件。您甚至可以限制长按手势的时间长度
//            .updating($isLongPressed) { value, state, transcation in // 通过调用updating方法，监听手势状态的变化
//                print("updating: value=\(value), state=\(state), transcation=\(transcation)")
//                state = value
//            }
//            .onEnded { value in
//                print("onEnded: value=\(value)")
//            }

        HStack {
            cover
            info
            Spacer()
            operationArea
        }
        .padding(.all, 5)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/6)
        .background(Color.xwhiteCard)
        .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
    }

    var cover: some View {
        VStack {
            if !book.isLocal() {
                KFImage(URL(string: book.cover))
                    .placeholder {
                        Image(systemName: "questionmark")
                            .font(.system(size: 40, weight: .light, design: .monospaced))
                            .foregroundColor(.orange.opacity(0.4))
                            .frame(width: 100)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            } else {
                let image = UIImage(contentsOfFile: book.cover)
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                } else {
                    Image(systemName: "questionmark")
                        .font(.system(size: 40, weight: .light, design: .monospaced))
                        .foregroundColor(.orange.opacity(0.4))
                        .frame(width: 100)
                }
            }
        }
        .shadow(color: .black.opacity(0.3), radius: 2, x: 3.0, y: 3.0)
    }

    var info: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(book.name)")
                .font(.system(size: 16, weight: .heavy, design: .rounded))
            Text("\(book.author)")
                .font(.system(size: 12, weight: .regular, design: .rounded))
            Spacer()
            Text("\(book.publisher)")
                .font(.system(size: 10, weight: .light, design: .rounded))
                .italic()
                .underline()
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 10))
                    .foregroundColor(Color.gray)
                Text("\(book.location.displayName)")
                    .font(.system(size: 10, weight: .light, design: .rounded))
                    .foregroundColor(Color.gray)

                if book.local {
                    Spacer()
//                        Image(systemName: "externaldrive.fill.badge.timemachine")
                    Image(systemName: "clock.badge.exclamationmark")
                        .font(.system(size: 12))
                        .foregroundColor(Color.orange.opacity(0.6))
                }
            }
        }
        .frame(maxWidth: 3 * UIScreen.main.bounds.width/5, alignment: .leading)
        .lineLimit(1)
        .padding(.vertical, 10)
    }

    var operationArea: some View {
        VStack {
            Button(action: {
                bookWatcher.setBookDetail(book: book)
            }, label: {
//                    Label("", systemImage: "chevron.right")
                Label("", systemImage: "poweron")
//                    Label("", systemImage: "ellipsis")
//                        .rotationEffect(Angle(degrees: 90))
                    .font(.system(size: 20))
                    .foregroundColor(Color.accentColor.opacity(0.3))
                    .shadow(radius: 10)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 5)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                    .shadow(color: .white, radius: 5, x: 10, y: 10)
            })
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 4) {
            BookItemCard(book: Book(name: "古文观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息", local: true))
            BookItemCard(book: Book(name: "古文观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息", local: true))
            BookItemCard(book: Book(name: "古文观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息", local: true))
        }
    }
    .scrollIndicators(.hidden)
    .padding(.horizontal, 5)
    .background(Color.xgrayBg)
//    .refreshable {
//
//    }
//
//    List {
//
//        BookItemCard(book: Book(name: "古文观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息", local: true))
//            .background(Color.xgrayTab)
//            .lineSpacing(0)
//        BookItemCard(book: Book(name: "古文观止", author: "佚名", publisher: "新华出版社", location: .beijing, cover: "https://img2.baidu.com/it/u=3643635547,2549293047&fm=253&fmt=auto&app=138&f=JPEG", isbn: "123478747585", description: "还没有描述信息", local: true))
//            .background(Color.xgrayTab)
//            .lineSpacing(0)
//    }
//    .listStyle(.insetGrouped)
//    .lineSpacing(0)
//    .refreshable {
//
//    }
//    .background(Color.red)
}
