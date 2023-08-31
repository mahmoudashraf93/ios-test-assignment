//
//  NumberSelectionView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 30/08/2023.
//

import SwiftUI

struct NumberSelectionView: View {
    @Binding var selectedNumber: Int
    @StateObject var viewModel: NumberSelectionViewModel

    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(viewModel.icon)
                Text(viewModel.title)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()

            Picker(selection: $viewModel.number) {
                ForEach(0...10, id: \.self) { number in
                    Text("\(number)")
                }
            } label: {
                Text("\(viewModel.number)")
            }
            .pickerStyle(.automatic)
            .tint(.black)
            .frame(maxWidth: .infinity, alignment: .leading)

        }
        .padding(.horizontal)
        .frame(height: 50, alignment: .leading)
    }
}

struct NumberSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NumberSelectionView(selectedNumber: .constant(1),
                            viewModel: .init(icon: "",
                                             title: "",
                                             number: 1))
    }
}
