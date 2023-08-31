//
//  DateSelectionView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import SwiftUI

struct DateSelectionView: View {

    @Binding var selectedDate: Date
    @Binding var startDate: Date

    @StateObject var viewModel: DateSelectionViewModel

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(viewModel.icon)
                Text(viewModel.title)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
                .frame(maxHeight: .infinity)

            Text(viewModel.dateString)
                .foregroundColor(.black)
                .padding(.leading)
                .overlay {
                    DatePicker(viewModel.title,
                               selection: $selectedDate,
                               in: startDate...,
                               displayedComponents: [.date])
                    .blendMode(.destinationOver)
                    .foregroundColor(.black)
                    .onChange(of: selectedDate) { newValue in
                        viewModel.updateDate(newValue)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
        .frame(height: 50, alignment: .leading)
    }
}
