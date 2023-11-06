import Foundation

protocol WriterStrategy {
    var header: String { get }
}

struct EnumWriterStrategy: WriterStrategy {
    
    var header: String {
        "enum \(name) {"
    }
    
    private let name: String
    
    init(
        name: String
    ) {
        self.name = name
    }
}

struct ClassWriterStrategy: WriterStrategy {
    
    var header: String {
        "final class \(name) {"
    }
    
    private let name: String
    
    init(
        name: String
    ) {
        self.name = name
    }
}

struct StructWriterStrategy: WriterStrategy {
    
    var header: String {
        "struct \(name) {"
    }
    
    private let name: String
    
    init(
        name: String
    ) {
        self.name = name
    }
}

struct ExtensionWriterStrategy: WriterStrategy {
    var header: String {
        "extension String {"
    }
}
