//
//  ContentView.swift
//  iOSCrashlyticsTest
//
//  Created by 武田孝騎 on 2022/06/24.
//

import SwiftUI

struct ContentView: View {
    
    //    var body: some View {
    //        VStack{
    //            Text("Hello, world!")
    //                .padding()
    //            Button("Crash") {
    //                Crashlytics.crashlytics().log("log Crash was triggered")
    //                fatalError("Crash was triggered")
    //            }
    //
    //        }
    //        .onAppear(perform: {
    //            Crashlytics.crashlytics().log("ContentView Appear")
    //            simpleDomainErrorExample(string: "test")
    //        })
    //    }
    @ObservedObject var stringToIntObject: StringToInt
    
    @State private var testString: String = ""
    @State private var simpleDomainErrorExampleResultNumber: Int? = nil
    @State private var simpleDomainErrorExampleErrorDescription: String = "no error"
    
    @State private var recoverableErrorExampleResultNumber: Int? = nil
    @State private var recoverableErrorExampleErrorDescription: String = "no error"
    
    @State private var universalErrorExampleResultNumber: Int = -1
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Group {
                Text("simpleDomainErrorExample")
                HStack {
                    Text("StringToInt:")
                    TextField(
                        "Test String",
                        text: $testString
                    )
                    .onSubmit {
                        switch stringToIntObject.simpleDomainErrorExample(string: testString) {
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
                Text("input String: \(testString)")
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
                Text("recoverableErrorExample")
                HStack {
                    Text("StringToInt:")
                    TextField(
                        "Test String",
                        text: $testString
                    )
                    .onSubmit {
                        let result = stringToIntObject.recoverableErrorExample(string: testString)
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
                Text("input String: \(testString)")
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
                Text("universalErrorExample")
                HStack {
                    Text("StringToInt:")
                    TextField(
                        "Test String",
                        text: $testString
                    )
                    .onSubmit {
                        universalErrorExampleResultNumber = stringToIntObject.universalErrorExample(string: testString)
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                }
                Text("input String: \(testString)")
                HStack {
                    Text("output result:")
                    if let message = universalErrorExampleResultNumber {
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
