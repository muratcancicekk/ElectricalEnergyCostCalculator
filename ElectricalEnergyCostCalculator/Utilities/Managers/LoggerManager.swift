//
//  LoggerManager.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 19.07.2023.
//

import Foundation


enum LogLevel: String {
    case verbose = "VERBOSE"
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

final class LoggerManager {
    static var dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    static func log(_ level: LogLevel, _ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let dateString = getFormattedDate()
        let logString = "\(dateString) [\(level.rawValue)] [\(sourceFileName(filePath: file))]:\(line) \(function) -> \(message)"
        print(logString)
        
        // You can add code here to save the logString to a file, send it to a server, etc.
    }
    
    private static func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: Date())
    }
    
    private static func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}
