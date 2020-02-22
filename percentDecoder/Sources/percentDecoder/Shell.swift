//
//  Shell.swift
//  
//
//  Created by Stephen Martinez on 2/22/20.
//

import Foundation

public struct Shell {
    
    public static func copyToClipboard(_ text: String) -> Result<String, CLIError> {
        let connectingPipe = Pipe()
        
        let echo = Process()
        echo.launchPath = "/usr/bin/env"
        echo.arguments = ["echo", "-n", text]
        echo.standardOutput = connectingPipe
        
        let copy = Process()
        copy.launchPath = "/usr/bin/env"
        copy.arguments = ["pbcopy"]
        copy.standardInput = connectingPipe
        
        let errorPipe = Pipe()
        copy.standardError = errorPipe
        
        echo.launch()
        copy.launch()
        copy.waitUntilExit()
        
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        
        guard
            let errorMessage = String(data: errorData, encoding: .utf8),
            !errorMessage.isBlank
            else { return .success(text) }
        
        return .failure(.copyError(description: errorMessage))
        
    }
    
}

extension String {
    
    var isBlank: Bool { allSatisfy { $0.isWhitespace } }
    
}
