//
//  ContentView.swift
//  iOSCrashlyticsTest
//
//  Created by 武田孝騎 on 2022/06/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var stringToIntObject: StringToInt
    
    @State private var simpleDomainErrorExampleTestString: String = ""
    @State private var simpleDomainErrorExampleResultNumber: Int? = nil
    @State private var simpleDomainErrorExampleErrorDescription: String = "no error"
    
    @State private var recoverableErrorExampleTestString: String = ""
    @State private var recoverableErrorExampleResultNumber: Int? = nil
    @State private var recoverableErrorExampleErrorDescription: String = "no error"
    
    @State private var universalErrorExampleTestString: String = ""
    @State private var universalErrorExampleResultNumber: Int = -1
    
    @State private var logicFailureExampleTestString: String = ""
    @State private var logicFailureExampleResultNumber: Int = -1
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Group {
                Text("simple Domain Error Example")
                HStack {
                    Text("StringToInt:")
                    TextField(
                        "Test String",
                        text: $simpleDomainErrorExampleTestString
                    )
                    .onSubmit {
                        switch stringToIntObject.simpleDomainErrorExample(string: simpleDomainErrorExampleTestString) {
                        case let .success(resultNumberRow):
                            simpleDomainErrorExampleResultNumber = resultNumberRow
                            simpleDomainErrorExampleErrorDescription = "no error"
                        case let .failure(error):
                            simpleDomainErrorExampleResultNumber = nil
                            simpleDomainErrorExampleErrorDescription = error.description ?? "未知のエラー"
                        }
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                }
                Text("input String: \(simpleDomainErrorExampleTestString)")
                HStack {
                    Text("output result:")
                    if let message = simpleDomainErrorExampleResultNumber {
                        Text("\(message)")
                            .foregroundColor(.green)
                    } else {
                        Text("error")
                            .foregroundColor(.red)
                    }
                }
                Text("message: \(simpleDomainErrorExampleErrorDescription)")
                    .foregroundColor(.gray)
            }
            
            Divider()
            Group {
                Text("recoverable Error Example")
                HStack {
                    Text("StringToInt:")
                    TextField(
                        "Test String",
                        text: $recoverableErrorExampleTestString
                    )
                    .onSubmit {
                        let result = stringToIntObject.recoverableErrorExample(string: recoverableErrorExampleTestString)
                        switch result {
                        case let .success(resultNumberRow):
                            recoverableErrorExampleResultNumber = resultNumberRow
                            recoverableErrorExampleErrorDescription = "no error"
                        case let .failure(error):
                            recoverableErrorExampleResultNumber = nil
                            recoverableErrorExampleErrorDescription = error.description ?? "未知のエラー"
                        }
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                }
                Text("input String: \(recoverableErrorExampleTestString)")
                HStack {
                    Text("output result:")
                    if let message = recoverableErrorExampleResultNumber {
                        Text("\(message)")
                            .foregroundColor(.green)
                    } else {
                        Text("error")
                            .foregroundColor(.red)
                    }
                }
                Text("message: \(recoverableErrorExampleErrorDescription)")
                    .foregroundColor(.gray)
            }
            
            Divider()
            Group {
                Text("universal Error Example")
                HStack {
                    Text("StringToInt:")
                    TextField(
                        "Test String",
                        text: $universalErrorExampleTestString
                    )
                    .onSubmit {
                        universalErrorExampleResultNumber = stringToIntObject.universalErrorExample(string: universalErrorExampleTestString)
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                }
                Text("input String: \(universalErrorExampleTestString)")
                HStack {
                    Text("output result:")
                    if let message = universalErrorExampleResultNumber {
                        Text("\(message)")
                            .foregroundColor(.green)
                    }
                }
            }
            
            Divider()
            Group {
                Text("logic Failure Example")
                HStack {
                    Text("StringToInt:")
                    TextField(
                        "Test String",
                        text: $logicFailureExampleTestString
                    )
                    .onSubmit {
                        logicFailureExampleResultNumber = stringToIntObject.logicFailureExample(string: logicFailureExampleTestString)
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                }
                Text("input String: \(logicFailureExampleTestString)")
                HStack {
                    Text("output result:")
                    if let message = logicFailureExampleResultNumber {
                        Text("\(message)")
                            .foregroundColor(.green)
                    }
                }
            }
        }
        .padding([.leading, .trailing], 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13", "iPod touch (7th generation)"], id: \.self) { deviceName in
            ContentView(stringToIntObject: StringToInt())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
