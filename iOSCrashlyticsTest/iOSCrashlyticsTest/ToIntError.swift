//
//  ToIntError.swift
//  iOSCrashlyticsTest
//
//  Created by 武田孝騎 on 2022/06/30.
//

import Foundation

enum ToIntError: Error {
    case simpleDomainError
    case recoverableError
    case universalError
    case logicFailure
}

extension ToIntError: LocalizedError {
    var description: String? {
        switch self {
        case .simpleDomainError: return "simple domain error happened"
        case .recoverableError: return "recoverable error happened"
        case .universalError: return "universal error happened"
        case .logicFailure: return "logic failure happened"
        }
    }
}
