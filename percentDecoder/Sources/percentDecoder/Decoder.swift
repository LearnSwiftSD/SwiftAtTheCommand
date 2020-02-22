//
//  Decoder.swift
//  
//
//  Created by Stephen Martinez on 2/22/20.
//

import Foundation

public struct PercentDecoder {
    
    public enum CodingError: Error {
        case decoding(value: String)
        
        public var message: String {
            switch self {
            case let .decoding(value):
                return "Could not percent decode: \(value)"
            }
        }
        
    }
    
    
    public static func resolve(command: Command) -> Result<String, CLIError> {
        switch command {
        case let .decode(value):
            return decode(value).mapError(CLIError.convertFromCoding)
        }
    }
    
    
    public static func decode(_ value: String) -> Result<String, CodingError> {
        guard let decodedValue = value.removingPercentEncoding else {
            return .failure(.decoding(value: value))
        }
        return .success(decodedValue)
    }
    
    
}
