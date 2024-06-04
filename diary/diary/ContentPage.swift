//
//  ContentPage.swift
//  diary
//
//  Created by 琳琳夭 on 2024/5/28.
//

import SwiftUI

struct ContentPage: View {
    @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            entity: DiaryEntry.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \DiaryEntry.timestamp, ascending: false)]
        ) var items: FetchedResults<DiaryEntry>
    @State var showNewProject : Bool = false
    @State private var newEntry = NewDiaryEntry()  // 新日记条目的状态
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false) {
                ForEach(items,id: \.self) { item in
                            RoughlyCard(item: item)
                                .padding(.bottom, 30)
                                .shadow(color: .black, radius: 10, x: 0, y: 4) // 应用阴影
                    }
                .padding()
                }
                .navigationTitle("日记")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showNewProject = true
                            
                            print("按钮被点击")
                        }) {
                            Image(systemName: "plus") // 使用系统图标
                        }
                    }
                }
            }
            .sheet(isPresented: $showNewProject) {
                newProject(showNewProject: $showNewProject,newDiaryEntry: $newEntry)
                    .onDisappear {
                        saveImagesToCoreData(newEntry: newEntry)
                    }
            }
        }
    
    func saveImagesToCoreData(newEntry:NewDiaryEntry) {
        withAnimation {
            //        let context = PersistenceController.shared.viewContext
            //        let newPhoto = Photo(context: context)
            //        newPhoto.imagePath = saveImageToDocumentsDirectory(image: images)
            //        newPhoto.imageID = imageID
            //        newDiaryEntry.addToPhotos(newPhoto)
            let newDiaryEntry = DiaryEntry(context: viewContext)
            newDiaryEntry.element = newEntry.element
            newDiaryEntry.timestamp = newEntry.timestamp
            var n: Int16 = 1
            for image in newEntry.images {
                let newPhoto = Photo(context: viewContext)
                newPhoto.imagePath = saveImageToDocumentsDirectory(image: image)
                newPhoto.imageID = n
                n = n+1
                newDiaryEntry.addToPhotos(newPhoto)
            }
            do {
                try viewContext.save()
            } catch {
                print("保存失败")
            }
        }
    }
}


struct NewDiaryEntry {
    var timestamp: Date = Date()  // 使用Date类型而非Data
    var element: String = ""
    var images: [UIImage] = []
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


#Preview {
    ContentPage()
}

func saveImageToDocumentsDirectory(image: UIImage) -> String? {
    let fileName = UUID().uuidString + ".jpeg"
    guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("Documents directory is not accessible.")
        return nil
    }

    let fileURL = documentsDirectory.appendingPathComponent(fileName)

    guard let data = image.jpegData(compressionQuality: 1.0) else {
        print("Unable to convert image to JPEG data.")
        return nil
    }

    do {
        try data.write(to: fileURL)
        print("Saved image at path: \(fileURL.path)")
        return fileURL.path
    } catch {
        print("Error saving image: \(error)")
        return nil
    }
}
