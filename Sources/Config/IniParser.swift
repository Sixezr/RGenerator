import Foundation

typealias IniSectionConfig = [String: String]
typealias IniConfig = [String: IniSectionConfig]

struct IniParser {
    
    @Argument(index: 1) private var iniPath: String
    
    func parseConfig() -> IniConfig {
        let f = try! String(contentsOfFile: iniPath)
        var config = IniConfig()
        var currentSectionName = "main"
        for line in f.components(separatedBy: "\n") {
            let line = trim(line)
            if line.hasPrefix("[") && line.hasSuffix("]") {
                currentSectionName = parseSectionHeader(line)
            } else if let (k, v) = parseLine(line) {
                var section = config[currentSectionName] ?? [:]
                section[k] = v
                config[currentSectionName] = section
            }
        }
        return config
    }
    
    private func trim(_ s: String) -> String {
        let whitespaces = CharacterSet(charactersIn: " \n\r\t")
        return s.trimmingCharacters(in: whitespaces)
    }


    private func stripComment(_ line: String) -> String {
        let parts = line.split(
          separator: "#",
          maxSplits: 1,
          omittingEmptySubsequences: false)
        if parts.count > 0 {
            return String(parts[0])
        }
        return ""
    }


    private func parseSectionHeader(_ line: String) -> String {
        let from = line.index(after: line.startIndex)
        let to = line.index(before: line.endIndex)
        return String(line[from..<to])
    }

    private func parseLine(_ line: String) -> (String, String)? {
        let parts = stripComment(line).split(separator: "=", maxSplits: 1)
        if parts.count == 2 {
            let k = trim(String(parts[0]))
            let v = trim(String(parts[1]))
            return (k, v)
        }
        return nil
    }
}
