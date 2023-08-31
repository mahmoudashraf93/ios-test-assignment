//
//  HotelRow.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import SwiftUI

struct HotelRowViewModel {
    let name: String
    let rating: Double?
    let city: String
    let price: String
    let priceText: String
    let imageURL: URL?

    init (property: Property) {
        self.name = property.name ?? ""
        self.imageURL = URL(string: property.propertyImage?.image.url ?? "")
        self.rating = property.reviews?.score
        self.price = property.price?.lead.formatted ?? ""
        self.priceText = property.price?.priceMessages.first?.value ?? ""
        self.city = property.neighborhood?.name ?? ""
    }
}

struct HotelRow: View {
    let viewModel: HotelRowViewModel

    var body: some View {
        VStack {
            AsyncImage(url: viewModel.imageURL) { image in
                image
                    .resizable()
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading){
                HStack {
                    Text(viewModel.name)
                        .fontWeight(.bold)
                    Spacer()
                    if let rating = viewModel.rating {
                        HStack {
                            Image("icons/grade")
                            Text(rating.formatted())
                        }
                    }
                }
                Text(viewModel.city)
                HStack(spacing: 2) {
                    Text(viewModel.price)
                        .fontWeight(.bold)
                    Text(viewModel.priceText)
                }
            }
        }
    }
}

//struct HotelRow_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelRow(viewModel: .init(name: "Hotel",
//                                  rating: 4.5,
//                                  city: "Cairo, Egypt",
//                                  price: "100$",
//                                  priceText: "night",
//                                  imageURL: URL(string: "https://images.trvl-media.com/lodging/10000000/9500000/9493000/9492953/6765e39b.jpg?impolicy=resizecrop&rw=455&ra=fit")!))
//    }
//}
