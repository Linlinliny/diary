//
//  SwiftUIView.swift
//  diary
//
//  Created by 琳琳夭 on 2024/6/2.
//

import SwiftUI
import PhotosUI
import Combine
import CoreData

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.parent.images.append(image)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct newProject: View {
    @Binding var showNewProject : Bool
    @State var showImage = false
    @State private var images: [UIImage] = []
    @State private var showPhotoPicker = false
    @State var text = "请开始记录"
    @State var datan:Date = Date()
    @Binding var newDiaryEntry :NewDiaryEntry
    //@ObservedObject private var keyboard = KeyboardResponder() // 实例化 KeyboardResponder
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                //CountImage(item: newDiaryEntry, showImage: $showImage)
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipped()
                            .cornerRadius(5)
                            .padding(.leading,3)
                            .padding(.horizontal,-4)
                    }
                }
                ScrollView(){
                        TextEditor(text: $text)
                            .padding(.top,-20)
                            .padding()
                            .frame(minHeight: 200, maxHeight: .infinity)
                        
                    }
                    HStack{
                        Spacer()
                        Button(action: {
                            showPhotoPicker = true
                        }) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .resizable()
                                .padding()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(90)
                        }
                        .offset(x:-20)
                    }
                    
                }
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text(formattedDate(date: datan))
                                .font(.headline)
                            Button(action: {
                                // 按钮的操作
                                print("按钮被点击")
                            }) {
                                Image(systemName: "pencil.line") // 使用系统图标
                            }
                            .padding(.leading,-10)
                            Spacer()
                            Button(action: {
                                newDiaryEntry.images = images
                                newDiaryEntry.timestamp = datan
                                newDiaryEntry.element = text
                                showNewProject = false
                                
                                //newDiaryEntry.timestamp = datan
                                //newDiaryEntry.element = text
                            }, label: {
                                Text("完成")
                            })
                            .padding(.horizontal,0)
                        }
                        .frame(width: 380)
                        .background(Color.white)
                    }
                    
                }
                .sheet(isPresented: $showPhotoPicker) {
                    PhotoPicker(images: $images)
                }
            }
        }
    }

//    func newDiary(images: inout [UIImage], DiaryEntry: inout DiaryEntry, n: inout Int16) {
//        for image in images {
//                saveImagesToCoreData(images: image, newDiaryEntry: &DiaryEntry, imageID: n)
//                n += 1
//        }
//        images = []
//    }




func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 EEEE"
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: date)
    }



// 创建一个 ObservableObject 用于监听键盘的显示和隐藏
//class KeyboardResponder: ObservableObject {
//    @Published var currentHeight: CGFloat = 0
//    private var cancellable: AnyCancellable?
//
//    init() {
//        // 使用 Combine 监听键盘显示和隐藏的通知
//        cancellable = Publishers.Merge(
//            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
//                .map { $0.keyboardHeight },
//            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
//                .map { _ in CGFloat(0) }
//        )
//        .assign(to: \.currentHeight, on: self)
//    }
//}
//
//// 扩展 Notification 以便获取键盘的高度
//extension Notification {
//    var keyboardHeight: CGFloat {
//        // 从通知中获取键盘的高度
//        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
//    }
//}





