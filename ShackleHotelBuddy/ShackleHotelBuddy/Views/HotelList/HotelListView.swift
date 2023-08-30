//
//  HotelListView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import SwiftUI

struct HotelListView: View {
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel: HotelListViewModel = HotelListViewModel()
    var body: some View {
        VStack {
            header
            if viewModel.hotels.isEmpty {
                Spacer()
                ProgressView()
                    .task {
                        //                        await viewModel.fetchHotels()
                    }
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.hotels.indices, id: \.self) { index in
                            NavigationLink(destination: HotelDetailsView(viewModel: .init(property: viewModel.hotels[index])).navigationBarHidden(true)) {
                                HotelRow(viewModel: .init(property: viewModel.hotels[index]))
                                    .padding(.horizontal, 16)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            Spacer()
        }
    }

    var header: some View {
        HStack {
            Button {
                dismiss()
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
            NavigationLink(destination: FilterView().navigationBarHidden(true)) {
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
