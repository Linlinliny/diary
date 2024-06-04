//
//  RoughlyCard.swift
//  diary
//
//  Created by 琳琳夭 on 2024/5/31.
//
import Foundation
import SwiftUI
import CoreData

struct RoughlyCard: View {
    var item: DiaryEntry
    @State var showText = false
    @State private var showImag = true
    @State private var isZoomed = false
    @State private var selectedPhoto: String? = nil
    var body: some View {
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    CountImage(item: item,showImage: $showImag)
                    Spacer()
                }
                if (item.element != nil){
                    Text(item.element!)
                        .foregroundStyle(Color(.black))
                        .font(.headline)
                        .padding(.leading,10)
                        .onTapGesture {
                            self.showText = true
                        }
                        .frame(maxHeight: showText ? 9999999 : 65) // 设置框架大小
                }
                Divider()
                    .padding(-3)
                HStack{
                    Text(formattedDate(date: item.timestamp ?? Date()))
                       .padding(.leading,9)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Button(action: {
                        print("111")
                    }) {
                        Image(systemName: "ellipsis")
                            .padding()
                        }
                }
                .padding(.top,-15)
            }
            .animation(.easeInOut, value: showText)
            .frame(width: 360)
            .padding(.top,5)
            .background(Color("02"))          // 设置背景色
            .cornerRadius(5)
            .contextMenu {
                    Button(action: {
                        // 编辑操作
                 }) {
                        Text("编辑")
                     Image(systemName: "pencil")
             }
                    Button(action: {
                        // 删除操作
                 }) {
                        Text("删除")
                        Image(systemName: "trash")
                    }
                }
        }
}

struct FullScreenImageView: View {
    @Binding var isZoomed: Bool
    var imageName: String

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        isZoomed.toggle()
                    }
                }) {
                    Text("关闭")
                        .font(.title)
                        .padding()
                }
                Spacer()
                Button(action: {
                    // 这里添加删除图片的操作
                }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .padding()
                }
            }
            .background(Color.white)
            .foregroundColor(.blue)

            Spacer()

            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Spacer()
        }
        .background(Color.black.opacity(0.8).edgesIgnoringSafeArea(.all))
    }
}

struct ImageView: View {
    var imagePath: String

    var body: some View {
        // 使用自定义函数从路径加载UIImage
        if let uiImage = loadImageFromPath(imagePath) {
            Image(uiImage: uiImage)
                .resizable() // 允许图像调整大小以适应容器
                .scaledToFit() // 保持图片的宽高比
        } else {
            Text("无法加载图片")
        }
    }

    func loadImageFromPath(_ path: String) -> UIImage? {
        guard let image = UIImage(contentsOfFile: path) else {
            print("无法从给定路径加载图片: \(path)")
            return nil
        }
        return image
    }
}

struct RoughlyCardImage1:View{
    var diaryEntry: [String]
        
    var body:some View{
        
        HStack{
            ImageView(imagePath: diaryEntry[0])
                    .scaledToFill()
                    .frame(width: 350,height: 175)
                    .clipped()
                    .cornerRadius(5)
        }
        .frame(width: 350,height: 175)
    }
}

struct RoughlyCardImage2:View{
    var diaryEntry: [String]
    
    var body:some View{
        HStack{
            Spacer()
            ImageView(imagePath: diaryEntry[0])
                .scaledToFill()
                .frame(width: 173,height: 173)
                .clipped()
                .cornerRadius(5)
            ImageView(imagePath: diaryEntry[1])
                .scaledToFill()
                .frame(width: 173,height: 173)
                .clipped()
                .cornerRadius(5)
                .padding(.leading,-3)
            Spacer()
        }
        .frame(width: 350,height: 173)
    }
}

struct RoughlyCardImage3:View{
    var diaryEntry: [String]
    
    var body:some View{
        HStack{
            Spacer()
            ImageView(imagePath: diaryEntry[0])
                .scaledToFill()
                .frame(width: 173,height: 173)
                .clipped()
                .cornerRadius(5)
            VStack{
                ImageView(imagePath: diaryEntry[1])
                    .scaledToFill()
                    .frame(width: 173,height: 85)
                    .clipped()
                    .cornerRadius(5)
                    .padding(.bottom,-3)
                ImageView(imagePath: diaryEntry[2])
                    .scaledToFill()
                    .frame(width: 173,height: 85)
                    .clipped()
                    .cornerRadius(5)
            }
            .padding(.leading,-3)
            Spacer()
        }
        .frame(width: 350,height: 173)
    }
}

struct RoughlyCardImage4:View{
    var diaryEntry: [String]
    
    var body:some View{
        HStack{
            Spacer()
            ImageView(imagePath: diaryEntry[0])
                .scaledToFill()
                .frame(width: 173,height: 173)
                .clipped()
                .cornerRadius(5)
            VStack{
                ImageView(imagePath: diaryEntry[1])
                    .scaledToFill()
                    .frame(width: 173,height: 85)
                    .clipped()
                    .cornerRadius(5)
                    .padding(.bottom,-3)
                HStack{
                    ImageView(imagePath: diaryEntry[2])
                        .scaledToFill()
                        .frame(width: 85,height: 85)
                        .clipped()
                        .cornerRadius(5)
                    ImageView(imagePath: diaryEntry[3])
                        .scaledToFill()
                        .frame(width: 85,height: 85)
                        .clipped()
                        .cornerRadius(5)
                        .padding(.leading,-3)
                }
            }
            .padding(.leading,-3)
            Spacer()
        }
        .frame(width: 350,height: 175)
    }
}

struct RoughlyCardImage5:View{
    var diaryEntry: [String]
    
    var body:some View{
        HStack{
            Spacer()
            ImageView(imagePath: diaryEntry[0])
                .scaledToFill()
                .frame(width: 173,height: 173)
                .clipped()
                .cornerRadius(5)
            VStack{
                HStack{
                    ImageView(imagePath: diaryEntry[1])
                        .scaledToFill()
                        .frame(width: 85,height: 85)
                        .clipped()
                        .cornerRadius(5)
                    ImageView(imagePath: diaryEntry[2])
                        .scaledToFill()
                        .frame(width: 85,height: 85)
                        .clipped()
                        .cornerRadius(5)
                        .padding(.leading,-3)
                }
                .padding(.bottom,-3)
                HStack{
                    ImageView(imagePath: diaryEntry[3])
                        .scaledToFill()
                        .frame(width: 85,height: 85)
                        .clipped()
                        .cornerRadius(5)
                    ImageView(imagePath: diaryEntry[4])
                        .scaledToFill()
                        .frame(width: 85,height: 85)
                        .clipped()
                        .cornerRadius(5)
                        .padding(.leading,-3)
                }
            }
            .padding(.leading,-3)
            Spacer()
        }
        .frame(width: 350,height: 175)
    }
}

struct RoughlyCardImage: View {
    var diaryEntry: [String]
    var count: Int
    @Binding var showImage: Bool  // 使用Binding变量来管理状态

    var body: some View {
        VStack {
            HStack {
                Spacer()
                ImageView(imagePath: diaryEntry[0])
                    .scaledToFill()
                    .frame(width: 173, height: 173)
                    .clipped()
                    .cornerRadius(5)
                VStack {
                    HStack {
                        ImageView(imagePath: diaryEntry[1])
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipped()
                            .cornerRadius(5)
                        ImageView(imagePath: diaryEntry[2])
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipped()
                            .cornerRadius(5)
                            .padding(.leading, -3)
                    }
                    .padding(.bottom, -3)
                    HStack {
                        ImageView(imagePath: diaryEntry[3])
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipped()
                            .cornerRadius(5)
                        ZStack {
                            ImageView(imagePath: diaryEntry[4])
                                .blur(radius: showImage ? 10 : 0)
                                .scaledToFill()
                                .frame(width: 85, height: 85)
                                .clipped()
                                .cornerRadius(5)
                                .padding(.leading, -3)
                            if showImage {
                                VStack {
                                    Text("+\(count-5)")
                                        .foregroundStyle(Color.white)
                                        .opacity(0.8)
                                        .font(.system(size: 30))
                                }
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                self.showImage = false
                            }
                        }
                    }
                }
                .padding(.leading, -3)
                Spacer()
            }
            .frame(width: 350, height: 175)
            if !showImage {
                RoughlyCardImageFollowUp(diaryEntry: diaryEntry, count: count)
            }
        }
        .frame(maxHeight: showImage ? 175 : 999999) // 这里调整视图的高度
        .animation(.easeInOut, value: showImage) // 确保动画平滑执行
    }
}

struct RoughlyCardImageFollowUp: View {
    var diaryEntry: [String]
    let count: Int

    // 预处理数据，确保不超出数组界限，且满足图片数量要求
    var filteredImages: [String] {
        let startIndex = min(5, diaryEntry.count)  // 从索引5开始，但要确保不超出数组界限
        let endIndex = min(count, diaryEntry.count)  // 最多到count，但不超出数组界限
        return Array(diaryEntry[startIndex..<endIndex])
    }

    var body: some View {
        VStack(alignment: .leading){
            // 每行显示4张图片，使用chunked方法分组（需实现此方法）
            ForEach(Array(filteredImages.chunked(into: 4)), id: \.self) { rowImages in
                HStack{
                    ForEach(rowImages, id: \.self) { image in
                        ImageView(imagePath: image)
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipped()
                            .cornerRadius(5)
                            .padding(.leading,3)
                            .padding(.horizontal,-4)
                    }
                    Spacer()
                }
                .frame(width: 350,height: 87)
                .padding(.leading,6)
            }
        }
        .frame(width: 350)
        .padding(.top,-5)
        .frame(maxHeight: 9999999)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}


func CountImage(item: DiaryEntry,showImage: Binding<Bool>) -> some View {
        var count:Int
        if let photos = item.photos {
            count = photos.count
        } else {
            return AnyView(EmptyView())
        }
        let sortedPhotos = (item.photos as? Set<Photo>)?.sorted(by: { $0.imageID < $1.imageID }) ?? []
        let diaryEntry:[String] = sortedPhotos.map { $0.imagePath! }
        switch count {
        case 0:
            return AnyView(EmptyView())
        case 1:
            return AnyView(RoughlyCardImage1(diaryEntry: diaryEntry))
        case 2:
            return AnyView(RoughlyCardImage2(diaryEntry: diaryEntry))
        case 3:
            return AnyView(RoughlyCardImage3(diaryEntry: diaryEntry))
        case 4:
            return AnyView(RoughlyCardImage4(diaryEntry: diaryEntry))
        case 5:
            return AnyView(RoughlyCardImage5(diaryEntry: diaryEntry))
        default:
            return AnyView(RoughlyCardImage(diaryEntry: diaryEntry,count: count,showImage: showImage)) // 默认情况下返回一个标准视图
        }
    }


