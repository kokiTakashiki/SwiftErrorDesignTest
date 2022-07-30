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
            Crashlytics.crashlytics().log("log \(String(describing: ToIntError.simpleDomainError.description))")
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
        throw ToIntError.simpleDomainError
    }
    func recoverableErrorExample(string: String) -> Result<Int, ToIntError> {
        do {
            let number = try recoverableErrorExampleToInt(string)
            Crashlytics.crashlytics().log("success \(number)")
            return .success(number)
        } catch ToIntError.recoverableError {
            //print("\(10)〜\(20)の値を入力して下さい。")
            Crashlytics.crashlytics().record(error: ToIntError.recoverableError)
            Crashlytics.crashlytics().log("log \(String(describing: ToIntError.recoverableError.description))")
            return .failure(ToIntError.recoverableError)
        } catch {
            //print("整数を入力して下さい。")
            Crashlytics.crashlytics().record(error: ToIntError.simpleDomainError)
            Crashlytics.crashlytics().log("log \(String(describing: ToIntError.simpleDomainError.description))")
            return .failure(ToIntError.simpleDomainError)
        }
    }
    
    // Universal error
    /*
     整数に変換できないような不正な文字列が toInt に渡されたらプログラムが停止すればいい、エラー処理をする必要はないと、考える場合に採用します。
     */
    func universalErrorExample(string: String) -> Int {
        guard let number = Int(string) else {
            Crashlytics.crashlytics().record(error: ToIntError.universalError)
            Crashlytics.crashlytics().log("log Crash was \(String(describing: ToIntError.universalError.description))")
            fatalError(String(describing: ToIntError.universalError.description))
        }
        Crashlytics.crashlytics().log("success \(number)")
        return number
    }
    
    // Logic failure
    /*
     整数に変換できない文字列を toInt に渡していること自体がバグだ、コードを修正する必要がある、と考える場合に採用します。
     Logic failure は実行時に起こってはいけないので、起こった場合の挙動は未定義です。
     */
    func logicFailureExample(string: String) -> Int {
        guard let number = Int(string) else {
            Crashlytics.crashlytics().record(error: ToIntError.logicFailure)
            Crashlytics.crashlytics().log("log Crash was \(String(describing: ToIntError.logicFailure.description))")
            preconditionFailure(String(describing: ToIntError.logicFailure.description))
        }
        Crashlytics.crashlytics().log("success \(string)")
        return number
    }
}
