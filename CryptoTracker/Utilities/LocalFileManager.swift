//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 16/4/25.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    private init() {}
    static let imageFolderName = "coin_images"
    
    func saveImage(image: UIImage, folderName: String, imageName: String) {
        // create folder
        createFolderIfNeeded(folderName: folderName)
        
        // get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(folderName: folderName, imageName: imageName)
        else { return }
        
        // save image to path
        do {
            try data.write(to: url)
        } catch {
            print("[‼️] Error saving image -> Image name: \(imageName), Error: \(error.localizedDescription)")
        }
    }
    
    func getImage(folderName: String, imageName: String) -> UIImage? {
        guard let imageURL = getURLForImage(folderName: folderName, imageName: imageName),
              FileManager.default.fileExists(atPath: imageURL.path)
        else {
            print("[‼️] No local image found for -> Image name: \(imageName)")
            return nil
        }
        return UIImage(contentsOfFile: imageURL.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let folderURL = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("[‼️] Error creating directory -> Folder name: \(folderName), Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
     
    private func getURLForImage(folderName: String, imageName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName)
    }
    
}
