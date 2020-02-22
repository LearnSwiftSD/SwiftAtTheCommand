import Foundation

switch parseUserInput()
    .flatMap(PercentDecoder.resolve)
    .flatMap(Shell.copyToClipboard) {
case let .success(value):
    print("Copied to Clipboard: \(value)")
    exit(0)
case let .failure(error):
    print(error.message)
    exit(1)
}
