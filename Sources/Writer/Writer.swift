import Foundation
import Config

public struct Writer {
    
    private let strategy: WriterStrategy
    
    public init(
        type: Config.EntityType,
        name: String
    ) {
        switch type {
        case .extension:
            self.strategy = ExtensionWriterStrategy()
            
        case .class:
            self.strategy = ClassWriterStrategy(name: name)
            
        case .struct:
            self.strategy = StructWriterStrategy(name: name)
            
        case .enum:
            self.strategy = EnumWriterStrategy(name: name)
        }

    }
    
    public func write(translates: [TranslateDTO], path: URL) {
        let result = makeString(translates: translates)
        
        do {
            try result.write(to: path, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func makeString(translates: [TranslateDTO]) -> String {
        var result = "import Foundation"
        
        let newLine = {
            result.append("\n")
        }
        
        newLine()
        newLine()
        result.append(strategy.header)
        
        for translate in translates {
            newLine()
            newLine()
            result.append("    /// \(translate.value)")
            newLine()
            result.append("    static let \(translate.key) = NSLocalizedString(\"\(translate.key)\", comment: \"\")")
        }
        
        newLine()
        result.append("}")
        
        return result
    }
}
