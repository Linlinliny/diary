//
//  AppDelegate.swift
//  diary
//
//  Created by 琳琳夭 on 2024/5/29.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createAppDirectories()
        return true
    }

    func createAppDirectories() {
        let fileManager = FileManager.default
        
        if let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let photosDirectory = documentsDirectory.appendingPathComponent("Photos")
            
            if !fileManager.fileExists(atPath: photosDirectory.path) {
                do {
                    try fileManager.createDirectory(at: photosDirectory, withIntermediateDirectories: true, attributes: nil)
                    print("Photos directory created at \(photosDirectory.path)")
                } catch {
                    print("Failed to create Photos directory: \(error)")
                }
            }
        }
    }
    
    
}
