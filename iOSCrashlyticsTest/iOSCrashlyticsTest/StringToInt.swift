//
//  StringToInt.swift
//  iOSCrashlyticsTest
//
//  Created by 武田孝騎 on 2022/07/15.
//

import Foundation
import FirebaseCrashlytics

class StringToInt: ObservableObject {
    // 参考：https://qiita.com/koher/items/a7a12e7e18d2bb7d8c77

    // Simple domain error
    /*
     文字列→整数の変換に失敗するなんて原因は明白なんだから、エラーが起こったかどうかさえわかればいいんだ、
     と考える場合に採用します。エラーが発生したことだけを伝え、その原因についての情報は伝えません。
     */
    private func simpleDomainErrorExampleToInt(_ string: String) -> Int? {
        return Int(string)
    }
    func simpleDomainErrorExample(string: String) -> Result<Int, ToIntError> {
        guard let number = simpleDomainErrorExampleToInt(string) else {
            Crashlytics.crashlytics().record(error: ToIntError.simpleDomainError)
            return .failure(.simpleDomainError)
        }
        Crashlytics.crashlytics().log("success \(number)")
        return .success(number)
    }

    // Recoverable error
    /*
     文字列→整数の変換であっても、原因によって処理の方法が異なるだろう、と考える場合に採用します。
     */
    private func recoverableErrorExampleToInt(_ string: String) throws -> Int {
        if let result = Int(string) {
            if result < 10 || result > 20 {
                throw ToIntError.recoverableError
            } else {
                return result
            }
        }
        throw ToIntError.recoverableError
    }
    func recoverableErrorExample(string: String) -> Result<Int, ToIntError> {
        do {
            let number = try recoverableErrorExampleToInt(string)
            Crashlytics.crashlytics().log("success \(number)")
            return .success(number)
        } catch ToIntError.recoverableError {
            //print("\(10)〜\(20)の値を入力して下さい。")
            Crashlytics.crashlytics().record(error: ToIntError.recoverableError)
            return .failure(ToIntError.recoverableError)
        } catch {
            //print("整数を入力して下さい。")
            Crashlytics.crashlytics().record(error: ToIntError.simpleDomainError)
            return .failure(ToIntError.simpleDomainError)
        }
    }
    
    // Universal error
    func universalErrorExample(string: String) -> Int {
        guard let number = Int(string) else {
            Crashlytics.crashlytics().record(error: ToIntError.universalError)
            Crashlytics.crashlytics().log("log Crash was \(String(describing: ToIntError.universalError.description))")
            fatalError(String(describing: ToIntError.universalError.description))
        }
        Crashlytics.crashlytics().log("success \(number)")
        return number
    }
}
