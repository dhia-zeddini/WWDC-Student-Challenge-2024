//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 10/2/2024.
//

import Foundation
import SwiftUI
class ImageStorageService {
    
    static let shared = ImageStorageService()

    init() {}

    func saveImageToDocumentDirectory(_ selectedImage: UIImage?) -> String? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory?.appendingPathComponent("\(fileName).png")
        
        if let data = selectedImage?.pngData(), let fileURL = fileURL {
            do {
                try data.write(to: fileURL)
                return fileURL.path 
            } catch {
                print("Unable to save image to document directory", error)
            }
        }
        return nil
    }
    
    func loadImageFromDocumentDirectory(path: String) -> UIImage? {
        let fileURL = URL(fileURLWithPath: path)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }

}
