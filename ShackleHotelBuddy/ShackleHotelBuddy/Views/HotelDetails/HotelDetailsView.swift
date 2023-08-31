//
//  HotelDetailsView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import SwiftUI

class HotelDetailsViewModel: ObservableObject {
    private let service: PropertiesServiceProtocol
    private let propertyID: String

    @Published var property: Property?

    var name: String {
        property?.name ?? ""
    }
    var rating: Double? {
        property?.reviews?.score
    }

    var city: String {
        property?.neighborhood?.name ?? ""
    }

    var price: String {
        property?.price?.lead.formatted ?? ""
    }

    var priceText: String {
        property?.price?.priceMessages.first?.value ?? ""
    }
    var imageURL: URL? {
        URL(string: property?.propertyImage?.image.url ?? "")
    }

    init(service: PropertiesServiceProtocol = MockPropertiesService(expectedError: nil, propertyDetailResponse: Property.mock, propertiesResponse: nil),
         propertyID: String) {
        self.service = service
        self.propertyID = propertyID
        Task {
            self.property = try! await service.propertyDetail(for: propertyID)
        }
    }
}

struct HotelDetailsView: View {
    @ObservedObject var viewModel: HotelDetailsViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            if viewModel.property == nil {
                ProgressView()
            } else {
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
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                                Spacer()
                                if let hotelRating = viewModel.rating {
                                    HStack {
                                        Image("icons/grade")
                                        Text(hotelRating.formatted())
                                    }
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(viewModel.city)
                                    .font(.system(size: 14))
                                    .foregroundColor(.greyTextColor)
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
}


struct HotelDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HotelDetailsView(viewModel: .init(propertyID: ""))
    }
}
