//
//  CommonTextField.swift
//  InfoWebiOS
//
//  Created by lyborey on 29/11/23.
//

import SwiftUI
import Combine
import UIKit

struct CustomTextField<Content: View>: View {
    
    @Binding var text: String
    var countryCode: String = ""
    var placeHolder: String
    var placeHolderType: PlaceHolderType = .inner
    var charLimit: Int = 254
    var keyboardType: UIKeyboardType = .default
    var fieldtype: TextFieldType = .normal
    var isMultiLine: Bool = false
    var isStarMark: Bool = false
    var isDisable: Bool = false
    var isAutoCapitalize: UITextAutocapitalizationType = .sentences
    let content: Content
    var onTextChange: ((String) -> Void)?
    var onSelectCountry: ((String) -> Void)?
    
    @State var textField = UITextField()
    @State var eyeToggle = false
    @State var isPresentCountry = false
    @State var isFocus = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if placeHolderType == .outside {
                HStack(spacing: 0) {
                    TextSwiftUI(title: placeHolder)
                    if isStarMark {
                        Text("  *")
                            .foregroundColor(.red)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                if placeHolderType == .above {
                    HStack(spacing: 0) {
                        TextSwiftUI(title: placeHolder, size: .small, color: .main)
                        if isStarMark {
                            Text(" *")
                                .foregroundColor(.red)
                        }
                    }
                }
                HStack {
                    if Int(text) != nil && fieldtype == .emailOrPhone {
                        Button {
                            isPresentCountry.toggle()
                        } label: {
                            HStack {
                                TextSwiftUI(title: countryCode, color: .gray)
                                Image(.arrowDown)
                                Image(.horiDivider)
                                    .resizable()
                                    .frame(width: 1, height: 25)
                            }
                        }
                    }
                    if isMultiLine {
                        ZStack(alignment: .topLeading) {
                            UITextViewWrapper(text: $text, isFocus: $isFocus)
                                .padding(.leading, -4)
                                .onReceive(Just(text)) { newString in
                                    if charLimit > 0 {
                                        if newString.count > charLimit {
                                            text = String(newString.prefix(charLimit))
                                        }
                                    }
                                }
                                .font(.system(size: 14))
                                .frame(height: 150)
                            if text.isEmpty {
                                TextSwiftUI(title: placeHolder + "\(isStarMark ? " *" : "")",
                                            size: .medium, color: .gray)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                    } else {
                        UITextFieldWrapper(
                            fieldtype: fieldtype,
                            keyboardType: keyboardType, 
                            placerHolder: placeHolderType == .inner ? placeHolder : "",
                            isStarMark: isStarMark,
                            isAutoCapitalize: isAutoCapitalize,
                            text: $text,
                            textField: $textField,
                            isFocus: $isFocus)
                        .onChange(of: text) { value in
                            onTextChange?(value)
                        }
                        .onReceive(Just(text)) { newString in
                            if charLimit > 0 {
                                if newString.count > charLimit {
                                    text = String(newString.prefix(charLimit))
                                }
                            }
                        }
                        .frame(height: 25)
                        .disabled(isDisable)
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 52)
                .clipped(antialiased: true)
            }
            .overlay(
                HStack {
                    Spacer()
                    if fieldtype == .password {
                        Image(eyeToggle ? .eyeClose : .eyeClose)
                            .onTapGesture {
                                eyeToggle.toggle()
                                if eyeToggle {
                                    textField.isSecureTextEntry = false
                                } else {
                                    textField.isSecureTextEntry = true
                                }
                            }
                    } else {
                        content
                    }
                }
            )
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: charLimit == maxLimitOtp ? 10 : 20))
            .background(isDisable ? Color.textfieldDisable: .textfieldbackground)
            .cornerRadius(isMultiLine ? 15 : 30)
            .onTapGesture {
                textField.becomeFirstResponder()
            }
        }
        .sheet(isPresented: $isPresentCountry) {
            PickCountryCodeView(isPresentCountry: $isPresentCountry) { value in
                onSelectCountry?(value)
            }
        }
    }
}

struct UITextFieldWrapper: UIViewRepresentable {
    var fieldtype: TextFieldType = .normal
    var keyboardType: UIKeyboardType = .default
    var placerHolder: String
    var isStarMark: Bool
    var isAutoCapitalize: UITextAutocapitalizationType = .sentences
    @Binding var text: String
    @Binding var textField: UITextField
    @Binding var isFocus: Bool
    
    func makeUIView(context: Context) -> UITextField {
        textField.delegate = context.coordinator
        textField.font = .systemFont(ofSize: 14)
        textField.keyboardType = keyboardType
        textField.autocapitalizationType = isAutoCapitalize
        textField.attributedPlaceholder = NSAttributedString(
            string: placerHolder + "\(isStarMark ? " *" : "")",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        if fieldtype == .password {
            textField.isSecureTextEntry = true
        } else if fieldtype == .emailOrPhone || fieldtype == .email {
            textField.autocorrectionType = .no
        }
        textField.textContentType = .oneTimeCode
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isFocus: $isFocus)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isFocus: Bool
        
        init(text: Binding<String>, isFocus: Binding<Bool>) {
            _text = text
            _isFocus = isFocus
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFocus = true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            isFocus =  false
        }
    }
}

struct UITextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocus: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 14)
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isFocus: $isFocus)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        @Binding var isFocus: Bool
        init(text: Binding<String>, isFocus: Binding<Bool>) {
            _text = text
            _isFocus = isFocus
        }
        func textViewDidChangeSelection(_ textView: UITextView) {
            text = textView.text ?? ""
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            isFocus = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            isFocus =  false
        }
    }
}
