import Foundation

public struct Config {
    
    public enum EntityType {
        case `extension`
        case `class`
        case `struct`
        case `enum`
    }
    
    public let name: String
    public let entityType: EntityType
    public let localizationPath: URL
    public let additionalData: String?
}
