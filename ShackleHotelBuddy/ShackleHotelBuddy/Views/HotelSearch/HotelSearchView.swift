//
//  HotelSearchView.swift
//  ShackleHotelBuddy
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import SwiftUI

struct HotelSearchView: View {
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date()
    @State private var numberOfAdults = 1
    @State private var numberOfChildren = 0

    @StateObject var viewModel = HotelSearchViewModel()

    @State private var isShowingDetail = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Image("images/background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 32) {
                    VStack(spacing: 48){
                        HStack {
                            Image("images/logo")
                                .frame(height: 32)
                            Spacer()
                            Image("icons/person")
                                .background(.gray)
                                .frame(width: 32, height: 32)
                                .cornerRadius(10)
                        }

                        Text("Select guests, date and time") // should be localized
                            .foregroundColor(.white)
                            .font(.system(size: 44)) // Should be custom font
                    }
                    VStack(spacing: 0) {
                        DateSelectionView(selectedDate: $checkInDate,
                                      startDate: .constant(Date()),
                                      viewModel: viewModel.checkInDateViewModel)
                        Divider()
                        DateSelectionView(selectedDate: $checkOutDate,
                                      startDate: $checkInDate,
                                      viewModel: viewModel.checkOutDateViewModel)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8,
                                         style: .continuous)
                        .foregroundColor(.white)
                    )

                    Spacer()

                    NavigationLink(destination: HotelListView(isShowing: $isShowingDetail).navigationBarHidden(true),
                                   isActive: $isShowingDetail) {
                        Text("Send")
                            .foregroundColor(.white)
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

struct HotelSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HotelSearchView()
    }
}
class DateSelectionViewModel: ObservableObject {
    var icon: String
    var title: String
    @Published var dateString: String = "DD / MM / YYYY"

    init(icon: String,
         title: String) {
        self.icon = icon
        self.title = title
    }

    func updateDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        dateString = dateFormatter.string(from: date)
    }
}
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

struct AsyncButton<Label: View>: View {
    var action: () async -> Void
    @ViewBuilder var label: () -> Label

    @State private var isPerformingTask = false

    var body: some View {
        Button(
            action: {
                isPerformingTask = true

                Task {
                    await action()
                    isPerformingTask = false
                }
            },
            label: {
                ZStack {
                    // We hide the label by setting its opacity
                    // to zero, since we don't want the button's
                    // size to change while its task is performed:
                    label().opacity(isPerformingTask ? 0 : 1)

                    if isPerformingTask {
                        ProgressView()
                    }
                }
            }
        )
        .disabled(isPerformingTask)
    }
}
