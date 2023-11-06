import Foundation

public struct ConfigReader {
    private let parser: IniParser
    
    public init() {
        self.parser = IniParser()
    }
    
    public func read(from path: URL) -> Config {
        guard let config = parser.parseConfig().values.first else {
            return Config(name: "RGenerated", entityType: .enum, localizationPath: path, additionalData: nil)
        }
        
        let name = config["name"] ?? "RGenerated"
        let entityType: Config.EntityType = config["entity_type"].flatMap { convert(from: $0) } ?? .enum
        let localizationPath = config["localization_path"].flatMap { URL(string: $0) } ?? path
        let additionalData = config["additional_data"]
        
        return Config(
            name: name,
            entityType: entityType,
            localizationPath: localizationPath,
            additionalData: additionalData
        )
    }
    
    private func convert(from value: String) -> Config.EntityType? {
        switch value {
        case "extension":
            return .extension
            
        case "class":
            return .class
            
        case "struct":
            return .struct
            
        case "enum":
            return .enum
            
        default:
            return nil
        }
    }
}
