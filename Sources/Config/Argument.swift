import Foundation

@propertyWrapper
struct Argument {
    let index: Int
    var value: String?

    init(index: Int) {
        self.index = index
        self.value = index < CommandLine.arguments.count ? CommandLine.arguments[index] : nil
    }

    var wrappedValue: String {
        get {
            guard let value = value else {
                fatalError("Аргумент с индексом \(index) не был передан")
            }
            return value
        }
        set {
            value = newValue
        }
    }
}

