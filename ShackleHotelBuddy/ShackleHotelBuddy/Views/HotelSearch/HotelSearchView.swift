//
//  HotelSearchView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import SwiftUI

struct HotelSearchView: View {
    @StateObject var viewModel = HotelSearchViewModel()
    @State private var isValid = false

    var body: some View {
        NavigationView {
                ZStack(alignment: .top) {
                    Image("images/background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    ScrollView {
                    VStack(spacing: 32) {
                        VStack(spacing: 48){
                            HStack {
                                Image("images/logo")
                                    .frame(height: 32)
                                Spacer()
                                Image("images/profile")
                                    .background(.gray)
                                    .frame(width: 32, height: 32)
                                    .cornerRadius(10)
                            }

                            Text("Select guests, date and time") // should be localized
                                .foregroundColor(.white)
                                .font(.system(size: 44)) // Should be custom font
                        }
                        VStack(spacing: 0) {
                            DateSelectionView(startDate: .constant(Date()),
                                              viewModel: viewModel.checkInDateViewModel)
                            Divider()
                            DateSelectionView(startDate: $viewModel.checkInDateViewModel.date,
                                              viewModel: viewModel.checkOutDateViewModel)
                            Divider()
                            NumberSelectionView(selectedNumber: $viewModel.adultsCountViewModel.number,
                                                viewModel: viewModel.adultsCountViewModel)
                            Divider()
                            NumberSelectionView(selectedNumber: $viewModel.childrenCountViewModel.number,
                                                viewModel: viewModel.childrenCountViewModel)
                        }
                        .background(.white)
                        .cornerRadius(8)

                        recentSearchesView

                        Spacer()


                        NavigationLink(destination: HotelListView(viewModel: viewModel.hotelListViewModel).navigationBarHidden(true)) {
                            Text("Search")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .background(Color.primaryColor)
                                .cornerRadius(20)
                        }
                        Spacer()
                    }
                    .padding(.top, UIApplication.shared.safeAreaTop + 16)
                    .padding(.horizontal, 16)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }

    var recentSearchesView: some View {
        // The values are hardcoded for the sake of the THA
        // But what I would do is the following
        // In case there isn't a way to fetch the recent search from the server
        // and we are willing to lose multi device support for
        // I would store the ListParameters in a UserDefaults key
        // and show this view only if that key's value is available
        //
        // and when tapped I would go fetch the list with that stored ListParameters object
        VStack(alignment: .leading) {
            Text("Recent searches")
                .foregroundColor(.white)

            HStack {
                Image("icons/manage_history")
                    .renderingMode(.original)
                Divider()
                    .frame(maxHeight: .infinity)
                Text("03  07 / 2024 - 08 / 07 / 2024")
                    .foregroundColor(.greyTextColor)
                Text("1 adult, 0 children")
                    .foregroundColor(.greyTextColor)
            }
            .font(.system(size: 12))
            .padding()
            .frame(height: 48)
            .background(.white)
            .cornerRadius(8)
        }
    }
}

struct HotelSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HotelSearchView()
    }
}
