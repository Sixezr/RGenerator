import Foundation
import FileFinder
import Converter
import Parser
import Writer
import Config

let currentPath = URL(filePath: FileManager.default.currentDirectoryPath)

let configReader = ConfigReader()
let config = configReader.read(from: currentPath)

let finder = Finder(currentPath: currentPath.appending(path: "../"))
let paths = finder.findFilesPaths(with: ["strings"])

guard let path = paths.first else { exit(1) }
let parser = Parser()
let dictionary = parser.parse(from: path)

let converter = DictionaryToDomainConverter()
let translates = converter.convert(from: dictionary)

let writer = Writer(type: config.entityType, name: config.name)
writer.write(
    translates: translates.map { TranslateDTO(key: $0.key, value: $0.value) },
    path: currentPath.appending(path: config.localizationPath.absoluteString)
)
