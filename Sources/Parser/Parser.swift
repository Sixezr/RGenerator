import Foundation

public struct Parser {
    public init() {}
    
    public func parse(from url: URL) -> [String: String] {
        let result = NSDictionary(contentsOf: url) as? [String: String]
        return result ?? getDictionaryFromJson(url)
    }
    
    private func getDictionaryFromJson(_ url: URL) -> [String: String] {
        do {
            let content = try String(contentsOfFile: url.relativePath, encoding: .utf8)
            return parseKeyValueFile(content)
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
    
    private func parseKeyValueFile(_ content: String) -> [String: String] {
        let lines = content.split(whereSeparator: \.isNewline)
        var dictionary: [String: String] = [:]
        
        for line in lines {
            let line = line.trimmingCharacters(in: .whitespacesAndNewlines)
            let parts = line.split(separator: ":", maxSplits: 1).map { String($0.trimmingCharacters(in: .whitespaces)) }
            if parts.count == 2, let key = parts[0].strippedQuotes(), let value = parts[1].strippedExtraSymbols() {
                dictionary[key] = value
            }
        }
        
        return dictionary
    }
}

private extension String {
    func strippedQuotes() -> String? {
        let trimOutsideQuotes = self.trimmingCharacters(in: .whitespaces)
        if trimOutsideQuotes.first == "\"", trimOutsideQuotes.last == "\"" {
            return String(trimOutsideQuotes.dropFirst().dropLast())
        } else {
            return nil
        }
    }
    
    func strippedExtraSymbols() -> String? {
        let trimExtraSymbols = self.trimmingCharacters(in: [";", " "])
        return strippedQuotes() ?? (trimExtraSymbols.isEmpty ? nil : trimExtraSymbols)
    }
}
