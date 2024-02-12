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

    // Save the image and return the filename
    func saveImageToDocumentDirectory(_ image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        let fileName = UUID().uuidString + ".png"
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }

    // Get the path for the image with the given filename
    func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: \(error)")
            return nil
        }
    }

    // Helper method to get the documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }


}
