import Foundation

public struct Finder {
    
    private let currentPath: URL
    private let fileManager: FileManager
    
    public init(
        currentPath: URL
    ) {
        self.currentPath = currentPath
        self.fileManager = .default
    }
    
    public func findFilesPaths(with extension: String) -> [URL] {
        findFilesPaths(with: [`extension`])
    }
    
    public func findFilesPaths(with extensions: [String]) -> [URL] {
        do {
            let files = try getListOfFilesPaths(at: currentPath)
            
            return files.filter { extensions.contains($0.pathExtension.lowercased()) }
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    private func getListOfFilesPaths(at path: URL) throws -> [URL] {
        var result: [URL] = []
        
        let enumerator = fileManager.enumerator(
            at: path,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: []
        )
        
        while let fullPath = enumerator?.nextObject() as? URL {
            var isDirectory: ObjCBool = false
            fileManager.fileExists(atPath: fullPath.absoluteString, isDirectory: &isDirectory)
            
            if isDirectory.boolValue {
                result.append(contentsOf: try getListOfFilesPaths(at: fullPath))
            } else {
                result.append(fullPath)
            }
        }
        
        return result
    }
}
