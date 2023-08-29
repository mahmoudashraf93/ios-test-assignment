//
//  HotelListView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import SwiftUI

struct HotelListView: View {
    @StateObject var viewModel: HotelListViewModel = HotelListViewModel()
    @State var isShowingFilter: Bool = false
    @Binding var isShowing: Bool
    var body: some View {
        VStack {
            header
            if viewModel.hotels.isEmpty {
                Spacer()
                ProgressView()
                    .task {
//                        await viewModel.fetchHotels()
                    }
                Spacer()
            } else {
                List(viewModel.hotels) { hotel in
                    HotelRow(viewModel: .init(property: hotel))
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)

            }
        }
    }

    var header: some View {
        HStack {
            Button {
                isShowing = false
            } label: {
                Image("icons/close")
            }
            .foregroundColor(.black)
            .padding(6)
            .background(Color(red: 221/255,
                              green: 221/255,
                              blue: 221/255))
            .clipShape(Circle())
            .frame(width: 32,
                   height: 32)

            Spacer()
            Text("Search results")

            Spacer()
            NavigationLink(destination: FilterView(isShowing: $isShowingFilter).navigationBarHidden(true),
                           isActive: $isShowingFilter) {
                Image("icons/discover_tune")
                    .foregroundColor(.black)
                    .padding(6)
                    .background(Color(red: 221/255,
                                      green: 221/255,
                                      blue: 221/255))
                    .clipShape(Circle())
                    .frame(width: 32,
                           height: 32)
            }
        }
        .padding(.horizontal)
    }
}
