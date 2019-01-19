import Foundation
import Basic
import Utility

let commandName = "swift-gyb"
let usage = "swift-gyb <file.swift.gyb>"
let overview = """
Evaluates a Swift GYB script.
"""

do {
    let parser = ArgumentParser(commandName: commandName, usage: usage, overview: overview)
    let filename = parser.add(positional: "filename", kind: String.self)

    let args = Array(CommandLine.arguments.dropFirst())
    let result = try parser.parse(args)

    guard let path = result.get(filename) else {
        throw ArgumentParserError.expectedArguments(parser, ["filename"])
    }

    let url = URL(fileURLWithPath: path)

    let tempfile = try TemporaryFile()

    let gyb = Process()
    gyb.launchPath = "/usr/bin/env"
    gyb.arguments = ["gyb", url.path]
    gyb.standardOutput = tempfile.fileHandle
    gyb.launch()
    gyb.waitUntilExit()

    guard gyb.terminationStatus == 0 else {
        exit(gyb.terminationStatus)
    }

    let swift = Process()
    swift.launchPath = "/usr/bin/env"
    swift.arguments = ["swift", tempfile.path.asString]
    swift.launch()
    swift.waitUntilExit()

    exit(swift.terminationStatus)
} catch ArgumentParserError.expectedArguments {
    print("error: invalid usage")
    print(usage)
    exit(3)
} catch {
    print(error.localizedDescription)
    exit(2)
}
