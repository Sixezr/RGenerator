import Foundation

public struct DictionaryToDomainConverter {
    public init() {}
    
    public func convert(from dictionary: [String: String]) -> [Translate] {
        var result: [Translate] = []
        var addedKeys: Set<String> = []
        
        for key in dictionary.keys {
            guard
                !addedKeys.contains(key),
                let value = dictionary[key]
            else { continue }
            
            addedKeys.insert(key)
            result.append(Translate(key: convertToCamelCase(from: key), value: value))
        }
        
        return result
    }
    
    private func convertToCamelCase(from key: String) -> String {
        var words: [String] = []
        let wordSeparators: CharacterSet = [" ", "_", "-", "."]
        
        key.unicodeScalars.split(whereSeparator: { wordSeparators.contains($0) }).forEach { word in
            if words.isEmpty {
                words.append(String(word))
            } else {
                words.append(String(word).capitalized)
            }
        }
        
        return words.joined()
    }
}
