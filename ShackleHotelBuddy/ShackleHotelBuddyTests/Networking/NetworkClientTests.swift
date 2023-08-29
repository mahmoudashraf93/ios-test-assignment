//
//  NetworkClientTests.swift
//  ShackleHotelBuddyTests
//
//  Created by Mahmoud Ashraf on 29/08/2023.
//

import XCTest
@testable import ShackleHotelBuddy

final class NetworkClientTests: XCTestCase {
    let mockURLSession = URLSessionMock()

    enum TestEndpoint: Endpoint {
        case test
        var baseURL: String {
            "baseURL"
        }

        var path: String {
            "path"
        }

        var body: Encodable? {
            nil
        }

        var headers: [String : String] {
            [:]
        }

        var method: HTTPMethod {
            .post
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenSessionThrowsError_CorrectErrorIsThrown() async {
        mockURLSession.error = NetworkError.invalidURL
        let sut = NetworkClient(session: mockURLSession)

        do {
            let _: Property = try await sut.sendRequest(TestEndpoint.test)
            XCTFail("Should throw an error")
        } catch  {
            XCTAssertEqual(error as? NetworkError, .invalidURL)
        }
    }

    func testWhenEmptyResponse_NoResponseErrorIsThrown() async {
        mockURLSession.result = (Data(), URLResponse())

        let sut = NetworkClient(session: mockURLSession)

        do {
            let _: Property = try await sut.sendRequest(TestEndpoint.test)
            XCTFail("Should throw an error")
        } catch  {
            XCTAssertEqual(error as? NetworkError, .noResponse)
        }
    }

    func testWhenStatusCodeAbove299_UnexpectedStatusCodeErrorIsThrown() async {
        let response = HTTPURLResponse(
            url: URL(string: Constants.API.baseURL)!,
            statusCode: 305,
            httpVersion: "HTTP/1.1",
            headerFields: nil)!

        mockURLSession.result = (Data(), response)

        let sut = NetworkClient(session: mockURLSession)

        do {
            let _: Property = try await sut.sendRequest(TestEndpoint.test)
            XCTFail("Should throw an error")
        } catch  {
            XCTAssertEqual(error as? NetworkError, .unexpectedStatusCode)
        }
    }

    func testWhenStatus200_DecodingErrorIsThrown() async {
        let response = HTTPURLResponse(
            url: URL(string: Constants.API.baseURL)!,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: nil)!

        mockURLSession.result = (Data(), response)

        let sut = NetworkClient(session: mockURLSession)

        do {
            let _: Property = try await sut.sendRequest(TestEndpoint.test)
            XCTFail("Should throw an error")
        } catch  {
            XCTAssertEqual(error as? NetworkError, .decode)
        }
    }

    func testWhenCorrectResponse_ShouldParseCorrectly() async {
        let response = HTTPURLResponse(
            url: URL(string: Constants.API.baseURL)!,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: nil)!

        let file = Bundle(for: type(of: self)).path(forResource: "Response_Valid.json", ofType: nil) ?? ""
        let url = URL(fileURLWithPath: file)

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Invalid file")
        }
        mockURLSession.result = (data, response)

        let sut = NetworkClient(session: mockURLSession)

        do {
            let response: PropertiesResponse = try await sut.sendRequest(TestEndpoint.test)
            XCTAssertNotNil(response)
        } catch  {
            XCTFail("Should Not throw an error")
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
