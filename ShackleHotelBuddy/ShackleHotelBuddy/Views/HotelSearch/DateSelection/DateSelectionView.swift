//
//  DateSelectionView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import SwiftUI

struct DateSelectionView: View {
    @Binding var startDate: Date

    @StateObject var viewModel: DateSelectionViewModel

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(viewModel.icon)
                Text(viewModel.title)
                    .foregroundColor(.greyTextColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
                .frame(maxHeight: .infinity)

            Text(viewModel.dateString)
                .foregroundColor(.greyTextColor)
                .padding(.leading)
                .overlay {
                    DatePicker(viewModel.title,
                               selection: $viewModel.date,
                               in: startDate...,
                               displayedComponents: [.date])
                    .blendMode(.destinationOver)
                    .foregroundColor(.black)
                    .onChange(of: viewModel.date) { newValue in
                        viewModel.updateDate(newValue)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .frame(height: 50, alignment: .leading)
    }
}
