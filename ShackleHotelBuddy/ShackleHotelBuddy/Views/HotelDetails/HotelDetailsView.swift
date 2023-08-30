//
//  HotelDetailsView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import SwiftUI

struct HotelDetailsView: View {
    let viewModel: HotelRowViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 24) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            AsyncImage(url: viewModel.imageURL) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                        )
                        .cornerRadius(16)
                        .ignoresSafeArea(.all, edges: .top)
                        .frame(height: 240)
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.name)
                                .fontWeight(.bold)
                            Spacer()
                            HStack {
                                Image("icons/grade")
                                Text(viewModel.rating.formatted())
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(viewModel.city)
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 109/255,
                                                       green: 109/255,
                                                       blue: 109/255))
                            HStack(spacing: 2) {
                                Text(viewModel.price)
                                    .fontWeight(.bold)
                                Text(viewModel.priceText)
                            }
                            .font(.system(size: 14))
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Button {
                    dismiss()
                } label: {
                    Image("icons/arrow_back")
                }
                .foregroundColor(.black)
                .padding(6)
                .background(.white)
                .clipShape(Circle())
                .frame(width: 32,
                       height: 32)
                .offset(x: 16)
            }
            Spacer()
        }
    }
}

//
//struct HotelDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelDetailsView()
//    }
//}
