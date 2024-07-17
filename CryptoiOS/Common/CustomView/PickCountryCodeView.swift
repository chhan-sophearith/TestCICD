//
//  PickCountryCodeView.swift
//  InfoWebiOS
//
//  Created by lyborey on 6/12/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PickCountryCodeView: View {
    @Binding var isPresentCountry: Bool
    var onSelectCountry: (String) -> Void
    
    @State var searchCode: String = ""
//    @State var countryFilter: [Country] = []
    var body: some View {
        VStack {

//            CustomNavigation(title: mobileSelectCountry.localizable, background: Color.mainColor, trailing: EmptyView()) {
//                isPresentCountry = false
//            }

//            if let country = ConfigurationDataManager.shared.mainData?.countries {
//                VStack {
//                    CustomTextField(
//                        text: $searchCode,
//                        placeHolder: "",
//                        content: Button(action: {}, label: {
//                        Image(systemName: searchCode == "" ? "magnifyingglass" : "xmark.circle.fill")
//                            .foregroundColor(.commonGray)
//                        })) { _ in
//                            countryFilter = searchCode == "" ? country : country.filter { $0.name!.lowercased().contains(searchCode.lowercased()) }
//                        }
//                    .padding(16)
//                    ScrollView(showsIndicators: false) {
//                        ForEach(searchCode == "" ? country : countryFilter, id: \.id) { item in
//                            Group {
//                                Button {
//                                    onSelectCountry(item.idd ?? "")
//                                    isPresentCountry = false
//                                } label: {
//                                    HStack(spacing: 16) {
//                                        WebImage(url: URL(string: item.flag ?? ""))
//                                            .placeholder(
//                                                Image(systemName: "photo")
//                                                    .resizable()
//                                            )
//                                            .resizable()
//                                            .frame(width: 40, height: 40)
//                                            .cornerRadius(20)
//                                        TextSwiftUI(title: item.name ?? "")
//                                        Spacer()
//                                        TextSwiftUI(title: item.idd ?? "")
//                                    }
//                                    .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
//                                }
//                                Divider()
//                            }
//                        }
//                    }
//                }
//                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 500 : UIScreen.screenWidth)
//            }
            Spacer()
        }
    }
}
