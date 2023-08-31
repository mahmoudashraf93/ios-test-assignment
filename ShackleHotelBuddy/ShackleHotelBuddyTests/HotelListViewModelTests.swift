//
//  HotelListViewModelTests.swift
//  ShackleHotelBuddyTests
//
//  Created by Mahmoud Ashraf on 31/08/2023.
//

import XCTest
@testable import ShackleHotelBuddy

final class HotelListViewModelTests: XCTestCase {
    var propertiesServiceMock: MockPropertiesService!

    override func setUp() {
        super.setUp()
        propertiesServiceMock = MockPropertiesService()
    }

    func testWhenValidResponse_hotelsIsSetCorrectly() async throws {
        // Should move this to a class JSONFIleLoader or something
        let file = Bundle(for: type(of: self)).path(forResource: "Response_Valid.json", ofType: nil) ?? ""
        let url = URL(fileURLWithPath: file)

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Invalid file")
        }

        let expectedResponse = try! JSONDecoder().decode(PropertiesResponse.self, from: data)

        propertiesServiceMock.propertiesResponse = expectedResponse

        let sut = HotelListViewModel(service: propertiesServiceMock,
                                     listParameters: .init(checkInDate: Date(),
                                                           checkOutDate: Date(),
                                                           adults: 2,
                                                           children: 0,
                                                           minRating: 2))

        await sut.fetchHotels()

        XCTAssertFalse(sut.hotels.isEmpty)
    }
}
