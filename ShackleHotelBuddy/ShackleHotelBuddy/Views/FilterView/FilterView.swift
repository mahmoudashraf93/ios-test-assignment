//
//  FilterView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import SwiftUI

class Filter: ObservableObject, Equatable {
    let priceRange: ClosedRange<Int>?
    let rating: Int?


    init(priceRange: ClosedRange<Int>?, rating: Int?) {
        self.priceRange = priceRange
        self.rating = rating
    }

    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.priceRange == rhs.priceRange && lhs.rating == rhs.rating
    }
}

struct FilterView: View {
    @State var sliderPosition: ClosedRange<Float> = 0...300
    @State var rate: Int = 4

    @State var min: Int = 0
    @State var max: Int = 300

    @Binding var appliedFilter: Filter

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            header
            priceRangeView
            ratingView
            Spacer()
            footer
        }
    }

    var header: some View {
        ZStack(alignment: .leading) {
            Text("Filters")
                .frame(maxWidth: .infinity)

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

        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }

    var footer: some View {
        VStack(spacing: 16) {
            Divider()

            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                }

                Spacer()

                Button {
                    appliedFilter = .init(priceRange: min...max,
                                          rating: rate)
                    dismiss()
                } label: {
                    Text("Apply filters")
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 26)
                        .background(Color(red: 44/255,
                                          green: 171/255,
                                          blue: 177/255))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
    }

    var ratingView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Minimum rating")
            RatingView(rating: $rate)
        }
        .padding(.horizontal)
    }

    var priceRangeView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Price range")
            HStack(spacing: 16){
                Text("\(min)")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 109/255,
                                           green: 109/255,
                                           blue: 109/255))
                    .frame(width: 56, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 221/255,
                                          green: 221/255,
                                          blue: 221/255),
                                    lineWidth: 1)
                    )

                RangedSliderView(value: $sliderPosition, bounds: 0...1500)
                    .frame(height: 40)
                Text("\(max)")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 109/255,
                                           green: 109/255,
                                           blue: 109/255))
                    .frame(width: 56, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 221/255,
                                          green: 221/255,
                                          blue: 221/255),
                                    lineWidth: 1)
                    )
            }
            .onChange(of: sliderPosition) { newValue in
                min = Int(newValue.lowerBound)
                max = Int(newValue.upperBound)
            }
        }
        .padding(.horizontal)
    }
}
