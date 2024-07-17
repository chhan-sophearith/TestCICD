//
//  CustomDatePickerView.swift
//  InfoWebiOS
//
//  Created by lyborey on 22/1/24.
//

import SwiftUI

struct CustomDatePickerView: View {
    var matchType: String?
    var selectedDate: String
    @Binding var tempDate: Date
    @Binding var showDatePicker: Bool
    var action: () -> Void
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.5)
                .onTapGesture {
                    tempDate = Utilize.getStringToDate(selectedDate)
                    showDatePicker = false
                }
            VStack(spacing: 0) {
                HStack {
                    Button {
                        tempDate = Utilize.getStringToDate(selectedDate)
                        showDatePicker = false
                    } label: {
                        Text(mobileCancel.localizable)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button {
                        action()
                    } label: {
                        Text(mobileDone.localizable)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                Divider()
            
                if matchType == "results" {
                    DatePicker("", selection: $tempDate, in: ...Date(),
                               displayedComponents: [.date])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .environment(\.locale, Locale(identifier: UserPreference.shared.getLanguageCode()))
                } else if matchType == "fixtures" {
                    DatePicker("", selection: $tempDate, in: Date()...,
                               displayedComponents: [.date])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .environment(\.locale, Locale(identifier: UserPreference.shared.getLanguageCode()))
                } else {
                    DatePicker("", selection: $tempDate,
                               displayedComponents: [.date])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .environment(\.locale, Locale(identifier: UserPreference.shared.getLanguageCode()))
                }
                Spacer()
            }
            .frame(height: 300)
            .background(Color.sheetBackground)
        }
        .ignoresSafeArea()
        .background(TransparentBlurView())
    }
}
