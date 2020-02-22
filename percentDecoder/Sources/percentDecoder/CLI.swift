//
//  CLI.swift
//
//
//  Created by Stephen Martinez on 2/19/20.
//

import Foundation

public enum CLIError: Error {
    case argumentsNotProvided
    case invalidArguments(args: [String])
    case codingError(description: String)
    case copyError(description: String)
    
    public var message: String {
        switch self {
        case .argumentsNotProvided:
            return """
            
            percentDecoder
            
            A Tool that removes percent coding from a specified string
            
            Usage:
                percentDecoder "<A Value to Decode>"
            
            
            """
            
            
        case let .invalidArguments(args):
            let arguments = args.joined(separator: " ")
            return "\(arguments) are invalid"
            
        case let .codingError(description):
            return description
            
        case let .copyError(description):
            return "Copy to clipboard could not be completed: \(description)"
        }
        
    }
    
    public static func convertFromCoding(error: PercentDecoder.CodingError) -> CLIError {
        return .codingError(description: error.message)
    }
    
    
}


public enum Command {
    case decode(value: String)
}

public func parseUserInput(_ userInput: [String] = CommandLine.arguments) -> Result<Command, CLIError> {
    let commandInputs = Array(userInput.dropFirst())
    switch commandInputs.count {
    case 0:
        return .failure(.argumentsNotProvided)
    case 1:
        return .success(.decode(value: commandInputs[0]))
    default:
        return .failure(.invalidArguments(args: commandInputs))
    }
}

