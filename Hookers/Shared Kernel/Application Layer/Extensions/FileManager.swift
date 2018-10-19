//
//  FileManager.swift
//  Hookers
//
//  Created by Kirill on 15.12.2018.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation

extension FileManager {
    
    private static var fileManager = FileManager.default
    
    private static let documentsDirectoryURL: URL = {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }()
    
    private static let localFilesDirectoryURL: URL = {
        // RS: для локальных файлов создаем отделбную папку в documentDirectory.
        let localFilesDirectoryURL = documentsDirectoryURL.appendingPathComponent("LocalFiles")
        
        if fileManager.fileExists(atPath: localFilesDirectoryURL.path) == false {
            try? fileManager.createDirectory(at: localFilesDirectoryURL, withIntermediateDirectories: false, attributes: nil)
        }
            
        return localFilesDirectoryURL
    }()
    
    static func sqliteFilePath(by fileName: String) -> URL {
        let url = documentsDirectoryURL.appendingPathComponent(fileName + ".sqlite")
        return url
    }
    
    static func getFilePath(_ fileName: String, fileExtension: String) -> String {        
        return localFilesDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)").absoluteString
    }
    
    static func saveDataToDisk(_ data: Data, fileName: String, fileExtension: String) -> (Error?, URL?) {
        let url = localFilesDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)")
        do {
            try data.write(to: url)
            
            return (nil, url)
        } catch let error {
            return (error, nil)
        }
    }
    
    static func removeFileFromDisk(_ fileName: String, fileExtension: String) -> Error? {
        let url = localFilesDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)")
        do {
            try fileManager.removeItem(at: url)
            
            return nil
        } catch let error {
            return error
        }
    }
    
    static func fileData(_ fileName: String, fileExtension: String) -> Data? {
        let url = localFilesDirectoryURL.appendingPathComponent("\(fileName).\(fileExtension)")
        guard let data = NSData(contentsOf: url) as Data? else {
            return nil
        }
        
        return data
    }
    
    static func removeAllLocalFilesIfPossible() {
        guard let filePaths = try? fileManager.contentsOfDirectory(at: localFilesDirectoryURL, includingPropertiesForKeys: nil, options: []) else { return }
        
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
    
}
